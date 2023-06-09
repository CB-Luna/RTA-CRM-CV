import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart' hide State;
import 'package:pluto_grid/pluto_grid.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/accounts/quotes_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuotesProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  int pageRowCount = 10;
  int page = 1;

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
        /*  stateManager!.setFilter((element) {
          return element.cells.entries.elementAt(12).value.value.contains('Margin Positive');
        }); */
        break;
      case 2:
        await getQuotes('Sen. Exec. Validate');
        /*  stateManager!.setFilter((element) {
          return element.cells.entries.elementAt(12).value.value.contains('Margin Positive');
        }); */
        break;
      case 3:
        await getQuotes('Finance Validate');
        /* stateManager!.setFilter((element) {
          return element.cells.entries.elementAt(12).value.value.contains('Finance Validate');
        }); */
        break;
      case 4:
        await getQuotes('Accepted');
        /* stateManager!.setFilter((element) {
          return element.cells.entries.elementAt(12).value.value.contains('Finance Validate');
        }); */
        break;
      case 5:
        await getQuotes('Canceled');
        /* stateManager!.setFilter((element) {
          return element.cells.entries.elementAt(12).value.value.contains('Finance Validate');
        }); */
        break;
      case 6:
        await getQuotes('Closed');
        /* stateManager!.setFilter((element) {
          return element.cells.entries.elementAt(12).value.value.contains('Finance Validate');
        }); */
        break;
      case 7:
        await getQuotes(null);
        /* stateManager!.setFilter((element) {
          return element.cells.entries.elementAt(12).value.value.contains('Finance Validate');
        }); */
        break;
    }

    notifyListeners();
  }

  Future<void> getQuotes(String? status) async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      late var res;
      if (status != null) {
        res = await supabaseCRM.from('quotes_view').select().eq('status', status);
      } else {
        res = await supabaseCRM.from('quotes_view').select();
      }

      if (res == null) {
        log('Error en getUsuarios()');
        return;
      }
      List<Quotes> quotes = (res as List<dynamic>).map((quote) => Quotes.fromJson(jsonEncode(quote))).toList();

      rows.clear();
      for (Quotes quote in quotes) {
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: quote.id),
              'NAME_Column': PlutoCell(value: quote.nameLead),
              'TOTAL_Column': PlutoCell(value: quote.total),
              'MARGIN_Column': PlutoCell(value: quote.margin),
              'VENDOR_Column': PlutoCell(value: quote.nameVendor),
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
    } catch (e) {
      log('Error en getQuotes() - $e');
    }

    notifyListeners();
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
