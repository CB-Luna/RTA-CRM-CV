// import 'dart:developer';

import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
//import 'package:rta_crm_cv/models/crm/accounts/quotes_model.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_%20generic_cat.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_%20cat_order_info_types.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_cat_circuit_types.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_cat_vendor_model.dart';
import 'package:rta_crm_cv/models/crm/x2crm/model_x2_line_items.dart';
import 'package:rta_crm_cv/models/crm/x2crm/model_x2_quotes_view_v2.dart';
//import 'package:rta_crm_cv/models/crm/x2crm/model_x2_quotes_view.dart';
import 'package:rta_crm_cv/pages/crm/accounts/models/orders.dart';
import 'package:file_picker/file_picker.dart';

import 'package:http/http.dart' as http;

class CreateQuoteProvider extends ChangeNotifier {
  CreateQuoteProvider() {
    clearAll();
  }

  Future<void> clearAll() async {
    subtotal = 0;
    cost = 0;
    total = 0;
    taxController.text = '0';
    totalPlusTax = 0;
    margin = 0;

    await getCatalogData();

    //idVendor = null;

    lineItemCenterController.clear();
    unitPriceController.clear();
    unitCostController.clear();
    quantityController.clear();

    globalRows.clear();

    comments.clear();
    commentController.clear();

    pdfController = null;
    docProveedor = null;
    popupVisorPdfVisible = false;

    isLoading = false;
    //prevId = null;

    notifyListeners();
  }

  ModelX2V2QuotesView quote = ModelX2V2QuotesView();

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
  bool isLoading = false;

  var tableTop1Group = AutoSizeGroup();
  var tableTopGroup = AutoSizeGroup();
  var tableContentGroup = AutoSizeGroup();

  int totalItems = 0;
  double subtotal = 0;
  double cost = 0;
  double total = 0;
  final taxController = TextEditingController();
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
  //final locationController = TextEditingController();
  List<CatCircuitTypes> circuitTypeList = [CatCircuitTypes(name: 'NNI')];
  late String circuitTypeSelectedValue;
  //List<String> ddosList = ['Yes', 'No'];
  //late String ddosSelectedValue;
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
  List<String> subnetList = ['IPv4', 'IPv6'];
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

  void selectOT(String selected) {
    orderTypesSelectedValue = selected;
    notifyListeners();
  }

  void selectType(String selected) {
    typesSelectedValue = selected;
    newCircuitIDController.clear();
    notifyListeners();
  }

  void selectDataCenter(String selected) async {
    dataCenterSelectedValue = selected;
    newDataCenterController.clear();
    notifyListeners();
  }

  void selectHandoff(String selected) async {
    handoffSelectedValue = selected;
    notifyListeners();
  }

  void selectMulticastRequired() {
    multicastRequired = !multicastRequired;
    notifyListeners();
  }

  void selectCircuitInfo(String selected) {
    circuitTypeSelectedValue = selected;
    evcCircuitIdController.clear();
    selectCIR(cirList.first.name!);
    selectPortSize(cirList.first.name!);
    selectEVCOD(evcodList.first);
    notifyListeners();
  }

  void selectEVCOD(String selected) {
    evcodSelectedValue = selected;
    evcCircuitIdController.clear();
    notifyListeners();
  }

  void selectDDOS(/*String selected*/) {
    //ddosSelectedValue = selected;
    ddosSelectedValue = !ddosSelectedValue;
    notifyListeners();
  }

  void selectBGP(String selected) {
    bgpSelectedValue = selected;
    notifyListeners();
  }

  void selectIPAdress(String selected) {
    ipAdressSelectedValue = selected;
    selectIPInterface(ipInterfaceList[0]);
    selectSubnet(subnetList.first);
    notifyListeners();
  }

  void selectIPInterface(String selected) {
    ipInterfaceSelectedValue = selected;
    notifyListeners();
  }

  void selectSubnet(String selected) {
    subnetSelectedValue = selected;
    notifyListeners();
  }

  void selectCIR(String selected) {
    cirSelectedValue = selected;
    notifyListeners();
  }

