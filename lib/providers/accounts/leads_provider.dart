import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart' hide State;
import 'package:pluto_grid/pluto_grid.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/models.dart';

class LeadsProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  int pageRowCount = 10;
  int page = 1;

  LeadsProvider() {
    updateState();
  }

  Future<void> updateState() async {
    rows.clear();
    await getUsers();
  }

  List<bool> tabBar = [
    true,
    false,
    false,
    false,
    false,
  ];

  Future setIndex(int index) async {
    for (var i = 0; i < tabBar.length; i++) {
      tabBar[i] = false;
    }
    tabBar[index] = true;

    notifyListeners();
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

  Future<void> getUsers() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      final res = await supabase.from('users').select().like('name', '%${searchController.text}%');

      if (res == null) {
        log('Error en getUsuarios()');
        return;
      }
      List<User> users = (res as List<dynamic>).map((usuario) => User.fromJson(jsonEncode(usuario))).toList();

      rows.clear();
      for (User user in users) {
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: user.sequentialId),
              'NAME_Column': PlutoCell(value: 'Bob Trent'),
              'AMOUNT_Column': PlutoCell(value: 0),
              'PROBABILITY_Column': PlutoCell(value: null),
              'CLOSED_Column': PlutoCell(value: null),
              'CREATE_Column': PlutoCell(value: DateTime(2023, 4, 5)),
              'LAST_Column': PlutoCell(value: DateTime(2023, 4, 11)),
              'ASSIGNED_Column': PlutoCell(value: 'Frank Befera'),
              'STATUS_Column': PlutoCell(value: 'In Process'),
              'ACTIONS_Column': PlutoCell(value: ''),
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
  //////////////////////////RIVE//////////////////////////
  ////////////////////////////////////////////////////////
}
