// import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/accounts/quotes_model.dart';
import 'package:rta_crm_cv/pages/accounts/models/orders.dart';

class CreateQuoteProvider extends ChangeNotifier {
  CreateQuoteProvider() {
    clearAll();
  }

  clearAll() {
    subtotal = 0;
    cost = 0;
    total = 0;
    margin = 0;

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

    globalRows.clear();

    comments.clear();
    commentController.clear();
  }

  final commentController = TextEditingController();
  List<Comment> comments = [];

  void addComment() {
    if (commentController.text.isNotEmpty) {
      comments.add(
        Comment(
          role: currentUser!.role.roleName,
          name: currentUser!.name,
          comment: commentController.text,
          sended: DateTime.now(),
        ),
      );
      commentController.clear();
      notifyListeners();
    }
  }

  List<PlutoGridStateManager> listStateManager = [];
  List<PlutoRow> globalRows = [];
  List<QuoteOrder> quotes = [];

  var tableTop1Group = AutoSizeGroup();
  var tableTopGroup = AutoSizeGroup();
  var tableContentGroup = AutoSizeGroup();

  int totalItems = 0;
  double subtotal = 0;
  double cost = 0;
  double total = 0;
  double margin = 0;

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
    'New'
  ];
  List<String> circuitInfosList = ['Provider: ATT, Fiberlight, etc.', 'NNI', 'DIA', 'CIR', 'Port Size', 'Multicast Required', 'Cross-Connect', 'EVCoD'];
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

  bool createValidation() {
    if (typesSelectedValue == 'Disconnect' && existingCircuitIDController.text.isEmpty) {
      return false;
    } else if (typesSelectedValue == 'Upgrade' && existingCircuitIDController.text.isEmpty && newCircuitIDController.text.isEmpty) {
      return false;
    } else if (dataCenterSelectedValue == 'New' && existingCircuitIDController.text.isEmpty && newCircuitIDController.text.isEmpty) {
      return false;
    } else if (evcodSelectedValue == 'Existing EVC' && existingEVCController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> createQuote() async {
    // var x = (await supabaseCRM.from('quotes').select()).toString();
    // var z = await supabase.from('temas').select();
    // await supabasePublic.from('quotes').insert({'number': 11});
    // await supabasePublic.from('quotes').select();

    try {
      Map<String, dynamic> quoteInfo = {};

      Map<String, dynamic> orderType = {};
      if (typesSelectedValue == 'New') {
        orderType.addAll({
          'order_type': orderTypesSelectedValue,
          'type': typesSelectedValue,
        });
      } else if (typesSelectedValue == 'Disconnect') {
        orderType.addAll({
          'order_type': orderTypesSelectedValue,
          'type': typesSelectedValue,
          'existing_circuit_id': existingCircuitIDController.text,
        });
      } else {
        orderType.addAll({
          'order_type': orderTypesSelectedValue,
          'type': typesSelectedValue,
          'existing_circuit_id': existingCircuitIDController.text,
          'new_circuit_id': newCircuitIDController.text,
        });
      }
      quoteInfo.addAll(orderType);

      Map<String, dynamic> dataCenter = {};
      if (dataCenterSelectedValue != 'New') {
        dataCenter.addAll({
          'data_center_type': 'Existing',
          'data_center_location': dataCenterSelectedValue,
        });
      } else {
        dataCenter.addAll({
          'data_center_type': 'New',
          'data_center_location': newDataCenterController.text,
        });
      }
      quoteInfo.addAll(dataCenter);

      Map<String, dynamic> circuitType = {};
      if (circuitTypeSelectedValue != 'EVCoD') {
        circuitType.addAll({
          'circuit_type': circuitTypeSelectedValue,
        });
      } else if (evcodSelectedValue != 'Existing EVC') {
        circuitType.addAll({
          'circuit_type': circuitTypeSelectedValue,
          'evcod_type': evcodSelectedValue,
        });
      } else {
        circuitType.addAll({
          'circuit_type': circuitTypeSelectedValue,
          'evcod_type': evcodSelectedValue,
          'evc_circuit_id': existingEVCController.text,
        });
      }
      quoteInfo.addAll(circuitType);

      quoteInfo.addAll({
        'ddos_type': ddosSelectedValue,
        'bgp_type': bgpSelectedValue,
      });

      Map<String, dynamic> ipAdress = {};
      if (ipAdressSelectedValue == 'Interface') {
        ipAdress.addAll({
          'ip_type': ipAdressSelectedValue,
          'interface_type': ipInterfaceSelectedValue,
        });
      } else {
        ipAdress.addAll({
          'ip_type': ipAdressSelectedValue,
          'subnet_type': subnetSelectedValue,
        });
      }
      quoteInfo.addAll(ipAdress);

      List<Map<String, dynamic>> items = [];
      for (var row in globalRows) {
        Map<String, dynamic> item = {
          'line_item': row.cells['LINE_ITEM_Column']!.value,
          'unit_price': row.cells['UNIT_PRICE_Column']!.value,
          'unit_cost': row.cells['UNIT_COST_Column']!.value,
          'quantity': row.cells['QUANTITY_Column']!.value,
        };
        items.add(item);
      }

      List<Map<String, dynamic>> commentsList = [];
      for (var comment in comments) {
        Map<String, dynamic> item = {
          'role': comment.role,
          'name': comment.name,
          'comment': comment.comment,
          'sended': comment.sended.toString(),
        };
        commentsList.add(item);
      }

      await supabaseCRM.from('quotes').insert({
        "created_by": currentUser!.id,
        "updated_by": currentUser!.id,
        "status": "Opened",
        "id_customer": 1,
        "exp_close_date": DateTime.now().add(const Duration(days: 30)).toString(),
        "subtotal": subtotal,
        "cost": cost,
        "total": total,
        "margin": margin,
        "probability": 100,
        "order_info": quoteInfo,
        "items": items,
        "comments": commentsList
      });
    } catch (e) {
      print(e.toString());
    }

    clearAll();
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
      return true;
    }
  }

  void addRowExpansionPanel() {
    var dataCenterType = 'New';
    if (dataCenterSelectedValue != 'New') {
      dataCenterType = 'Existing';
    }

    var dataCenterLocation = '';
    if (dataCenterSelectedValue != 'New') {
      dataCenterLocation = dataCenterSelectedValue;
    } else {
      dataCenterLocation = newDataCenterController.text;
    }

    var evcod = '';
    var evcodId = '';
    if (circuitTypeSelectedValue == 'EVCoD') {
      evcod = evcodSelectedValue;
      if (evcodSelectedValue == 'Existing EVC') {
        evcodId = existingEVCController.text;
      }
    }

    var ipInterface = '';
    var ipSubnet = '';
    if (ipAdressSelectedValue == 'Interface') {
      ipInterface = ipInterfaceSelectedValue;
    } else {
      ipSubnet = subnetSelectedValue;
    }

    var row = PlutoRow(
      cells: {
        'ORDER_TYPE_Column': PlutoCell(value: orderTypesSelectedValue),
        'TYPE_Column': PlutoCell(value: typesSelectedValue),
        'EXISTING_CIRCUIT_Column': PlutoCell(value: existingCircuitIDController.text),
        'NEW_CIRCUIT_Column': PlutoCell(value: newCircuitIDController.text),
        'DATA_CENTER_TYPE_Column': PlutoCell(value: dataCenterType),
        'DATA_CENTER_LOCATION_Column': PlutoCell(value: dataCenterLocation),
        ////////////////////////////////////////////////////////////////////
        'CIRCUIT_TYPE_Column': PlutoCell(value: circuitTypeSelectedValue),
        'EVCOD_TYPE_Column': PlutoCell(value: evcod),
        'CIRCUIT_ID_Column': PlutoCell(value: evcodId),
        'DDOS_Column': PlutoCell(value: ddosSelectedValue),
        'BGP_Column': PlutoCell(value: bgpSelectedValue),
        'IP_ADRESS_Column': PlutoCell(value: ipAdressSelectedValue),
        'IP_INTERFACE_Column': PlutoCell(value: ipInterface),
        'IP_SUBNET_Column': PlutoCell(value: ipSubnet),
        ////////////////////////////////////////////////////////////////////
        'LINE_ITEM_Column': PlutoCell(value: lineItemCenterController.text),
        'UNIT_PRICE_Column': PlutoCell(value: double.parse(unitPriceController.text)),
        'UNIT_COST_Column': PlutoCell(value: double.parse(unitCostController.text) * -1),
        'QUANTITY_Column': PlutoCell(value: int.parse(quantityController.text)),
        'ACTIONS_Column': PlutoCell(value: 'Actions'),
      },
    );

    globalRows.add(row);

    bool founded = false;
    for (var quote in quotes) {
      if (orderTypesSelectedValue == quote.orderType &&
          typesSelectedValue == quote.type &&
          existingCircuitIDController.text == quote.existingCircuitID &&
          newCircuitIDController.text == quote.newCircuitID &&
          dataCenterType == quote.dataCenterType &&
          dataCenterLocation == quote.dataCenterLocation &&
          circuitTypeSelectedValue == quote.circuitType &&
          evcod == quote.evcodType &&
          evcodId == quote.evcodCircuitID &&
          ddosSelectedValue == quote.ddos &&
          bgpSelectedValue == quote.bgp &&
          ipAdressSelectedValue == quote.ipAdress &&
          ipInterface == quote.ipInterface &&
          ipSubnet == quote.ipSubnet) {
        founded = true;
        quote.items.add(PlutoRow(cells: {
          'LINE_ITEM_Column': PlutoCell(value: row.cells['LINE_ITEM_Column']!.value.toString()),
          'UNIT_PRICE_Column': PlutoCell(value: row.cells['UNIT_PRICE_Column']!.value),
          'UNIT_COST_Column': PlutoCell(value: row.cells['UNIT_COST_Column']!.value),
          'QUANTITY_Column': PlutoCell(value: row.cells['QUANTITY_Column']!.value),
          'ACTIONS_Column': PlutoCell(value: 'Actions'),
        }));
      }
    }
    if (!founded) {
      quotes.add(
        QuoteOrder(
          rowId: row.sortIdx,
          orderType: row.cells['ORDER_TYPE_Column']!.value.toString(),
          type: row.cells['TYPE_Column']!.value.toString(),
          existingCircuitID: row.cells['EXISTING_CIRCUIT_Column']!.value.toString(),
          newCircuitID: row.cells['NEW_CIRCUIT_Column']!.value.toString(),
          dataCenterType: row.cells['DATA_CENTER_TYPE_Column']!.value.toString(),
          dataCenterLocation: row.cells['DATA_CENTER_LOCATION_Column']!.value.toString(),
          ////////////////////////////////////////////////////////////////////
          circuitType: row.cells['CIRCUIT_TYPE_Column']!.value.toString(),
          evcodType: row.cells['EVCOD_TYPE_Column']!.value.toString(),
          evcodCircuitID: row.cells['CIRCUIT_ID_Column']!.value.toString(),
          ddos: row.cells['DDOS_Column']!.value.toString(),
          bgp: row.cells['BGP_Column']!.value.toString(),
          ipAdress: row.cells['IP_ADRESS_Column']!.value.toString(),
          ipInterface: row.cells['IP_INTERFACE_Column']!.value.toString(),
          ipSubnet: row.cells['IP_SUBNET_Column']!.value.toString(),
          items: [
            PlutoRow(
              cells: {
                'LINE_ITEM_Column': PlutoCell(value: row.cells['LINE_ITEM_Column']!.value.toString()),
                'UNIT_PRICE_Column': PlutoCell(value: row.cells['UNIT_PRICE_Column']!.value),
                'UNIT_COST_Column': PlutoCell(value: row.cells['UNIT_COST_Column']!.value),
                'QUANTITY_Column': PlutoCell(value: row.cells['QUANTITY_Column']!.value),
                'ACTIONS_Column': PlutoCell(value: 'Actions'),
              },
            )
          ],
        ),
      );
    }

    lineItemCenterController.clear();
    unitPriceController.clear();
    unitCostController.clear();
    quantityController.clear();
    countRowsExpansionPanel();
    notifyListeners();
  }

  void addRowPlutoGrid() {
    /* var dataCenterType = 'New';
    if (dataCenterSelectedValue != 'New') {
      dataCenterType = 'Existing';
    }

    var dataCenterLocation = '';
    if (dataCenterSelectedValue != 'New') {
      dataCenterLocation = dataCenterSelectedValue;
    } else {
      dataCenterLocation = newDataCenterController.text;
    }

    var evcod = '';
    var evcodId = '';
    if (circuitTypeSelectedValue == 'EVCoD') {
      evcod = evcodSelectedValue;
      if (evcodSelectedValue == 'Existing EVC') {
        evcodId = existingEVCController.text;
      }
    }

    var ipInterface = '';
    var ipSubnet = '';
    if (ipAdressSelectedValue == 'Interface') {
      ipInterface = ipInterfaceSelectedValue;
    } else {
      ipSubnet = subnetSelectedValue;
    } */

    var row = PlutoRow(
      cells: {
        /* 'ORDER_TYPE_Column': PlutoCell(value: orderTypesSelectedValue),
        'TYPE_Column': PlutoCell(value: typesSelectedValue),
        'EXISTING_CIRCUIT_Column': PlutoCell(value: existingCircuitIDController.text),
        'NEW_CIRCUIT_Column': PlutoCell(value: newCircuitIDController.text),
        'DATA_CENTER_TYPE_Column': PlutoCell(value: dataCenterType),
        'DATA_CENTER_LOCATION_Column': PlutoCell(value: dataCenterLocation),
        ////////////////////////////////////////////////////////////////////
        'CIRCUIT_TYPE_Column': PlutoCell(value: circuitTypeSelectedValue),
        'EVCOD_TYPE_Column': PlutoCell(value: evcod),
        'CIRCUIT_ID_Column': PlutoCell(value: evcodId),
        'DDOS_Column': PlutoCell(value: ddosSelectedValue),
        'BGP_Column': PlutoCell(value: bgpSelectedValue),
        'IP_ADRESS_Column': PlutoCell(value: ipAdressSelectedValue),
        'IP_INTERFACE_Column': PlutoCell(value: ipInterface),
        'IP_SUBNET_Column': PlutoCell(value: ipSubnet), */
        ////////////////////////////////////////////////////////////////////
        'LINE_ITEM_Column': PlutoCell(value: lineItemCenterController.text),
        'UNIT_PRICE_Column': PlutoCell(value: double.parse(unitPriceController.text)),
        'UNIT_COST_Column': PlutoCell(value: double.parse(unitCostController.text) * -1),
        'QUANTITY_Column': PlutoCell(value: int.parse(quantityController.text)),
        'ACTIONS_Column': PlutoCell(value: 'Actions'),
      },
    );

    globalRows.add(row);

    lineItemCenterController.clear();
    unitPriceController.clear();
    unitCostController.clear();
    quantityController.clear();
    countRowsPlutoGrid();
    notifyListeners();
  }

  void countRowsExpansionPanel() {
    totalItems = 0;
    subtotal = 0;
    cost = 0;
    total = 0;
    margin = 0;

    for (var quote in quotes) {
      for (var item in quote.items) {
        totalItems++;
        subtotal = (item.cells['UNIT_PRICE_Column']!.value * item.cells['QUANTITY_Column']!.value) + subtotal;
        cost = ((item.cells['UNIT_COST_Column']!.value * -1) * item.cells['QUANTITY_Column']!.value) + cost;
      }
    }

    total = subtotal - cost;
    if (total == 0 && subtotal == 0) {
      margin = 0;
    } else {
      margin = total * 100 / subtotal;
    }
    notifyListeners();
  }

  void countRowsPlutoGrid() {
    totalItems = 0;
    subtotal = 0;
    cost = 0;
    total = 0;
    margin = 0;

    // PlutoGrid
    for (var row in globalRows) {
      totalItems++;
      subtotal = (row.cells['UNIT_PRICE_Column']!.value * row.cells['QUANTITY_Column']!.value) + subtotal;
      cost = ((row.cells['UNIT_COST_Column']!.value * -1) * row.cells['QUANTITY_Column']!.value) + cost;
    }

    total = subtotal - cost;
    if (total == 0 && subtotal == 0) {
      margin = 0;
    } else {
      margin = total * 100 / subtotal;
    }

    notifyListeners();
  }

  void resetFormExpansionPanel() {
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

  void resetFormPlutoGrid() {
    lineItemCenterController.clear();
    unitPriceController.clear();
    unitCostController.clear();
    quantityController.clear();

    notifyListeners();
  }
}