  void selectPortSize(String selected) {
    portSizeSelectedValue = selected;
    notifyListeners();
  }

  void selectIpBlock(String selected) {
    ipBlockSelectedValue = selected;
    notifyListeners();
  }

  void selectPeeringType(String selected) {
    peeringTypeSelectedValue = selected;
    notifyListeners();
  }

  ////////////////////////////////////////////////////////
  /////////////////////////CREATE/////////////////////////
  ////////////////////////////////////////////////////////

  bool createValidation() {
    /* if (typesList[typesList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(typesSelectedValue))].parameters!.newCircuitId! && newCircuitIDController.text.isEmpty) {
      return false;
    } else if (typesList[typesList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(typesSelectedValue))].parameters!.existingCircuitId! &&
        existingCircuitIDController.text.isEmpty) {
      return false;
    } else */
    if (dataCenterSelectedValue == 'New' && newDataCenterController.text.isEmpty) {
      return false;
    } /* else if (demarcationPointController.text.isEmpty) {
      return false;
    } */
    else if (evcodSelectedValue == 'Existing EVC' && evcCircuitIdController.text.isEmpty) {
      return false;
    } else if (globalRows.isEmpty) {
      return false;
    } else if (imageBytes == null) {
      return false;
    } else {
      return true;
    }
  }

/*   Future<void> createQuote() async {
    try {
      isLoading = true;
      notifyListeners();

      Map<String, dynamic> orderInfo = {};
      //OrderType
      orderInfo.addAll(returnOrderType());
      //DataCenter
      orderInfo.addAll(returnDataCenter());

      //Vendor
      var responseVendor = await supabaseCRM.from('cat_vendors').select().eq('vendor_name', vendorSelectedValue);
      Vendor vendor = Vendor.fromJson(jsonEncode(responseVendor[0]));

      Map<String, dynamic> circuitInfo = {};
      //CircuitType
      circuitInfo.addAll(returnCircuitType());
      //DDoS - BGPerring
      circuitInfo.addAll({
        'ddos_type': ddosSelectedValue,
        'bgp_type': bgpSelectedValue,
      });
      //IP Adress
      circuitInfo.addAll(returnIPAdress());

      Map<String, dynamic> customerInfo = {
        "company": companyController.text,
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
      };

      Map<String, dynamic> totals = {
        "items": globalRows.length,
        "subtotal": subtotal,
        "cost": cost,
        "tax": double.parse(taxController.text.replaceAll(RegExp(r','), '')),
        "total": total,
        "total_tax": totalPlusTax,
        "margin": margin,
      };

      //Items
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
      //Comments
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
      /* if (idLead != null && prevId == null) {
        var resp = (await supabaseCRM.from('quotes').insert({
          "created_by": currentUser!.id,
          "updated_by": currentUser!.id,
          "status": margin > 20 ? "Finance Validate" : "Sen. Exec. Validate",
          "exp_close_date": DateTime.now().add(const Duration(days: 30)).toString(),
          "subtotal": subtotal,
          "cost": cost,
          "total": total,
          "tax": taxController.text != '' ? double.parse(taxController.text) : '0',
          "total_plus_tax": totalPlusTax,
          "margin": margin,
          "probability": 100,
          "order_info": quoteInfo,
          "items": items,
          "comments": commentsList,
          "id_quote_origin": null,
          "id_lead": idLead,
          "id_vendor": vendor.id,
          "id_status": margin > 20 ? 3 : 2
        }).select())[0];
        await supabaseCRM.from('quotes').update({"id_quote_origin": resp["id"]}).eq("id", resp["id"]);
        await supabaseCRM.from('leads_history').insert({
          "user": currentUser!.id,
          "action": 'INSERT',
          "description": 'New origin quote created',
          "table": 'quotes',
          "id_table": resp["id"].toString(),
          "name": "${currentUser!.name} ${currentUser!.lastName}"
        });
      } else {
        var response = await supabaseCRM.from('leads').select().eq('account', leadSelectedValue);
        Leads lead = Leads.fromJson(jsonEncode(response[0]));
        if (prevId != null) {
          var resp = (await supabaseCRM.from('quotes').insert({
            "created_by": currentUser!.id,
            "updated_by": currentUser!.id,
            "status": margin > 20 ? "Finance Validate" : "Sen. Exec. Validate",
            "exp_close_date": DateTime.now().add(const Duration(days: 30)).toString(),
            "subtotal": subtotal,
            "cost": cost,
            "total": total,
            "tax": taxController.text != '' ? double.parse(taxController.text) : '0',
            "total_plus_tax": totalPlusTax,
            "margin": margin,
            "probability": 100,
            "order_info": quoteInfo,
            "items": items,
            "comments": commentsList,
            "id_quote_origin": prevId,
            "id_lead": lead.id,
            "id_vendor": vendor.id,
            "id_status": margin > 20 ? 3 : 2,
          }).select())[0];
          await supabaseCRM.from('leads_history').insert({
            "user": currentUser!.id,
            "action": 'INSERT',
            "description": 'New quote created replacing the previous quote',
            "table": 'quotes',
            "id_table": resp["id"].toString(),
            "name": "${currentUser!.name} ${currentUser!.lastName}"
          });
          await supabaseCRM.from('quotes').update({"id_status": 6}).eq("id", prevId);
          await supabaseCRM.from('leads_history').insert({
            "user": currentUser!.id,
            "action": 'UPDATE',
            "description": 'Previous quote turns to Closed',
            "table": 'quotes',
            "id_table": prevId.toString(),
            "name": "${currentUser!.name} ${currentUser!.lastName}"
          });
          prevId = null;
        } else {
          var resp = (await supabaseCRM.from('quotes').insert({
            "created_by": currentUser!.id,
            "updated_by": currentUser!.id,
            "status": margin > 20 ? "Finance Validate" : "Sen. Exec. Validate",
            "exp_close_date": DateTime.now().add(const Duration(days: 30)).toString(),
            "subtotal": subtotal,
            "cost": cost,
            "total": total,
            "tax": taxController.text != '' ? double.parse(taxController.text) : '0',
            "total_plus_tax": totalPlusTax,
            "margin": margin,
            "probability": 100,
            "order_info": quoteInfo,
            "items": items,
            "comments": commentsList,
            "id_quote_origin": null,
            "id_lead": lead.id,
            "id_vendor": vendor.id,
            "id_status": margin > 20 ? 3 : 2,
          }).select())[0];
          await supabaseCRM.from('quotes').update({"id_quote_origin": resp["id"]}).eq("id", resp["id"]);
          await supabaseCRM.from('leads_history').insert({
            "user": currentUser!.id,
            "action": 'INSERT',
            "description": 'New origin quote created',
            "table": 'quotes',
            "id_table": resp["id"].toString(),
            "name": "${currentUser!.name} ${currentUser!.lastName}"
          });
        }
      } */
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log(e.toString());
    }
    clearAll();
    notifyListeners();
  }
 */
  Map<String, dynamic> returnIPAdress() {
    Map<String, dynamic> ipAdress = {};
    ipAdress.addAll({
      'ip_type': ipAdressSelectedValue,
      if (ipAdressSelectedValue == 'Interface') 'interface_type': ipInterfaceSelectedValue,
      if (ipAdressSelectedValue == 'IP Subnet') 'subnet_type': subnetSelectedValue,
    });

    return ipAdress;
  }

  Map<String, dynamic> returnCircuitType() {
    Map<String, dynamic> circuitType = {};

    circuitType.addAll({
      'multicast': multicastRequired,
      //'location': locationController.text,
      'circuit_type': circuitTypeSelectedValue,
      if (circuitTypeList[circuitTypeList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(circuitTypeSelectedValue))].parameters!.cir!) 'cir': cirSelectedValue,
      if (circuitTypeList[circuitTypeList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(circuitTypeSelectedValue))].parameters!.portSize!)
        'port_size': portSizeSelectedValue,
      if (circuitTypeList[circuitTypeList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(circuitTypeSelectedValue))].parameters!.evcod!)
        'evc_circuit_id': evcCircuitIdController.text,
    });

    return circuitType;
  }

  Map<String, dynamic> returnDataCenter() {
    Map<String, dynamic> dataCenter = {};
    if (dataCenterSelectedValue != 'New') {
      dataCenter.addAll({
        'data_center_type': 'Existing',
        'data_center_location': dataCenterSelectedValue,
        'rack_location': rackLocationController.text,
        'demarcation_point': demarcationPointController.text,
      });
    } else {
      dataCenter.addAll({
        'data_center_type': 'New',
        'data_center_location': newDataCenterController.text,
        'rack_location': rackLocationController.text,
        'demarcation_point': demarcationPointController.text,
      });
    }
    return dataCenter;
  }

  Map<String, dynamic> returnOrderType() {
    Map<String, dynamic> orderType = {};

    orderType.addAll({
      'order_type': orderTypesSelectedValue,
      'type': typesSelectedValue,
      if (typesList[typesList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(typesSelectedValue))].parameters!.existingCircuitId!)
        'existing_circuit_id': existingCircuitIDController.text,
      if (typesList[typesList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(typesSelectedValue))].parameters!.newCircuitId!)
        'new_circuit_id': newCircuitIDController.text,
      'handoff': handoffSelectedValue,
    });

    return orderType;
  }

