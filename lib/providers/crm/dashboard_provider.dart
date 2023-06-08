import 'package:flutter/material.dart' hide State;
import 'package:pluto_grid/pluto_grid.dart';

class DashboardCRMProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
////////////////////////////////////////////////////////////////////////////
  DashboardCRMProvider() {
    updateState();
  }
  Future<void> updateState() async {}
}
