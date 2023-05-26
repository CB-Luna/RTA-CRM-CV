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
    circuitTypeSelectedValue = circuitInfosList.first;
    evcodSelectedValue = evcodList.first;
    ddosSelectedValue = ddosList.first;
    bgpSelectedValue = bgpList.first;
    ipAdressSelectedValue = ipAdressList.first;
    ipInterfaceSelectedValue = ipInterfaceList.first;
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
  late String circuitTypeSelectedValue;
  late String evcodSelectedValue;
  late String ddosSelectedValue; //['Yes', 'No']
  late String bgpSelectedValue;
  late String ipAdressSelectedValue;
  late String ipInterfaceSelectedValue;
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
  List<String> ddosList = ['Yes', 'No'];
  List<String> evcodList = ['No', 'New', 'Existing EVC'];
  List<String> bgpList = ['No', 'IPv4', 'IPv6', 'Current ASN(s)'];
  List<String> ipAdressList = ['Interface', 'IP Subnet'];
  List<String> ipInterfaceList = ['IPv4', 'IPv6'];
  List<String> subnetList = ['No', 'IPv4', 'IPv6'];

  final lineItemCenterController = TextEditingController();
  final unitPriceController = TextEditingController();
  final unitCostController = TextEditingController();
  final quantityController = TextEditingController();

  final companyController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  void selectOT(String selected) {
    orderTypesSelectedValue = selected;
    notifyListeners();
  }

  void selectType(String selected) {
    typesSelectedValue = selected;
    existingCircuitIDController.clear();
    newCircuitIDController.clear();
    notifyListeners();
  }

  void selectDataCenter(String selected) {
    dataCenterSelectedValue = selected;
    newDataCenterController.clear();
    notifyListeners();
  }

  void selectCircuitInfo(String selected) {
    circuitTypeSelectedValue = selected;
    selectEVCOD(evcodList.first);
    notifyListeners();
  }

  void selectEVCOD(String selected) {
    evcodSelectedValue = selected;
    existingEVCController.clear();
    notifyListeners();
  }

  void selectDDOS() {
    if (ddosSelectedValue == 'Yes') {
      ddosSelectedValue = ddosList[1];
    } else {
      ddosSelectedValue = ddosList[0];
    }
    notifyListeners();
  }

  void selectBGP(String selected) {
    bgpSelectedValue = selected;
    notifyListeners();
  }

  void selectIPAdress() {
    if (ipAdressSelectedValue == 'Interface') {
      ipAdressSelectedValue = ipAdressList[1];
    } else {
      ipAdressSelectedValue = ipAdressList[0];
    }
    selectIPInterface();
    selectSubnet(subnetList.first);
    notifyListeners();
  }

  void selectIPInterface() {
    if (ipInterfaceSelectedValue == 'IPv4') {
      ipInterfaceSelectedValue = ipInterfaceList[1];
    } else {
      ipInterfaceSelectedValue = ipInterfaceList[0];
    }
    notifyListeners();
  }

  void selectSubnet(String selected) {
    subnetSelectedValue = selected;
    notifyListeners();
  }

  void addRow() {
    var dataCenterType = '';
    if (dataCenterSelectedValue != 'New') {
      dataCenterType = 'Existing';
    } else {
      dataCenterType = 'New';
    }

    var dataCenterLocation = '';
    if (dataCenterSelectedValue != 'New') {
      dataCenterLocation = dataCenterSelectedValue;
    } else {
      dataCenterLocation = newDataCenterController.text;
    }

    rows.add(
      PlutoRow(
        cells: {
          'ORDER_TYPE_Column': PlutoCell(value: orderTypesSelectedValue),
          'TYPE_Column': PlutoCell(value: typesSelectedValue),
          'EXISTING_CIRCUIT_Column': PlutoCell(value: existingCircuitIDController.text),
          'NEW_CIRCUIT_Column': PlutoCell(value: newCircuitIDController.text),
          'DATA_CENTER_TYPE_Column': PlutoCell(value: dataCenterType),
          'DATA_CENTER_LOCATION_Column': PlutoCell(value: dataCenterLocation),
          ////////////////////////////////////////////////////////////////////
          'CIRCUIT_TYPE_Column': PlutoCell(value: circuitTypeSelectedValue),
          'EVCOD_TYPE_Column': PlutoCell(value: evcodSelectedValue),
          'CIRCUIT_ID_Column': PlutoCell(value: existingEVCController.text),
          'DDOS_Column': PlutoCell(value: ddosSelectedValue),
          'BGP_Column': PlutoCell(value: bgpSelectedValue),
          'IP_ADRESS_Column': PlutoCell(value: ipAdressSelectedValue),
          'IP_INTERFACE_Column': PlutoCell(value: ipInterfaceSelectedValue),
          'IP_SUBNET_Column': PlutoCell(value: subnetSelectedValue),
          ////////////////////////////////////////////////////////////////////
          'LINE_ITEM_Column': PlutoCell(value: lineItemCenterController.text),
          'UNIT_PRICE_Column': PlutoCell(value: double.parse(unitPriceController.text)),
          'UNIT_COST_Column': PlutoCell(value: double.parse(unitCostController.text) * -1),
          'QUANTITY_Column': PlutoCell(value: int.parse(quantityController.text)),
          'ACTIONS_Column': PlutoCell(value: 'Actions'),
        },
      ),
    );
    lineItemCenterController.clear();
    unitPriceController.clear();
    unitCostController.clear();
    quantityController.clear();
    notifyListeners();
  }

  bool isValidated() {
    if (typesSelectedValue == 'Disconnect' && existingCircuitIDController.text.isEmpty) {
      return false;
    } else if (typesSelectedValue == 'Upgrade' && existingCircuitIDController.text.isEmpty && newCircuitIDController.text.isEmpty) {
      return false;
    } else if (dataCenterSelectedValue == 'New' && existingCircuitIDController.text.isEmpty && newCircuitIDController.text.isEmpty) {
      return false;
    } else if (evcodSelectedValue == 'Existing EVC' && existingEVCController.text.isEmpty) {
      return false;
    } else if (lineItemCenterController.text.isEmpty ||
        unitPriceController.text.isEmpty ||
        double.parse(unitPriceController.text) < 0 ||
        unitCostController.text.isEmpty ||
        double.parse(unitCostController.text) < 0 ||
        quantityController.text.isEmpty ||
        double.parse(quantityController.text) < 0) {
      return false;
    } else {
      addRow();
      return true;
    }
  }

  void resetForm() {
    existingCircuitIDController.clear();
    newCircuitIDController.clear();
    newDataCenterController.clear();
    existingEVCController.clear();

    orderTypesSelectedValue = orderTypesList.first;
    typesSelectedValue = typesList.first;
    dataCenterSelectedValue = dataCentersList.first;
    circuitTypeSelectedValue = circuitInfosList.first;
    evcodSelectedValue = evcodList.first;
    ddosSelectedValue = ddosList.first;
    bgpSelectedValue = bgpList.first;
    ipAdressSelectedValue = ipAdressList.first;
    ipInterfaceSelectedValue = ipInterfaceList.first;
    subnetSelectedValue = subnetList.first;

    lineItemCenterController.clear();
    unitPriceController.clear();
    unitCostController.clear();
    quantityController.clear();

    notifyListeners();
  }

  void deleteRow() {}
}
