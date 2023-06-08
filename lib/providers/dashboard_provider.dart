import 'package:flutter/material.dart' hide State;
import 'package:pluto_grid/pluto_grid.dart';

class DashboardProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
////////////////////////////////////////////////////////////////////////////
  DashboardProvider() {
    updateState();
  }
  Future<void> updateState() async {}
}
