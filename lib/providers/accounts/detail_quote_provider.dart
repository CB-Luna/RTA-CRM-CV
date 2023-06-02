// import 'dart:developer';

import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/accounts/quotes_model.dart';
import 'package:rta_crm_cv/pages/accounts/models/orders.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailQuoteProvider extends ChangeNotifier {
  /* Future<void> updateState() async {
    clearAll();
    await getData();
  } */

  DetailQuoteProvider() {
    realTimeSuscription();
  }

  late int? id;

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
  }

  final commentController = TextEditingController();
  List<Comment> comments = [];
  Future<void> addComment() async {
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
      await supabaseCRM.from('quotes').update({'comments': commentsList}).eq('id', id);

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
  late String ddosSelectedValue;
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

  Future<void> getData() async {
    if (id != null) {
      var response = await supabaseCRM.from('quotes').select().eq('id', id);

      if (response == null) {
        log('Error en getData()-DetailQuoteProvider');
        return;
      }

      Quotes quote = Quotes.fromJson(jsonEncode(response[0]));

      orderTypesSelectedValue = quote.orderInfo.orderType;
      typesSelectedValue = quote.orderInfo.type;
      if (quote.orderInfo.type == 'Disconnect') {
        existingCircuitIDController.text = quote.orderInfo.existingCircuitId!;
      } else if (quote.orderInfo.type == 'Upgrade') {
        existingCircuitIDController.text = quote.orderInfo.existingCircuitId!;
        newCircuitIDController.text = quote.orderInfo.newCircuitId!;
      }

      if (quote.orderInfo.dataCenterType == 'New') {
        dataCenterSelectedValue = 'New';
        newDataCenterController.text = quote.orderInfo.dataCenterLocation;
      } else {
        dataCenterSelectedValue = quote.orderInfo.dataCenterLocation;
      }

      circuitTypeSelectedValue = quote.orderInfo.circuitType;
      if (quote.orderInfo.circuitType == 'EVCoD') {
        evcodSelectedValue = quote.orderInfo.evcodType!;
        if (quote.orderInfo.evcodType == 'Existing EVC') {
          existingEVCController.text = quote.orderInfo.evcCircuitId!;
        }
      }

      ddosSelectedValue = quote.orderInfo.ddosType;
      bgpSelectedValue = quote.orderInfo.bgpType;

      ipAdressSelectedValue = quote.orderInfo.ipType;
      if (quote.orderInfo.ipType == 'Interface') {
        ipInterfaceSelectedValue = quote.orderInfo.interfaceType!;
      } else {
        subnetSelectedValue = quote.orderInfo.subnetType!;
      }

      subtotal = quote.subtotal;
      cost = quote.cost;
      total = quote.total;
      margin = quote.margin;

      globalRows.clear();
      for (var item in quote.items) {
        globalRows.add(PlutoRow(
          cells: {
            'LINE_ITEM_Column': PlutoCell(value: item.lineItem),
            'UNIT_PRICE_Column': PlutoCell(value: item.unitPrice),
            'UNIT_COST_Column': PlutoCell(value: item.unitCost),
            'QUANTITY_Column': PlutoCell(value: item.quantity),
            'ACTIONS_Column': PlutoCell(value: ''),
          },
        ));
      }

      comments.clear();
      for (var comment in quote.comments) {
        comments.add(
          Comment(
            role: comment.role,
            name: comment.name,
            comment: comment.comment,
            sended: comment.sended,
          ),
        );
      }
    }

    notifyListeners();
  }

  final myChannel = supabaseCRM.channel('quotes');

  Future<void> realTimeSuscription() async {
    myChannel.on(
        RealtimeListenTypes.postgresChanges,
        ChannelFilter(
          event: 'UPDATE',
          schema: 'crm',
          table: 'quotes',
        ), (payload, [ref]) async {
      await getData();
    }).subscribe();
  }

/*   void selectOT(String selected) {
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

  void addRow() {
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
    countRows();
    notifyListeners();
  }

  void countRows() {
    totalItems = 0;
    subtotal = 0;
    cost = 0;
    total = 0;
    margin = 0;

    // ExpansionPanelList
    for (var quote in quotes) {
      for (var item in quote.items) {
        totalItems++;
        subtotal = (item.cells['UNIT_PRICE_Column']!.value * item.cells['QUANTITY_Column']!.value) + subtotal;
        cost = ((item.cells['UNIT_COST_Column']!.value * -1) * item.cells['QUANTITY_Column']!.value) + cost;
      }
    }

    // PlutoGrid
    /* for (var row in globalRows) {
      totalItems++;
      subtotal = (row.cells['UNIT_PRICE_Column']!.value * row.cells['QUANTITY_Column']!.value) + subtotal;
      cost = ((row.cells['UNIT_COST_Column']!.value * -1) * row.cells['QUANTITY_Column']!.value) + cost;
    } */

    total = subtotal - cost;
    margin = total * 100 / subtotal;
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
  } */
}
