import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart' hide State;
import 'package:pluto_grid/pluto_grid.dart';

class DashboardCRMProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  bool editmode = false;
  int pageRowCount = 10;
  int page = 1;
   int touchedIndex = -1;
  LinearGradient get gradientRoja => LinearGradient(
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
////////////////////////////////////////////////////////////////////////////
  DashboardCRMProvider() {
    updateState();
  }
  var titleGroup = AutoSizeGroup();
  Future<void> updateState() async {}
  clearAll(){

  }
  //Graficas
   BarChartGroupData puntos(int x, double y, Gradient gradient) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barsSpace: 20,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: y,
          width: 40,
          borderRadius: BorderRadius.zero,
          gradient: gradient,
        ),
      ],
    );
  }

  /*BarChartGroupData puntosCirculo(int x, double y, Gradient gradient) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barsSpace: 20,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: y,
          width: 40,
          borderRadius: BorderRadius.circular(25),
          gradient: gradient,
        ),
      ],
    );
  }*/
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