/*   bool isValidated() {
    if (typesSelectedValue == 'New' && newCircuitIDController.text.isEmpty) {
      return false;
    } else if (typesSelectedValue == 'Disconnect' && existingCircuitIDController.text.isEmpty) {
      return false;
    } else if (typesSelectedValue == 'Upgrade' && existingCircuitIDController.text.isEmpty && newCircuitIDController.text.isEmpty) {
      return false;
    } else if (dataCenterSelectedValue == 'New' && existingCircuitIDController.text.isEmpty && newCircuitIDController.text.isEmpty) {
      return false;
    } else if (evcodSelectedValue == 'Existing EVC' && evcCircuitId.text.isEmpty) {
      return false;
    } else if (lineItemCenterController.text.isEmpty ||
        unitPriceController.text.isEmpty ||
        double.parse(unitPriceController.text.replaceAll(RegExp(r','), '')) < 0 ||
        unitCostController.text.isEmpty ||
        double.parse(unitCostController.text.replaceAll(RegExp(r','), '')) < 0 ||
        quantityController.text.isEmpty ||
        double.parse(quantityController.text.replaceAll(RegExp(r','), '')) < 0) {
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
        evcodId = evcCircuitId.text;
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
        'UNIT_PRICE_Column': PlutoCell(value: double.parse(unitPriceController.text.replaceAll(RegExp(r','), ''))),
        'UNIT_COST_Column': PlutoCell(value: double.parse(unitCostController.text.replaceAll(RegExp(r','), '')) * -1),
        'QUANTITY_Column': PlutoCell(value: int.parse(quantityController.text.replaceAll(RegExp(r','), ''))),
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

    void resetFormExpansionPanel() {
    existingCircuitIDController.clear();
    newCircuitIDController.clear();
    newDataCenterController.clear();
    evcCircuitId.clear();

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
 */

