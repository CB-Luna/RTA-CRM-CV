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
    await getQuotes();
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

  void load() {
    stateManager!.setShowLoading(true);
  }

  Future<void> getQuotes() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      final res = await supabaseCRM.from('quotes').select();

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
              'NAME_Column': PlutoCell(value: quote.orderInfo.dataCenterLocation),
              'PROBABILITY_Column': PlutoCell(value: quote.probability),
              'CLOSED_Column': PlutoCell(value: quote.expCloseDate),
              'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
              'LAST_Column': PlutoCell(value: quote.updatedAt),
              'STATUS_Column': PlutoCell(value: quote.status),
              'ACTIONS_Column': PlutoCell(value: quote.idQuoteOrigin),
            },
          ),
        );
      }

      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getUsuarios() - $e');
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
