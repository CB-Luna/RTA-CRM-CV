// import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rive/rive.dart';

class UsersProvider extends ChangeNotifier {
  bool isOpen = true;
  bool forcedOpen = true;

  Future<void> clearAll() async {
    rows.clear();
    await getUsers();
  }

  /* void checkWindowSize(BuildContext context) {
    if (forcedOpen && MediaQuery.of(context).size.width > 1440) {
      isOpen = true;
    } else {
      if (MediaQuery.of(context).size.width <= 1440) {
        isOpen = false;
      } else {
        isOpen = false;
      }
    }
    //notifyListeners();
  } */

  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  int pageRowCount = 10;
  int page = 1;

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
    // var response = await supabase.from('peticiones_automaticas').select().eq('datos->no_doc_nc', 1).eq('datos->acreedor', 3);

    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      rows.clear();

      // final response = await supabase.rpc('get_gestor_partidas_pull', params: {'busqueda': controllerBusqueda.text}).order(orden, ascending: false);

      // var users = (response as List<dynamic>).map((user) => ModelGestorPull.fromJson(jsonEncode(factura))).toList();
      Random random = Random();

      for (var i = 0; i < 200; i++) {
        int randomNumber = random.nextInt(200);
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: randomNumber.toString()),
              'AVATAR_Column': PlutoCell(value: 'https://i.pravatar.cc/300'),
              'USER_Column': PlutoCell(value: 'Carlos Ramirez'),
              'ROLE_Column': PlutoCell(value: 'Administrator'),
              'EMAIL_Column': PlutoCell(value: 'email@email.com'),
              'MOBILE_Column': PlutoCell(value: '664-614-8974'),
              'STATE_Column': PlutoCell(value: 'Texas'),
              'ACTIONS_Column': PlutoCell(value: ''),
            },
          ),
        );
      }

      if (stateManager != null) {
        stateManager!.setShowLoading(false);
        stateManager!.notifyListeners();
      }
      notifyListeners();
    } catch (e) {
      //log('Error en getPartidasPull() - $e');
    }
  }

  ////////////////////////////////////////////////////////
  //////////////////////////RIVE//////////////////////////
  ////////////////////////////////////////////////////////

  Future<void> loadRiveAssets() async {
    /* await dashboardsIconRive();
    await accountsIconRive();
    await schedulingsIconRive();
    await networksIconRive();
    await ticketsIconRive();
    await inventoriesIconRive();
    await reportsIconRive();
    await usersIconRive();
    notifyListeners();
    setIndex(0); */
  }

  setABSelected() {
    //iSelectedDashboards?.change(indexSelected[0]);
  }

  Artboard? aRDashboards;
  StateMachineController? sMCDashboards;
  SMIInput<bool>? iHoverDashboards;
  SMIInput<bool>? iSelectedDashboards;
  Future<void> dashboardsIconRive() async {
    final ByteData data = await rootBundle.load('assets/rive/dashboards_icon.riv');

    final file = RiveFile.import(data);

    final artboard = file.mainArtboard;

    sMCDashboards = StateMachineController.fromArtboard(artboard, 'State Machine 1');

    if (sMCDashboards != null) {
      artboard.addController(sMCDashboards!);

      iHoverDashboards = sMCDashboards!.findInput('isHovered');
      iSelectedDashboards = sMCDashboards!.findInput('isSelected');
    }

    aRDashboards = artboard;
  }
}
