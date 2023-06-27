import 'dart:convert';
import 'dart:developer';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart' hide State;
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/functions/date_format.dart';
import 'package:http/http.dart' as http;

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/accounts/quotes_model.dart';
import 'package:rta_crm_cv/models/x2crm/x2crm_quote_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuotesProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<Quotes> quotes = [];
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  int pageRowCount = 10;
  int page = 1;

  List<X2CrmQuote> x2crmQuotes = [];

  QuotesProvider() {
    updateState();
    realTimeSuscription();
  }

  Future<void> updateState() async {
    await getQuotes(null);
  }

  void clearControllers({bool notify = true}) {
    searchController.clear();

    if (notify) notifyListeners();
  }

  void setPageSize(String x) {
    switch (x) {
      case 'more':
        if (pageRowCount < rows.length) pageRowCount++;
        break;
      case 'less':
        if (pageRowCount > 1) pageRowCount--;
        break;
      default:
        return;
    }
    stateManager!.createFooter;
    notifyListeners();
  }

  void setPage(String x) {
    switch (x) {
      case 'next':
        if (page < stateManager!.totalPage) page++;
        break;
      case 'previous':
        if (page > 1) page--;
        break;
      case 'start':
        page = 1;
        break;
      case 'end':
        page = stateManager!.totalPage;
        break;
      default:
        return;
    }
    stateManager!.setPage(page);
    notifyListeners();
  }

  List<bool> indexSelected = [
    false, //Opened 0
    false, //Sen. Exec. Validate 1
    false, //Margin Positive 2
    false, //Finance Validate 3
    false, //Accepted 4
    false, //Canceled 5
    false, //Closed 6
    true, //All 7
  ];

  Future setIndex(int index) async {
    for (var i = 0; i < indexSelected.length; i++) {
      indexSelected[i] = false;
    }
    indexSelected[index] = true;

    switch (index) {
      case 0:
        await getQuotes('Opened');
        /*  stateManager!.setFilter(
          (element) => element.cells['STATUS_Column']!.value.toString() == 'Margin Positive',
        ); */
        break;
      case 1:
        await getQuotes('Margin Positive');
        break;
      case 2:
        await getQuotes('Sen. Exec. Validate');
        break;
      case 3:
        await getQuotes('Finance Validate');
        break;
      case 4:
        await getQuotes('Accepted');
        break;
      case 5:
        await getQuotes('Canceled');
        break;
      case 6:
        await getQuotes('Closed');
        break;
      case 7:
        await getQuotes(null);
        break;
    }

    notifyListeners();
  }

  Future<void> getX2CRMQuotes() async {
    var headers = {
      'Authorization': 'Basic YWxleGM6NW1saDM5UjhQUVc4WnI3TzhDcGlPSDJvZE1xaGtFOE8=',
      //'Cookie': 'PHPSESSID=u3lgismtbbamh7g3k6b8dqteuk; YII_CSRF_TOKEN=Z2VybTVsZERNcV9faDVSUlE1VFRZeHk3WmNUWmRiSEMSMv7x7artFlmFwAp6GLyf7Qsi4oYOGXtsrcYz02xGJg%3D%3D'
    };
    var request = http.Request('GET', Uri.parse('http://34.130.182.108/X2CRM-master/x2engine/index.php/api2/Quotes'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      x2crmQuotes.clear();

      var res = jsonDecode(await response.stream.bytesToString());

      x2crmQuotes = (res as List<dynamic>).map((quote) => X2CrmQuote.fromJson(jsonEncode(quote))).toList();
    } else {
      log(response.reasonPhrase.toString());
    }
  }

  Future<void> getQuotes(String? status) async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      dynamic res;
      if (status != null) {
        res = await supabaseCRM.from('quotes_view').select().eq('status', status);
      } else {
        if (currentUser!.isSales) {
          res = await supabaseCRM.from('quotes_view').select();
          //res = await supabaseCRM.from('quotes_view').select().eq('status', 'Margin Positive').or('margin.lt.22,margin.gt.45');
        } else if (currentUser!.isSenExec) {
          res = await supabaseCRM.from('quotes_view').select().eq('status', 'Opened');
        } else if (currentUser!.isFinance) {
          res = await supabaseCRM.from('quotes_view').select().or('status.eq.Sen. Exec. Validate,status.eq.Margin Positive');
        } else if (currentUser!.isOpperations) {
          res = await supabaseCRM.from('quotes_view').select().eq('status', 'Finance Validate').or('status.eq.Accepted');
        }
      }

      if (res == null) {
        log('Error en getUsuarios()');
        return;
      }
      quotes = (res as List<dynamic>).map((quote) => Quotes.fromJson(jsonEncode(quote))).toList();

      rows.clear();
      for (Quotes quote in quotes) {
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: quote.id),
              'ACCOUNT_Column': PlutoCell(value: quote.account),
              'NAME_Column': PlutoCell(value: quote.organitationName),
              'TOTAL_Column': PlutoCell(value: quote.total),
              'MARGIN_Column': PlutoCell(value: quote.margin),
              'VENDOR_Column': PlutoCell(value: quote.vendorName),
              'ORDER_Column': PlutoCell(value: ' ${quote.orderInfo.type} ${quote.orderInfo.orderType}'),
              'DESCRIPTION_Column': PlutoCell(value: quote.items.first.lineItem),
              'DATACENTER_Column': PlutoCell(value: quote.orderInfo.dataCenterLocation),
              'PROBABILITY_Column': PlutoCell(value: quote.leadProbability),
              'CLOSED_Column': PlutoCell(value: quote.expectedClose),
              'ASSIGNED_Column': PlutoCell(value: quote.assignedTo),
              'LAST_Column': PlutoCell(value: quote.updatedAt),
              'STATUS_Column': PlutoCell(value: quote.status),
              'ACTIONS_Column': PlutoCell(value: quote.idQuoteOrigin),
              'ID_LEAD_Column': PlutoCell(value: quote.idLead),
            },
          ),
        );
      }

      if (stateManager != null) stateManager!.notifyListeners();

      await getX2CRMQuotes();
    } catch (e) {
      log('Error en getQuotes() - $e');
    }

    notifyListeners();
  }

  ////////////////////////////////////////////////////////
  /////////////////////////Export/////////////////////////
  ////////////////////////////////////////////////////////

  Future<void> exportData() async {
    Excel excel = Excel.createExcel();
    Sheet? sheet = excel.sheets[excel.getDefaultSheet()];

    if (sheet == null) return;

    sheet.removeRow(0);

    CellStyle cellStyle = CellStyle(bold: true);

    //Agregar primera linea
    sheet.appendRow([
      'Title',
      'Quotes Report',
      '',
      'User',
      '${currentUser?.name} ${currentUser?.lastName}',
      '',
      'Date',
      dateFormat(DateTime.now(), true),
    ]);

    for (var i = 0; i < 8; i++) {
      sheet.row(0)[i]!.cellStyle = cellStyle;
    }

    //Agregar linea vacia
    sheet.appendRow(['']);

    //Agregar headers
    sheet.appendRow([
      'DataCenter',
      'Vendor',
      'Type',
      'Description',
      'Cost',
      'Taxes',
      'Account Number',
      'Contract Number',
      'Contract Signed',
      'Term',
      'Out of Term',
      'Contact',
      'Phone',
      'Email',
      //'Notes',
    ]);

    for (var i = 0; i < 14; i++) {
      sheet.row(2)[i]!.cellStyle = cellStyle;
    }

    sheet.selectRange(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0),
      end: CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0),
    );

    double cost = 0;
    double tax = 0;

    for (var quote in quotes) {
      cost = cost + quote.cost;
      tax = tax + quote.taxMoney;
      final List<dynamic> excelRow = [
        quote.orderInfo.dataCenterLocation,
        quote.vendorName,
        quote.orderInfo.circuitType,
        quote.items.first.lineItem,
        quote.cost,
        quote.totalPlusTax - quote.total,
        quote.account,
        'Contract',
        'Signed',
        'Term',
        'Out',
        quote.contact,
        quote.phoneNumber,
        quote.email,
      ];
      sheet.appendRow(excelRow);
    }

    //Agregar linea vacia
    sheet.appendRow(['']);

    sheet.appendRow([
      'Total gigFAST Network',
      '',
      '',
      '',
      cost,
      tax,
      cost + tax,
    ]);

    for (var i = 0; i < 7; i++) {
      sheet.row(sheet.rows.length - 1)[i]!.cellStyle = cellStyle;
    }

    //Descargar
    excel.save(fileName: "Quotes_Report_${DateFormat('MMMM_dd_yyyy').format(DateTime.now())}.xlsx");
  }

  ////////////////////////////////////////////////////////
  ////////////////////////RealTime////////////////////////
  ////////////////////////////////////////////////////////

  final myChannel = supabaseCRM.channel('quotes');

  Future<void> realTimeSuscription() async {
    myChannel.on(
        RealtimeListenTypes.postgresChanges,
        ChannelFilter(
          event: 'UPDATE',
          schema: 'crm',
          table: 'quotes',
        ), (payload, [ref]) async {
      await updateState();
    }).subscribe();
  }

  ////////////////////////////////////////////////////////
  //////////////////////////RIVE//////////////////////////
  ////////////////////////////////////////////////////////
}
