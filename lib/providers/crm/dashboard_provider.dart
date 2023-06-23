import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide State;
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/leads_history.dart';

class DashboardCRMProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  bool editmode = false;
  int pageRowCount = 10;
  int page = 1;
  int touchedIndex = -1;
  // grafica esferas
  final maxX = 50.0;
  final maxY = 50.0;
  final radius = 8.0;
  bool showFlutter = true;
  //Radianes grafica barra
  /* LinearGradient get gradientRoja => LinearGradient(
        colors: [
          Colors.red.shade900,
          Colors.red,
          Colors.red.shade100,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
  LinearGradient get gradientAma => LinearGradient(
        colors: [
          Colors.yellow.shade900,
          Colors.yellow,
          Colors.yellow.shade100,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
  LinearGradient get gradientVer => LinearGradient(
        colors: [
          Colors.green.shade900,
          Colors.green,
          Colors.green.shade100,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
 */ ////////////////////////////////////////////////////////////////////////////
  DashboardCRMProvider() {
    updateState();
  }
  var titleGroup = AutoSizeGroup();
  Future<void> updateState() async {
    await getHistory();
  }

  clearAll() {}

//Tabla History Leads
  Future<void> getHistory() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      final res = await supabaseCRM.from('leads_history').select();
      if (res == null) {
        log('Error en getHistory()');
        return;
      }
      List<LeadsHistory> leads = (res as List<dynamic>)
          .map((lead) => LeadsHistory.fromJson(jsonEncode(lead)))
          .toList();

      rows.clear();
      for (LeadsHistory lead in leads) {
        rows.add(
          PlutoRow(
            cells: {
              'ID': PlutoCell(value: lead.id),
              'CREATE_AT': PlutoCell(value: lead.createdAt),
              'USER': PlutoCell(value: lead.user),
              'ACTION': PlutoCell(value: lead.action),
              'DESCRIPTION': PlutoCell(value: lead.description),
              'TABLE': PlutoCell(value: lead.table),
              'ID_TABLE': PlutoCell(value: lead.idTable),
              'NAME': PlutoCell(value: lead.name),
              'ACTIONS_Column': PlutoCell(value: ''),
            },
          ),
        );
      }
      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en gethistory() - $e');
    }

    notifyListeners();
  }

  //Graficas
  BarChartGroupData puntos(
      int x, double y, Color color /* Gradient gradient */) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barsSpace: 20,
      barRods: [
        BarChartRodData(
            fromY: 0,
            toY: y,
            width: 40,
            borderRadius: BorderRadius.circular(15),
            color: color
            //gradient: gradient,
            ),
      ],
    );
  }

//Controladores Paginado Pluto?
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
}
