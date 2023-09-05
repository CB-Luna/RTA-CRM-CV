// import 'dart:developer';

import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
//import 'package:rta_crm_cv/models/crm/accounts/quotes_model.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_%20generic_cat.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_%20cat_order_info_types.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_cat_circuit_types.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_cat_vendor_model.dart';
import 'package:rta_crm_cv/models/crm/x2crm/model_x2_quotes_view_v2.dart';
//import 'package:rta_crm_cv/models/crm/x2crm/model_x2_quotes_view.dart';
import 'package:rta_crm_cv/pages/crm/accounts/models/orders.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailQuoteProvider extends ChangeNotifier {
  DetailQuoteProvider() {
    realTimeSuscription();
    clearAll();
  }

  int id = 0;
  late ModelX2V2QuotesView quote;

  clearAll() {
    subtotal = 0;
    cost = 0;
    total = 0;
    tax = 0;
    totalPlusTax = 0;
    margin = 0;

    existingCircuitIDController.clear();
    newCircuitIDController.clear();
    addressController.clear();
    newDataCenterController.clear();
    rackLocationController.clear();
    demarcationPointController.clear();

    multicastRequired = false;
    locationController.clear();
    evcodSelectedValue = evcodList.first;
    evcCircuitIdController.clear();
    //ddosSelectedValue = ddosList.first;
    ddosSelectedValue = false;
    ipBlockSelectedValue = ipBlockList.first.name!;
    peeringTypeSelectedValue = peeringTypeList.first.name!;
    ipAdressSelectedValue = ipAdressList.first;
    ipInterfaceSelectedValue = ipInterfaceList.first;
    subnetSelectedValue = subnetList.first;

    //idVendor = null;

    lineItemCenterController.clear();
    unitPriceController.clear();
    unitCostController.clear();
    quantityController.clear();

    globalRows.clear();

    comments.clear();
    commentController.clear();

/*     pdfController = null;
    docProveedor = null;
    popupVisorPdfVisible = false; */

    isLoading = false;

    id = 0;

    notifyListeners();
  }

  final commentController = TextEditingController();
  List<Comment> comments = [];
  Future<void> addComment() async {
    if (commentController.text.isNotEmpty) {
      await supabaseCRM.from('order_comments').insert(
        {
          "order_info_id": quote.idOrders,
          "user_id": currentUser!.id,
          "role": currentUser!.role.roleName,
          "name": currentUser!.name,
          "comment": commentController.text,
          "sended": DateTime.now().toIso8601String(),
        },
      );
      comments.add(
        Comment(
          role: currentUser!.role.roleName,
          name: currentUser!.name,
          comment: commentController.text,
          sended: DateTime.now(),
        ),
      );
      commentController.clear();
      /* List<Map<String, dynamic>> commentsList = [];
      for (var comment in comments) {
        Map<String, dynamic> item = {
          'role': comment.role,
          'name': comment.name,
          'comment': comment.comment,
          'sended': comment.sended.toString(),
        };
        commentsList.add(item);
      } */

      //await supabaseCRM.from('quotes').update({'comments': commentsList}).eq('id', id);

      //await supabaseCRM.from('orders_info').update({'comments': commentsList}).eq('id', quote.idOrders);

      notifyListeners();
    }
  }

  List<PlutoGridStateManager> listStateManager = [];
  List<PlutoRow> globalRows = [];
  List<QuoteOrder> quotes = [];
  bool isLoading = false;

  var tableTop1Group = AutoSizeGroup();
  var tableTopGroup = AutoSizeGroup();
  var tableContentGroup = AutoSizeGroup();

  int totalItems = 0;
  double subtotal = 0;
  double cost = 0;
  double total = 0;
  double tax = 0;
  double totalPlusTax = 0;
  double margin = 0;

  List<GenericCat> orderTypesList = [GenericCat(name: 'Internal Circuit')];
  late String orderTypesSelectedValue;
  List<CatOrderInfoTypes> typesList = [CatOrderInfoTypes(name: 'New')];
  late String typesSelectedValue;
  final existingCircuitIDController = TextEditingController();
  final newCircuitIDController = TextEditingController();
  final addressController = TextEditingController();
  List<GenericCat> dataCentersList = [GenericCat(name: 'New')];
  late String dataCenterSelectedValue;
  final newDataCenterController = TextEditingController();
  final rackLocationController = TextEditingController();
  List<GenericCat> handoffList = [GenericCat(name: 'New')];
  late String handoffSelectedValue;
  final demarcationPointController = TextEditingController();

  List<Vendor> vendorsList = [Vendor(vendorName: 'ATT')];
  String vendorSelectedValue = '';
  bool multicastRequired = false;
  final locationController = TextEditingController();
  List<CatCircuitTypes> circuitTypeList = [CatCircuitTypes(name: 'NNI')];
  late String circuitTypeSelectedValue;
  //List<String> ddosList = ['Yes', 'No'];
  //late String ddosSelectedValue;
  final bandwidthController = TextEditingController();
  bool ddosSelectedValue = false;
  List<String> evcodList = ['No', 'New', 'Existing EVC'];
  late String evcodSelectedValue;
  final evcCircuitIdController = TextEditingController();
  List<GenericCat> bgpList = [GenericCat(name: 'No')];
  late String bgpSelectedValue;
  List<GenericCat> ipBlockList = [GenericCat(name: 'IPv4'), GenericCat(name: 'IPv4 & IPv6')];
  late String ipBlockSelectedValue;
  List<GenericCat> peeringTypeList = [GenericCat(name: 'IPv4'), GenericCat(name: 'IPv4 & IPv6')];
  late String peeringTypeSelectedValue;
  List<String> ipAdressList = ['Interface', 'IP Subnet'];
  late String ipAdressSelectedValue;
  List<String> ipInterfaceList = ['IPv4', 'IPv6'];
  late String ipInterfaceSelectedValue;
  List<String> subnetList = ['No', 'IPv4', 'IPv6'];
  late String subnetSelectedValue;
  List<GenericCat> cirList = [GenericCat(name: 'Empty')];
  late String cirSelectedValue;
  List<GenericCat> portSizeList = [GenericCat(name: 'Empty')];
  late String portSizeSelectedValue;

  final lineItemCenterController = TextEditingController();
  final unitPriceController = TextEditingController();
  final unitCostController = TextEditingController();
  final quantityController = TextEditingController();

  List<String> leadsList = [''];
  String leadSelectedValue = '';
  final companyController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