/*   void addRowPlutoGrid() {
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
        evcodId = evcCircuitId.text;
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
        'UNIT_PRICE_Column': PlutoCell(value: double.parse(unitPriceController.text.replaceAll(RegExp(r','), ''))),
        'UNIT_COST_Column': PlutoCell(value: double.parse(unitCostController.text.replaceAll(RegExp(r','), '')) * -1),
        'QUANTITY_Column': PlutoCell(value: int.parse(quantityController.text.replaceAll(RegExp(r','), ''))),
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
 */

  Function()? countRowsPlutoGrid() {
    totalItems = 0;
    subtotal = 0;
    cost = 0;
    total = 0;
    margin = 0;

    if (taxController.text.isEmpty) {
      taxController.text = '0';
    }

    // PlutoGrid
    for (var row in globalRows) {
      totalItems++;
      subtotal = (row.cells['UNIT_PRICE_Column']!.value * row.cells['QUANTITY_Column']!.value) + subtotal;
      cost = ((row.cells['UNIT_COST_Column']!.value) * row.cells['QUANTITY_Column']!.value) + cost;
    }

    total = subtotal - cost;

    if (taxController.text != '0' || taxController.text != '0.00' && double.parse(taxController.text.replaceAll(RegExp(r','), '')) != 0 && taxController.text.isNotEmpty) {
      totalPlusTax = (double.parse(taxController.text.replaceAll(RegExp(r','), '')) * total / 100) + total;
    } else {
      totalPlusTax = total;
    }

    if (totalPlusTax == 0 && subtotal == 0) {
      margin = 0;
    } else {
      margin = ((totalPlusTax-cost)/totalPlusTax) * 100;
    }
    notifyListeners();
    return null;
  }

  //int? prevId;

  /* Future<void> getData(String id) async {
    //TODO: Cambiar el select a la nueva tabla creada
    var response = await supabaseCRM.from('quotes_view').select().eq('id', int.parse(id));

    prevId = int.parse(id);

    if (response == null) {
      log('Error en getData()-DetailQuoteProvider');
      return;
    }

    Quotes quote = Quotes.fromJson(jsonEncode(response[0]));

    orderTypesSelectedValue = quote.orderInfo.orderType;
    typesSelectedValue = quote.orderInfo.type;
    if (quote.orderInfo.type == 'New Circuit') {
      existingCircuitIDController.text = quote.orderInfo.existingCircuitId!;
      newCircuitIDController.text = quote.orderInfo.newCircuitId!;
    } else if (quote.orderInfo.type == 'Circuit Removal') {
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

    var responseVendor = await supabaseCRM.from('cat_vendors').select().eq('id', quote.idVendor);
    idVendor = quote.idVendor;
    Vendor vendor = Vendor.fromJson(jsonEncode(responseVendor[0]));
    vendorSelectedValue = vendor.vendorName!;

    circuitTypeSelectedValue = quote.orderInfo.circuitType;
    if (quote.orderInfo.circuitType == 'EVCoD') {
      evcodSelectedValue = quote.orderInfo.evcodType!;
      if (quote.orderInfo.evcodType == 'Existing EVC') {
        evcCircuitId.text = quote.orderInfo.evcCircuitId!;
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

    notifyListeners();
  }
 */
  //int? idVendor;

