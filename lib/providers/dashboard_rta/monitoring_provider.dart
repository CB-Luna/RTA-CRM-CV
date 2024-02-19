import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';

import '../../models/dashboard_rta/ftth.dart';
import '../../models/dashboard_rta/home_and_lots.dart';

class MonitoringDashboardProvider extends ChangeNotifier {
  // Table 1
  PlutoGridStateManager? monthstateManager;
  List<PlutoRow> monthRows = [];

  int pageRowCount = 10;
  int page = 1;

  void setPageSize(String x) {
    switch (x) {
      case 'more':
        if (pageRowCount < monthRows.length) pageRowCount++;
        break;
      case 'less':
        if (pageRowCount > 1) pageRowCount--;
        break;
      default:
        return;
    }
    monthstateManager!.createFooter;
    notifyListeners();
  }

  void setPage(String x) {
    switch (x) {
      case 'next':
        if (page < monthstateManager!.totalPage) page++;
        break;
      case 'previous':
        if (page > 1) page--;
        break;
      case 'start':
        page = 1;
        break;
      case 'end':
        page = monthstateManager!.totalPage;
        break;
      default:
        return;
    }
    monthstateManager!.setPage(page);
    notifyListeners();
  }
}