/*   Future<void> getData() async {
    if (id != 0) {
      var responseQuote = await supabaseCRM.from('quotes_view').select().eq('id', id);

      if (responseQuote == null) {
        log('Error en getData()-DetailQuoteProvider');
        return;
      }

      Quotes quote = Quotes.fromJson(jsonEncode(responseQuote[0]));

      orderTypesSelectedValue = quote.orderInfo.orderType;
      typesSelectedValue = quote.orderInfo.type;
      if (quote.orderInfo.type == 'New') {
        newCircuitIDController.text = quote.orderInfo.newCircuitId!;
      } else if (quote.orderInfo.type == 'Disconnect') {
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

      await getVendors();
      var responseVendor = await supabaseCRM.from('cat_vendors').select().eq('id', quote.idVendor);
      Vendor vendor = Vendor.fromJson(jsonEncode(responseVendor[0]));
      vendorSelectedValue = vendor.vendorName;

      circuitTypeSelectedValue = quote.orderInfo.circuitType;
      if (quote.orderInfo.circuitType == 'EVCoD') {
        evcodSelectedValue = quote.orderInfo.evcodType!;
        if (quote.orderInfo.evcodType == 'Existing EVC') {
          evcCircuitIdController.text = quote.orderInfo.evcCircuitId!;
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
      tax = quote.tax;
      totalPlusTax = quote.totalPlusTax;
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

      var responseLead = await supabaseCRM.from('leads').select().eq('id', quote.idLead);

      Leads lead = Leads.fromJson(jsonEncode(responseLead[0]));

      companyController.text = lead.account;
      nameController.text = lead.firstName;
      lastNameController.text = lead.lastName;
      emailController.text = lead.email;
      phoneController.text = lead.phoneNumber;

      notifyListeners();
    }
  }
 */
  final myChannel = supabaseCRM.channel('quotes');

  Future<void> realTimeSuscription() async {
    myChannel.on(
        RealtimeListenTypes.postgresChanges,
        ChannelFilter(
          event: 'UPDATE',
          schema: 'crm',
          table: 'order_comments',
        ), (payload, [ref]) async {
      await getDataV2(id);
    }).subscribe();
  }

  /* Future<void> getVendors() async {
    var response = await supabaseCRM.from('vendors').select();

    List<Vendor> vendors = (response as List<dynamic>).map((vendor) => Vendor.fromJson(jsonEncode(vendor))).toList();

    vendorsList.clear();
    for (var vendor in vendors) {
      vendorsList.add(vendor.vendorName);
    }
    notifyListeners();
  } */

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
    evcCircuitIdController.clear();
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
    } else if (evcodSelectedValue == 'Existing EVC' && evcCircuitIdController.text.isEmpty) {
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
        evcodId = evcCircuitIdController.text;
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
    evcCircuitIdController.clear();

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

  Future<bool> getCatalogData() async {
    try {
      dynamic response = await supabaseCRM.from('cat_order_types').select().eq('visible', true);
      orderTypesList.clear();
      orderTypesList = (response as List<dynamic>).map((index) => GenericCat.fromRawJson(jsonEncode(index))).toList();
      orderTypesSelectedValue = orderTypesList.first.name!;

      response = await supabaseCRM.from('cat_order_info_types').select().eq('visible', true);
      typesList.clear();
      typesList = (response as List<dynamic>).map((index) => CatOrderInfoTypes.fromRawJson(jsonEncode(index))).toList();
      typesSelectedValue = typesList.first.name!;

      response = await supabaseCRM.from('cat_data_centers').select().eq('visible', true);
      dataCentersList.clear();
      dataCentersList = (response as List<dynamic>).map((index) => GenericCat.fromRawJson(jsonEncode(index))).toList();
      dataCenterSelectedValue = dataCentersList.first.name!;

      response = await supabaseCRM.from('cat_handoffs').select().eq('visible', true);
      handoffList.clear();
      handoffList = (response as List<dynamic>).map((index) => GenericCat.fromRawJson(jsonEncode(index))).toList();
      handoffSelectedValue = handoffList.first.name!;

      response = await supabaseCRM.from('cat_vendors').select().eq('visible', true);
      vendorsList.clear();
      vendorsList = (response as List<dynamic>).map((index) => Vendor.fromJson(jsonEncode(index))).toList();
      vendorSelectedValue = vendorsList.first.vendorName!;

      response = await supabaseCRM.from('cat_circuit_types').select().eq('visible', true);
      circuitTypeList.clear();
      circuitTypeList = (response as List<dynamic>).map((index) => CatCircuitTypes.fromRawJson(jsonEncode(index))).toList();
      circuitTypeSelectedValue = circuitTypeList.first.name!;

      response = await supabaseCRM.from('cat_ports').select().eq('visible', true);
      portSizeList.clear();
      portSizeList = (response as List<dynamic>).map((index) => GenericCat.fromRawJson(jsonEncode(index))).toList();
      portSizeSelectedValue = portSizeList.first.name!;

      response = await supabaseCRM.from('cat_cirs').select().eq('visible', true);
      cirList.clear();
      cirList = (response as List<dynamic>).map((index) => GenericCat.fromRawJson(jsonEncode(index))).toList();
      cirSelectedValue = cirList.first.name!;

      response = await supabaseCRM.from('cat_bgp_peering').select().eq('visible', true);
      bgpList.clear();
      bgpList = (response as List<dynamic>).map((index) => GenericCat.fromRawJson(jsonEncode(index))).toList();
      bgpSelectedValue = bgpList.first.name!;

      notifyListeners();
      return true;
    } catch (e) {
      log('Error getCatalogData() : e');
      return false;
    }
  }

  Future<bool> getDataV2(int idQuote) async {
    try {
      await clearAll();

      await getCatalogData();

      id = idQuote;

      var response = await supabaseCRM.from('x2_quotes_view_v2').select().eq('quoteid', id);

      quote = ModelX2V2QuotesView.fromJson(jsonEncode(response[0]));

      dynamic parameter = (await supabaseCRM.from('cat_order_info_types').select().eq('name', quote.orderInfo!.type))[0];
      parameter = CatOrderInfoTypes.fromRawJson(jsonEncode(parameter));

      ///////////////Order Info////////////////////////////////////////////////////////////////////

      orderTypesSelectedValue = quote.orderInfo!.orderType!;
      typesSelectedValue = quote.orderInfo!.type!;
      if (parameter.parameters.newCircuitId) {
        newCircuitIDController.text = quote.orderInfo!.newCircuitId ?? '';
      }
      if (parameter.parameters.existingCircuitId) {
        existingCircuitIDController.text = quote.orderInfo!.existingCircuitId ?? '';
      }

      addressController.text = quote.orderInfo!.address!;

      if (quote.orderInfo!.dataCenterType == 'New') {
        dataCenterSelectedValue = 'New';
        newDataCenterController.text = quote.orderInfo!.dataCenterLocation!;
      } else {
        dataCenterSelectedValue = quote.orderInfo!.dataCenterLocation!;
      }

      rackLocationController.text = quote.orderInfo!.rackLocation ?? '';
      handoffSelectedValue = quote.orderInfo!.handoff ?? '';
      demarcationPointController.text = quote.orderInfo!.demarcationPoint ?? '';

      ///////////////Circuit Info////////////////////////////////////////////////////////////////////

      vendorSelectedValue = quote.vendor!;
      multicastRequired = quote.circuitInfo!.multicast!;
      locationController.text = quote.circuitInfo!.location!;
      parameter = (await supabaseCRM.from('cat_circuit_types').select().eq('name', quote.circuitInfo!.circuitType!))[0];
      parameter = CatCircuitTypes.fromRawJson(jsonEncode(parameter));
      circuitTypeSelectedValue = quote.circuitInfo!.circuitType!;
      /* if (quote.circuitInfo!.circuitType == 'EVCoD') {
        evcodSelectedValue = quote.circuitInfo!.evcodType!;
        if (quote.circuitInfo!.evcodType == 'Existing EVC') {
          evcCircuitIdController.text = quote.circuitInfo!.evcCircuitId!;
        }
      } */
      if (quote.circuitInfo!.evcCircuitId != null) {
        evcCircuitIdController.text = quote.circuitInfo!.evcCircuitId!;
      }

      if (parameter.parameters.cir) {
        cirSelectedValue = quote.circuitInfo!.cir!;
      }
      if (parameter.parameters.portSize) {
        portSizeSelectedValue = quote.circuitInfo!.portSize!;
      }

      //bandwidthController.text = quote.circuitInfo!.bandwidth!;

      ddosSelectedValue = quote.circuitInfo!.ddosType!;
      if (quote.circuitInfo!.circuitType == 'DIA') {
        bgpSelectedValue = quote.circuitInfo!.bgpType!;

        if (bgpSelectedValue == 'No') {
          ipBlockSelectedValue = quote.circuitInfo!.ipBlock!;
        } else if (bgpSelectedValue == 'Current ASN(s)') {
          peeringTypeSelectedValue = quote.circuitInfo!.peeringType!;
        }
      }

      /* ipAdressSelectedValue = quote.circuitInfo!.ipType!;
      if (quote.circuitInfo!.ipType == 'Interface') {
        ipInterfaceSelectedValue = quote.circuitInfo!.interfaceType!;
      } else {
        subnetSelectedValue = quote.circuitInfo!.subnetType!;
      } */

      ///////////////Customer Info////////////////////////////////////////////////////////////////////

      companyController.text = quote.account!;
      nameController.text = quote.contactfirstname!;
      lastNameController.text = quote.contactlastname!;
      emailController.text = quote.contactemail!;
      phoneController.text = quote.contactphone!;

      ///////////////Totals////////////////////////////////////////////////////////////////////

      subtotal = quote.subtotal!;
      cost = quote.totals!.cost!;
      total = quote.totals!.total!;
      tax = quote.totals!.tax!;
      totalPlusTax = quote.totals!.totalTax!;
      margin = quote.totals!.margin!;

      for (var item in quote.items!) {
        globalRows.add(
          PlutoRow(
            cells: {
              'LINE_ITEM_Column': PlutoCell(value: item.lineItem),
              'UNIT_PRICE_Column': PlutoCell(value: item.unitPrice),
              'UNIT_COST_Column': PlutoCell(value: item.unitCost),
              'QUANTITY_Column': PlutoCell(value: item.quantity),
              'ACTIONS_Column': PlutoCell(value: ''),
            },
          ),
        );
      }

      ///////////////Comments////////////////////////////////////////////////////////////////////

      for (var comment in quote.comments!) {
        comments.add(
          Comment(
            role: comment.role,
            name: comment.name,
            comment: comment.comment,
            sended: comment.sended,
          ),
        );
      }

      notifyListeners();
      return true;
    } catch (e) {
      log('getDataV2() Error - $e');
      return false;
    }
  }
}
