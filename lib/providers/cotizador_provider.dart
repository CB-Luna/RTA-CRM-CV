// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class CotizadorProvider extends ChangeNotifier {
  CotizadorProvider() {
    clearAll();
  }

  clearAll() {
    existingCircuitIDController.clear();
    newCircuitIDController.clear();
    newDataCenterController.clear();
    existingEVCController.clear();

    orderTypesSelectedValue = orderTypesList.first;
    typesSelectedValue = typesList.first;
    dataCenterSelectedValue = dataCentersList.first;
    circuitInfoSelectedValue = circuitInfosList.first;
    evcodSelectedValue = evcodList.first;
    ddosSelectedValue = false;
    bgpSelectedValue = bgpList.first;
    ipAdressSelectedValue = false;
    ipSelectedValue = ipList.first;
    subnetSelectedValue = subnetList.first;

    lineItemCenterController.clear();
    unitPriceController.clear();
    unitCostController.clear();
    quantityController.clear();

    rows.clear();
  }

  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];

  final existingCircuitIDController = TextEditingController();
  final newCircuitIDController = TextEditingController();
  final newDataCenterController = TextEditingController();
  final existingEVCController = TextEditingController();

  late String orderTypesSelectedValue;
  late String typesSelectedValue;
  late String dataCenterSelectedValue;
  late String circuitInfoSelectedValue;
  late String evcodSelectedValue;
  late bool ddosSelectedValue = false; //['Yes', 'No']
  late String bgpSelectedValue;
  late bool ipAdressSelectedValue = false;
  late String ipSelectedValue;
  late String subnetSelectedValue;

  List<String> orderTypesList = ['Internal Circuit', 'External Customer'];
  List<String> typesList = ['New', 'Disconnect', 'Upgrade'];
  List<String> dataCentersList = [
    'Austin - Logix',
    'Austin – Data Foundry',
    'Chicago - Equinix',
    'Chicago - Naperville',
    'Dallas',
    'Denver',
    'Helena',
    'Houston - Logix',
    'Houston – Data Foundry',
    'Salt Lake',
    'San Antonio',
    'Seattle',
    'St. Louis',
    'New',
  ];
  List<String> circuitInfosList = [
    'Provider: ATT, Fiberlight, etc.',
    'NNI',
    'DIA',
    'CIR',
    'Port Size',
    'Multicast Required',
    'Cross-Connect',
    'EVCoD',
  ];
  List<String> evcodList = ['No', 'New', 'Existing EVC'];
  List<String> bgpList = ['No', 'IPv4', 'IPv6', 'Current ASN(s)'];
  List<String> ipList = ['IPv4', 'IPv6'];
  List<String> subnetList = ['No', 'IPv4', 'IPv6'];

  final lineItemCenterController = TextEditingController();
  final unitPriceController = TextEditingController();
  final unitCostController = TextEditingController();
  final quantityController = TextEditingController();

  void selectOT() {
    if (orderTypesSelectedValue == 'Internal Circuit') {
      orderTypesSelectedValue = orderTypesList[1];
    } else {
      orderTypesSelectedValue = orderTypesList[0];
    }
    notifyListeners();
  }

  void selectType(String selected) {
    typesSelectedValue = selected;
    notifyListeners();
  }

  void selectDataCenter(String selected) {
    dataCenterSelectedValue = selected;
    notifyListeners();
  }

  void selectCircuitInfo(String selected) {
    circuitInfoSelectedValue = selected;
    notifyListeners();
  }

  void selectEVCOD(String selected) {
    evcodSelectedValue = selected;
    notifyListeners();
  }

  void selectDDOS() {
    ddosSelectedValue = !ddosSelectedValue;
    notifyListeners();
  }

  void selectBGP(String selected) {
    bgpSelectedValue = selected;
    notifyListeners();
  }

  void selectIPAdress() {
    ipAdressSelectedValue = !ipAdressSelectedValue;
    notifyListeners();
  }

  void selectIPInterface() {
    if (ipSelectedValue == 'IPv4') {
      ipSelectedValue = ipList[1];
    } else {
      ipSelectedValue = ipList[0];
    }
    notifyListeners();
  }

  void selectSubnet(String selected) {
    subnetSelectedValue = selected;
    notifyListeners();
  }

  void addRow() {
    rows.add(
      PlutoRow(
        cells: {
          'ORDER_TYPE_Column': PlutoCell(value: '0'),
          'CIRCUIT_INFO_Column': PlutoCell(value: '0'),
          'DATA_CENTER_Column': PlutoCell(value: '0'),
          'DDOS_Column': PlutoCell(value: '0'),
          'BGM_Column': PlutoCell(value: '0'),
          'IP_Column': PlutoCell(value: '0'),
          'LINE_ITEM_Column': PlutoCell(value: lineItemCenterController.text),
          'UNIT_PRICE_Column': PlutoCell(value: double.parse(unitPriceController.text)),
          'UNIT_COST_Column': PlutoCell(value: double.parse(unitCostController.text) * -1),
          'QUANTITY_Column': PlutoCell(value: int.parse(quantityController.text)),
        },
      ),
    );
    lineItemCenterController.clear();
    unitPriceController.clear();
    unitCostController.clear();
    quantityController.clear();
    notifyListeners();
  }

  void resetForm() {
    existingCircuitIDController.clear();
    newCircuitIDController.clear();
    newDataCenterController.clear();
    existingEVCController.clear();

    orderTypesSelectedValue = orderTypesList.first;
    typesSelectedValue = typesList.first;
    dataCenterSelectedValue = dataCentersList.first;
    circuitInfoSelectedValue = circuitInfosList.first;
    evcodSelectedValue = evcodList.first;
    ddosSelectedValue = false;
    bgpSelectedValue = bgpList.first;
    ipAdressSelectedValue = false;
    ipSelectedValue = ipList.first;
    subnetSelectedValue = subnetList.first;

    lineItemCenterController.clear();
    unitPriceController.clear();
    unitCostController.clear();
    quantityController.clear();

    notifyListeners();
  }

  void deleteRow() {}
}
