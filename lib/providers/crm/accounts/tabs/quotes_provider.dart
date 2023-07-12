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

//import 'package:rta_crm_cv/src/generated/x2_mysql.pbgrpc.dart';
//import 'package:rta_crm_cv/grpc_web.dart';
//import 'package:grpc/grpc_web.dart';

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
    await setIndex(0);
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
    true, //All
    false, //Sales Form
    false, //Sen. Exec. Validate
    false, //Finance Validate
    false, //Engineer Validate
    false, //Rejected
    false, //Closed
    false, //Approved
    false, //Order Created
    false, //Network Cross-Connected
    false, //Network Issues
    false, //Ticket Closed
    false, //Canceled
    false, //Sales
    false, //Canceled-Rejected
    false, //Networks
  ];

  Future setIndex(int index) async {
    for (var i = 0; i < indexSelected.length; i++) {
      indexSelected[i] = false;
    }
    indexSelected[index] = true;

    switch (index) {
      case 0:
        await getQuotes(null);

        break;
      case 1:
        await getQuotes(1);
        break;
      case 2:
        await getQuotes(2);
        break;
      case 3:
        await getQuotes(3);
        break;
      case 4:
        await getQuotes(4);
        break;
      case 5:
        await getQuotes(5);
        break;
      case 6:
        await getQuotes(6);
        break;
      case 7:
        await getQuotes(7);
        break;
      case 8:
        await getQuotes(8);
        break;
      case 9:
        await getQuotes(9);
        break;
      case 10:
        await getQuotes(10);
        break;
      case 11:
        await getQuotes(11);
        break;
      case 12:
        await getQuotes(12);
        break;
      case 13:
        await getQuotes(13); //2-3-4
        break;
      case 14:
        await getQuotes(14); //12-5
        break;
      case 15:
        await getQuotes(15); //9-10
        break;
    }

    notifyListeners();
  }

  Future<void> getX2CRMQuotes() async {
    var headers = {
      'Authorization': 'Basic YWxleGM6NW1saDM5UjhQUVc4WnI3TzhDcGlPSDJvZE1xaGtFOE8=',
      //'Cookie': 'PHPSESSID=u3lgismtbbamh7g3k6b8dqteuk; YII_CSRF_TOKEN=Z2VybTVsZERNcV9faDVSUlE1VFRZeHk3WmNUWmRiSEMSMv7x7artFlmFwAp6GLyf7Qsi4oYOGXtsrcYz02xGJg%3D%3D'
    };
    var request = http.Request(
        'GET', Uri.parse('http://34.130.182.108/X2CRM-master/x2engine/index.php/api2/Quotes'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      x2crmQuotes.clear();

      var res = jsonDecode(await response.stream.bytesToString());

      x2crmQuotes =
          (res as List<dynamic>).map((quote) => X2CrmQuote.fromJson(jsonEncode(quote))).toList();
    } else {
      log(response.reasonPhrase.toString());
    }
  }

  Future<void> getQuotes(int? status) async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      dynamic res;
      if (status != null) {
        if (currentUser!.isSales && status == 13) {
          res = await supabaseCRM.from('quotes_view').select().or(
                'id_status.eq.4,id_status.eq.2,id_status.eq.3',
              );
        } else if (currentUser!.isSales && status == 14) {
          res = await supabaseCRM.from('quotes_view').select().or(
                'id_status.eq.5,id_status.eq.12',
              );
        } else if (currentUser!.isSales && status == 15) {
          res = await supabaseCRM.from('quotes_view').select().or(
                'id_status.eq.9,id_status.eq.10',
              );
        } else if (currentUser!.isOpperations && status == 15) {
          res = await supabaseCRM.from('quotes_view').select().or(
                'id_status.eq.9,id_status.eq.10',
              );
        } else {
          res = await supabaseCRM.from('quotes_view').select().eq('id_status', status);
        }
      } else {
        if (currentUser!.isSales) {
          res = await supabaseCRM.from('quotes_view').select();
        } else if (currentUser!.isSenExec) {
          res = await supabaseCRM
              .from('quotes_view')
              .select()
              .eq('id_status', 2); //Sen. Exec. Validate
        } else if (currentUser!.isFinance) {
          res =
              await supabaseCRM.from('quotes_view').select().eq('id_status', 3); //Finance Validate
        } else if (currentUser!.isOpperations) {
          res = await supabaseCRM.from('quotes_view').select().or(
                'id_status.eq.4,id_status.eq.7,id_status.eq.9,id_status.eq.10,id_status.eq.11',
              ); //Engineer Validate, Approved, Network Cross-Connect, Network Issues, id_status.eq.Ticket Closed,
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
              'ORDER_Column':
                  PlutoCell(value: ' ${quote.orderInfo.type} ${quote.orderInfo.orderType}'),
              'DESCRIPTION_Column': PlutoCell(value: quote.items.first.lineItem),
              'DATACENTER_Column': PlutoCell(value: quote.orderInfo.dataCenterLocation),
              'PROBABILITY_Column': PlutoCell(value: quote.leadProbability),
              'CLOSED_Column': PlutoCell(value: quote.expectedClose),
              'ASSIGNED_Column': PlutoCell(value: quote.assignedTo),
              'LAST_Column': PlutoCell(value: quote.updatedAt),
              'ID_STATUS_Column': PlutoCell(value: quote.idStatus),
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

    await x2MySQL();
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
  //////////////////////////GRPC//////////////////////////
  ////////////////////////////////////////////////////////

  Future<void> x2MySQL() async {
    /* final channel = ClientChannel(
      'localhost',
      port: 50051,
      options: ChannelOptions(
        credentials: const ChannelCredentials.insecure(),
        codecRegistry: CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
      ),
    );

    final retriever = RetrieverClient(channel);

    try {
      var response = await retriever.returnData(DataRequest(), options: CallOptions(compression: const GzipCodec()));
      print(response.message);
    } catch (e) {
      print('Caught error: $e');
    }
    await channel.shutdown(); */

    try {
      /* final channel = GrpcWebClientChannel.xhr(Uri.parse('http://localhost:8081'));
      final service = RetrieverClient(channel);

      var result = (await service.returnData(DataRequest())).message;
      print(result); */
    } catch (e) {
      print(e);
    }
  }

  ////////////////////////////////////////////////////////
  //////////////////////////RIVE//////////////////////////
  ////////////////////////////////////////////////////////
}