/*   Future<void> getVendors() async {
    var response = await supabaseCRM.from('cat_vendors').select();

    List<Vendor> vendors = (response as List<dynamic>).map((vendor) => Vendor.fromJson(jsonEncode(vendor))).toList();

    vendorsList.clear();
    for (var vendor in vendors) {
      vendorsList.add(vendor.vendorName);
    }
    notifyListeners();

    selectVendor(vendors.first.vendorName);
  }
 */
  void selectVendor(String vendorName) {
    vendorSelectedValue = vendorName;
    notifyListeners();
  }

  ////////////////////////////////////////////////////////
  ///////////////////////////X2///////////////////////////
  ////////////////////////////////////////////////////////

  Future<bool> getCatalogData() async {
    try {
      dynamic response = await supabaseCRM.from('cat_order_types').select().eq('visible', true);
      orderTypesList.clear();
      orderTypesList = (response as List<dynamic>).map((index) => GenericCat.fromRawJson(jsonEncode(index))).toList();
      orderTypesSelectedValue = orderTypesList.first.name!;

      response = await supabaseCRM.from('cat_order_info_types').select().eq('visible', true).order('id', ascending: true);
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

      existingCircuitIDController.clear();
      newCircuitIDController.clear();
      addressController.clear();
      newDataCenterController.clear();
      rackLocationController.clear();
      demarcationPointController.clear();

      multicastRequired = false;
      //locationController.clear();
      evcodSelectedValue = evcodList.first;
      evcCircuitIdController.clear();
      //ddosSelectedValue = ddosList.first;

      ddosSelectedValue = false;
      ipBlockSelectedValue = ipBlockList.first.name!;
      peeringTypeSelectedValue = peeringTypeList.first.name!;
      ipAdressSelectedValue = ipAdressList.first;
      ipInterfaceSelectedValue = ipInterfaceList.first;
      subnetSelectedValue = subnetList.first;

      notifyListeners();
      return true;
    } catch (e) {
      log('Error getCatalogData() : e');
      return false;
    }
  }

  Future<void> getRowData(int id) async {
    try {
      await clearAll();

      var res = await supabaseCRM.from('x2_quotes_view_v2').select().eq('quoteid', id);

      quote = ModelX2V2QuotesView.fromJson(jsonEncode(res.first));

      //getLead////////////////////////////////////////////////////////////
      leadSelectedValue = quote.account ?? 'Not Configured';
      companyController.text = quote.account ?? 'Not Configured';
      nameController.text = quote.contactfirstname ?? 'Not Configured';
      lastNameController.text = quote.contactlastname ?? 'Not Configured';
      emailController.text = quote.contactemail ?? 'Not Configured';
      phoneController.text = quote.contactphone ?? 'Not Configured';

      //getItems////////////////////////////////////////////////////////////
      var request = http.Request('POST', Uri.parse(apiGatewayURL));
      var headers = {'Content-Type': 'application/json', 'key': supabase.auth.currentSession!.accessToken};
      request.headers.addAll(headers);
      request.body = json.encode(
        {
          "action": "GET_LINE_ITEMS",
          "id": id,
        },
      );

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        dynamic resp = jsonDecode(await response.stream.bytesToString());
        var lineItems = ModelX2LineItems.fromRawJson(jsonEncode(resp["result"]));

        if (quote.idOrders != null) {
          var prevQuoteRes = await supabaseCRM.from('x2_quotes_view_v2').select().eq('id_orders', quote.idOrders);
          ModelX2V2QuotesView prevQuote = ModelX2V2QuotesView.fromJson(jsonEncode(prevQuoteRes.first));

          for (var comment in prevQuote.comments!) {
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
        comments.add(
          Comment(
            role: 'X2',
            name: 'X2 Description',
            comment: lineItems.description!,
            sended: DateTime.now(),
          ),
        );

        for (var item in lineItems.items!) {
          globalRows.add(PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: item.id),
              'LINE_ITEM_Column': PlutoCell(value: item.name),
              'UNIT_PRICE_Column': PlutoCell(value: item.price),
              'UNIT_COST_Column': PlutoCell(value: item.adjustment! * -1),
              'QUANTITY_Column': PlutoCell(value: item.quantity),
              'ACTIONS_Column': PlutoCell(value: ''),
            },
          ));
        }
      } else {
        log(response.reasonPhrase.toString());
      }

      countRowsPlutoGrid();

      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> insertOrderInfo() async {
    try {
      isLoading = true;
      notifyListeners();

      /*  Map<String, dynamic> orderInfo = {
        'order_type': orderTypesSelectedValue,
        'type': typesSelectedValue,
        if (typesList[typesList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(typesSelectedValue))].parameters!.existingCircuitId!)
          'existing_circuit_id': "", //existingCircuitIDController.text,
        if (typesList[typesList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(typesSelectedValue))].parameters!.newCircuitId!)
          'new_circuit_id': "", //newCircuitIDController.text,
        'data_center_type': dataCenterSelectedValue == 'New' ? 'New' : 'Existing',
        'data_center_location': dataCenterSelectedValue == 'New' ? newDataCenterController.text : dataCenterSelectedValue,
        'handoff': "", //handoffSelectedValue,
        'rack_location': "", //rackLocationController.text,
        'demarcation_point': "", //demarcationPointController.text,
      };
 */
      //OrderType
      //orderInfo.addAll(returnOrderType());
      //DataCenter
      //orderInfo.addAll(returnDataCenter());

      //Vendor
      var responseVendor = await supabaseCRM.from('cat_vendors').select().eq('vendor_name', vendorSelectedValue);
      Vendor vendor = Vendor.fromJson(jsonEncode(responseVendor[0]));

/*       Map<String, dynamic> circuitInfo = {
        'multicast': multicastRequired,
        'location': locationController.text,
        'circuit_type': circuitTypeSelectedValue,
        if (circuitTypeList[circuitTypeList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(circuitTypeSelectedValue))].parameters!.cir!) 'cir': cirSelectedValue,
        if (circuitTypeList[circuitTypeList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(circuitTypeSelectedValue))].parameters!.portSize!)
          'port_size': portSizeSelectedValue,
        if (circuitTypeList[circuitTypeList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(circuitTypeSelectedValue))].parameters!.evcod!)
          'evc_circuit_id': evcCircuitIdController.text,
        'ddos_type': ddosSelectedValue,
        'bgp_type': bgpSelectedValue,
        'ip_type': ipAdressSelectedValue,
        if (ipAdressSelectedValue == 'Interface') 'interface_type': ipInterfaceSelectedValue,
        if (ipAdressSelectedValue == 'IP Subnet') 'subnet_type': subnetSelectedValue,
      }; */

      //CircuitType
      //circuitInfo.addAll(returnCircuitType());
      //DDoS - BGPerring
      /* circuitInfo.addAll({
        'ddos_type': ddosSelectedValue,
        'bgp_type': bgpSelectedValue,
      }); */
      //IP Adress
      //circuitInfo.addAll(returnIPAdress());

      /* Map<String, dynamic> customerInfo = {
        "company": companyController.text,
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
      }; */

      /* Map<String, dynamic> totals = {
        "items": globalRows.length,
        "subtotal": subtotal,
        "cost": cost,
        "tax": double.parse(taxController.text.replaceAll(RegExp(r','), '')),
        "total": total,
        "total_tax": totalPlusTax,
        "margin": margin,
      }; */

      //Items
      /* List<Map<String, dynamic>> itemsList = [];
      for (var row in globalRows) {
        Map<String, dynamic> item = {
          'id_quote_item': row.cells['ID_Column']!.value,
          'line_item': row.cells['LINE_ITEM_Column']!.value,
          'unit_price': row.cells['UNIT_PRICE_Column']!.value,
          'unit_cost': row.cells['UNIT_COST_Column']!.value,
          'quantity': row.cells['QUANTITY_Column']!.value,
        };
        itemsList.add(item);
      } */

      //Comments
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

      var resp = (await supabaseCRM.from('order_info').insert(
        {
          "created_by": currentUser!.id,
          "updated_by": currentUser!.id,
          "x2_quote_nameId": quote.x2Quoteid,
          "order_type": orderTypesSelectedValue,
          "type": typesSelectedValue,
          "existing_circuit_id": null,
          "new_circuit_id": null,
          "address": addressController.text,
          "data_center_type": dataCenterSelectedValue == 'New' ? 'New' : 'Existing',
          "data_center_location": dataCenterSelectedValue == 'New' ? newDataCenterController.text : dataCenterSelectedValue,
          "handoff": null,
          "rack_location": null,
          "demarcation_point": null,
          "vendor_id": vendor.id,
          "multicast": multicastRequired,
          //"location": locationController.text,
          "circuit_type": circuitTypeSelectedValue,
          "cir": circuitTypeList[circuitTypeList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(circuitTypeSelectedValue))].parameters!.cir! ? cirSelectedValue : null,
          "port_size": circuitTypeList[circuitTypeList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(circuitTypeSelectedValue))].parameters!.portSize!
              ? portSizeSelectedValue
              : null,
          "evc_circuit_id": circuitTypeList[circuitTypeList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(circuitTypeSelectedValue))].parameters!.evcod!
              ? evcCircuitIdController.text
              : null,
          "ddos_type": ddosSelectedValue,
          "bandwidth": null,
          "bgp_type": circuitTypeSelectedValue == "DIA" ? bgpSelectedValue : null,
          //"ip_type": ipAdressSelectedValue,
          //"interface_type": ipAdressSelectedValue == 'Interface' ? ipInterfaceSelectedValue : null,
          //"subnet_type": ipAdressSelectedValue == 'IP Subnet' ? subnetSelectedValue : null,
          "ip_block": circuitTypeSelectedValue == 'DIA' && bgpSelectedValue == 'No' ? ipBlockSelectedValue : null,
          "peering_type": circuitTypeSelectedValue == 'DIA' && bgpSelectedValue == 'Current ASN(s)' ? peeringTypeSelectedValue : null,
          "contact_id": quote.contactid,
          "items": totalItems,
          "subtotal": subtotal,
          "cost": cost,
          "tax": double.parse(taxController.text),
          "total": total,
          "total_tax": totalPlusTax,
          "margin": margin,
        },
      ).select())[0];

      for (var row in globalRows) {
        await supabaseCRM.from('line_items').insert(
          {
            "order_info_id": resp["id"],
            "id_quote_item": row.cells['ID_Column']!.value,
            "line_item": row.cells['LINE_ITEM_Column']!.value,
            "unit_price": row.cells['UNIT_PRICE_Column']!.value,
            "adjustment": row.cells['UNIT_COST_Column']!.value,
            "quantity": row.cells['QUANTITY_Column']!.value,
          },
        );
      }

      for (var comment in comments) {
        await supabaseCRM.from('order_comments').insert(
          {
            "order_info_id": resp["id"],
            "user_id": currentUser!.id,
            "role": comment.role,
            "name": comment.name,
            "comment": comment.comment,
            "sended": comment.sended!.toIso8601String(),
          },
        );
      }

      var responseImage = await supabase.storage.from('demarcation-points').uploadBinary('orderInfo_${resp["id"].toString()}_demarcationPoint.png', imageBytes!);

      if (responseImage.isNotEmpty) {
        responseImage = supabase.storage.from('demarcation-points').getPublicUrl(
              'orderInfo_${resp["id"].toString()}_demarcationPoint.png',
            );
        await supabaseCRM.from('order_info').update(
          {'demarcation_url': responseImage, 'demarcation_doc': 'orderInfo_${resp["id"].toString()}_demarcationPoint.png'},
        ).eq('id', resp["id"]);
      } else{
        
      }

        //History
        await supabaseCRM.from('leads_history').insert(
          {
            "action": 'INSERT',
            "description": 'OrderCreated - Order Inserted',
            "table": 'order_info',
            "id_table": resp["id"].toString(),
            "user": currentUser!.id,
            "name": "${currentUser!.name} ${currentUser!.lastName}"
          },
        );

      //Update Status
      if (margin > 20) {
        await supabaseCRM.from('x2_quotes').update({'id_status': 3}).eq('id', quote.quoteid);
      } else {
        await supabaseCRM.from('x2_quotes').update({'id_status': 2}).eq('id', quote.quoteid);
      }

      //History
      await supabaseCRM.from('leads_history').insert(
        {
          "action": 'UPDATE',
          "description": 'OrderCreated - Change Quote Status',
          "table": 'x2_quotes',
          "id_table": quote.quoteid,
          "user": currentUser!.id,
          "name": "${currentUser!.name} ${currentUser!.lastName}"
        },
      );

      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      log('insertQuoteInfo() - Error: $e');
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  ////////////////////////////////////////////////////////
  ///////////////////////////PDF//////////////////////////
  ////////////////////////////////////////////////////////

  bool popupVisorPdfVisible = true;
  FilePickerResult? docProveedor;
  PdfController? pdfController;

  void verPdf(bool visible) {
    popupVisorPdfVisible = visible;
    notifyListeners();
  }

  Uint8List? imageBytes;
  Future<void> pickDoc() async {
    FilePickerResult? picker = await FilePickerWeb.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png']);
    //get and load pdf
    if (picker != null) {
      docProveedor = picker;
      imageBytes = picker.files.single.bytes;
    } else {
      imageBytes = null;
    }

    notifyListeners();
    return;
  }
}
