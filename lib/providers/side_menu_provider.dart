import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class SideMenuProvider extends ChangeNotifier {
  SideMenuProvider(BuildContext context) {
    loadRiveMenuAssets();
  }

  bool isOpen = true;
  bool forcedOpen = false;

  void checkWindowSize(BuildContext context) {
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
  }

  List<bool> indexSelected = [
    true, //Dashboards 0
    false, //Prospects 1
    false, //Schduling 2
    false, //Network 3
    false, //Quotes 4
    false, //Campaigns 5
    false, //Reports 6
    false, //Inventory 7
    false, //VehicleStatus 8
    false, //DashboardCV 9
    false, //Users 10
    false, //Configuration 11
    false, //Logout 12
  ];

  Future<void> loadRiveMenuAssets() async {
    await dashboardsIconRive();
    await accountsIconRive();
    await schedulingsIconRive();
    await networksIconRive();
    await ticketsIconRive();
    await reportsIconRive();
    await usersIconRive();
    await inventoriesIconRive();
    await monitoryIconRive();
    notifyListeners();
    setIndex(0);
  }

  Future setIndex(int index) async {
    for (var i = 0; i < indexSelected.length; i++) {
      indexSelected[i] = false;
    }
    indexSelected[index] = true;

    setABSelected();

    // notifyListeners();
  }

  setABSelected() {
    iSelectedDashboards?.change(indexSelected[0]);
    iSelectedAccounts?.change(indexSelected[1]);
    iSelectedSchedulings?.change(indexSelected[2]);
    iSelectedNetworks?.change(indexSelected[3]);
    iSelectedTickets?.change(indexSelected[4]);
    iSelectedReports?.change(indexSelected[6]);
    iSelectedUsers?.change(indexSelected[7]);
    iSelectedInventories?.change(indexSelected[10]);
    iSelectedMonitory?.change(indexSelected[11]);
  }

  Artboard? aRDashboards;
  StateMachineController? sMCDashboards;
  SMIInput<bool>? iHoverDashboards;
  SMIInput<bool>? iSelectedDashboards;
  Future<void> dashboardsIconRive() async {
    final ByteData data =
        await rootBundle.load('assets/rive/dashboards_icon.riv');

    final file = RiveFile.import(data);

    final artboard = file.mainArtboard;

    sMCDashboards =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    if (sMCDashboards != null) {
      artboard.addController(sMCDashboards!);

      iHoverDashboards = sMCDashboards!.findInput('isHovered');
      iSelectedDashboards = sMCDashboards!.findInput('isSelected');
    }

    aRDashboards = artboard;
  }

  Artboard? aRAccounts;
  StateMachineController? sMCAccounts;
  SMIInput<bool>? iHoverAccounts;
  SMIInput<bool>? iSelectedAccounts;
  Future<void> accountsIconRive() async {
    final ByteData data =
        await rootBundle.load('assets/rive/accounts_icon.riv');

    final file = RiveFile.import(data);

    final artboard = file.mainArtboard;

    sMCAccounts =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    if (sMCAccounts != null) {
      artboard.addController(sMCAccounts!);

      iHoverAccounts = sMCAccounts!.findInput('isHovered');
      iSelectedAccounts = sMCAccounts!.findInput('isSelected');
    }

    aRAccounts = artboard;
  }

  Artboard? aRSchedulings;
  StateMachineController? sMCSchedulings;
  SMIInput<bool>? iHoverSchedulings;
  SMIInput<bool>? iSelectedSchedulings;
  Future<void> schedulingsIconRive() async {
    final ByteData data =
        await rootBundle.load('assets/rive/schedulings_icon.riv');

    final file = RiveFile.import(data);

    final artboard = file.mainArtboard;

    sMCSchedulings =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    if (sMCSchedulings != null) {
      artboard.addController(sMCSchedulings!);

      iHoverSchedulings = sMCSchedulings!.findInput('isHovered');
      iSelectedSchedulings = sMCSchedulings!.findInput('isSelected');
    }

    aRSchedulings = artboard;
  }

  Artboard? aRNetworks;
  StateMachineController? sMCNetworks;
  SMIInput<bool>? iHoverNetworks;
  SMIInput<bool>? iSelectedNetworks;
  Future<void> networksIconRive() async {
    final ByteData data =
        await rootBundle.load('assets/rive/networks_icon.riv');

    final file = RiveFile.import(data);

    final artboard = file.mainArtboard;

    sMCNetworks =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    if (sMCNetworks != null) {
      artboard.addController(sMCNetworks!);

      iHoverNetworks = sMCNetworks!.findInput('isHovered');
      iSelectedNetworks = sMCNetworks!.findInput('isSelected');
    }

    aRNetworks = artboard;
  }

  Artboard? aRTickets;
  StateMachineController? sMCTickets;
  SMIInput<bool>? iHoverTickets;
  SMIInput<bool>? iSelectedTickets;
  Future<void> ticketsIconRive() async {
    final ByteData data = await rootBundle.load('assets/rive/tickets_icon.riv');

    final file = RiveFile.import(data);

    final artboard = file.mainArtboard;

    sMCTickets =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    if (sMCTickets != null) {
      artboard.addController(sMCTickets!);

      iHoverTickets = sMCTickets!.findInput('isHovered');
      iSelectedTickets = sMCTickets!.findInput('isSelected');
    }

    aRTickets = artboard;
  }

  Artboard? aRInventories;
  StateMachineController? sMCInventories;
  SMIInput<bool>? iHoverInventories;
  SMIInput<bool>? iSelectedInventories;
  Future<void> inventoriesIconRive() async {
    final ByteData data =
        await rootBundle.load('assets/rive/inventories_icon.riv');

    final file = RiveFile.import(data);

    final artboard = file.mainArtboard;

    sMCInventories =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    if (sMCInventories != null) {
      artboard.addController(sMCInventories!);

      iHoverInventories = sMCInventories!.findInput('isHovered');
      iSelectedInventories = sMCInventories!.findInput('isSelected');
    }

    aRInventories = artboard;
  }

  Artboard? aRReports;
  StateMachineController? sMCReports;
  SMIInput<bool>? iHoverReports;
  SMIInput<bool>? iSelectedReports;
  Future<void> reportsIconRive() async {
    final ByteData data = await rootBundle.load('assets/rive/reports_icon.riv');

    final file = RiveFile.import(data);

    final artboard = file.mainArtboard;

    sMCReports =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    if (sMCReports != null) {
      artboard.addController(sMCReports!);

      iHoverReports = sMCReports!.findInput('isHovered');
      iSelectedReports = sMCReports!.findInput('isSelected');
    }

    aRReports = artboard;
  }

  Artboard? aRUsers;
  StateMachineController? sMCUsers;
  SMIInput<bool>? iHoverUsers;
  SMIInput<bool>? iSelectedUsers;
  Future<void> usersIconRive() async {
    final ByteData data = await rootBundle.load('assets/rive/users_icon.riv');

    final file = RiveFile.import(data);

    final artboard = file.mainArtboard;

    sMCUsers = StateMachineController.fromArtboard(artboard, 'State Machine 1');

    if (sMCUsers != null) {
      artboard.addController(sMCUsers!);

      iHoverUsers = sMCUsers!.findInput('isHovered');
      iSelectedUsers = sMCUsers!.findInput('isSelected');
    }

    aRUsers = artboard;
  }

  Artboard? aRMonitory;
  StateMachineController? sMCMonitory;
  SMIInput<bool>? iHoverMonitory;
  SMIInput<bool>? iSelectedMonitory;
  Future<void> monitoryIconRive() async {
    final ByteData data =
        await rootBundle.load('assets/rive/networks_icon.riv');

    final file = RiveFile.import(data);

    final artboard = file.mainArtboard;

    sMCMonitory =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    if (sMCMonitory != null) {
      artboard.addController(sMCInventories!);

      iHoverMonitory = sMCMonitory!.findInput('isHovered');
      iSelectedMonitory = sMCMonitory!.findInput('isSelected');
    }

    aRMonitory = artboard;
  }
}
