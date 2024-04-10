// import 'dart:developer';

import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
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
import 'package:rta_crm_cv/models/user.dart';
//import 'package:rta_crm_cv/models/crm/x2crm/model_x2_quotes_view.dart';
import 'package:rta_crm_cv/pages/crm/accounts/models/orders.dart';
import 'package:file_picker/file_picker.dart';

import 'package:http/http.dart' as http;

class CreateQuoteProvider extends ChangeNotifier {
  CreateQuoteProvider() {
    clearAll();
  }

  Future<void> clearAll() async {
    revenue = 0;
    cost = 0;
    net = 0;
    taxController.text = '0';
    pricePlusTax = 0;
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
          role: currentUser!.currentRole.roleName,
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
  double revenue = 0;
  double cost = 0;
  double net = 0;
  final taxController = TextEditingController();
  double pricePlusTax = 0;
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
    } /* else if (imageBytes == null) {
      return false;
    } */
    else if (margin.isInfinite) {
      return false;
    } else {
      return true;
    }
  }

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

  Function()? countRowsPlutoGrid() {
    totalItems = 0;
    revenue = 0;
    cost = 0;
    net = 0;
    margin = 0;

    if (taxController.text.isEmpty) {
      taxController.text = '0';
    }

    // PlutoGrid
    for (var row in globalRows) {
      totalItems++;
      revenue = (row.cells['UNIT_PRICE_Column']!.value * row.cells['QUANTITY_Column']!.value) + revenue;
      cost = ((row.cells['UNIT_COST_Column']!.value) * row.cells['QUANTITY_Column']!.value) + cost;
    }

    net = revenue - cost;

    if (taxController.text != '0' || taxController.text != '0.00' && double.parse(taxController.text.replaceAll(RegExp(r','), '')) != 0 && taxController.text.isNotEmpty) {
      pricePlusTax = (double.parse(taxController.text.replaceAll(RegExp(r','), '')) * revenue / 100) + revenue;
    } else {
      pricePlusTax = revenue;
    }

    //var profit = net - cost;

    if (pricePlusTax == 0 && revenue == 0) {
      margin = 0;
    } else if (cost == 0) {
      margin = 100;
    } else {
      margin = (net / revenue) * 100;
    }
    notifyListeners();
    return null;
  }

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

      response = await supabaseCRM.from('cat_vendors').select().eq('visible', true).order('vendor_name', ascending: true);
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
        lineItems.items!.removeWhere((element) => element.name == 'x2comment' /* || element.name == 'x2adjustment' */);

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
              'UNIT_COST_Column': PlutoCell(value: item.adjustment),
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

  /* Future<bool> salesAcceptsQuoteOperation() async {
    try {
      final res = await supabase.rpc('get_correo', params: {"role_id": 7});
      if (res == null) {
        log('Error en get_correo()');
      }
      for (var email in res) {
        //Json del correo;
        String body = jsonEncode(
          {
            "action": "rtaMail",
            "template": "SalesAcceptsQuoteSenExec", //TODO: Checar Template
            "subject": "Validate quote - RTA WHOLESALE",
            "mailto": email['email'], //Operations nestalon1993@gmail.com
            "variables": [
              {"name": "quote.quote", "value": "${quote.quote}"},
              {"name": "quote.quoteid", "value": "${quote.quoteid}"},
              {"name": "quote.status", "value": "Engineer Validate"},
              {"name": "quote.account", "value": "${quote.account}"},
              {"name": "currentUser!.id", "value": currentUser!.name}
            ]
          },
        );
        var urlAutomatizacion = Uri.parse(urlNotifications);
        //headers
        final headers = ({
          "Content-Type": "application/json",
        });
        var responseAutomatizacion = await post(urlAutomatizacion, headers: headers, body: body);
        if (responseAutomatizacion.statusCode == 200) {
          //Se marca como ejecutada la instrucción en Bitacora
          log('Se envio correo con exito');
          notifyListeners();
        }
      }

      return true;
    } catch (e) {
      log('insertQuoteInfo() - Error: $e');
      notifyListeners();
      return false;
    }
  } */

  Future<bool> insertOrderInfo() async {
    try {
      isLoading = true;
      notifyListeners();

      Map<String, dynamic> orderInfo = {
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

      //OrderType
      orderInfo.addAll(returnOrderType());
      //DataCenter
      orderInfo.addAll(returnDataCenter());

      //Vendor
      var responseVendor = await supabaseCRM.from('cat_vendors').select().eq('vendor_name', vendorSelectedValue);
      Vendor vendor = Vendor.fromJson(jsonEncode(responseVendor[0]));

      Map<String, dynamic> circuitInfo = {
        'multicast': multicastRequired,
        //'location': locationController.text,
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
      };

      //CircuitType
      //circuitInfo.addAll(returnCircuitType());
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
        "subtotal": revenue,
        "cost": cost,
        "tax": double.parse(taxController.text.replaceAll(RegExp(r','), '')),
        "total": net,
        "total_tax": pricePlusTax,
        "margin": margin,
      };

      //Items
      List<Map<String, dynamic>> itemsList = [];
      for (var row in globalRows) {
        Map<String, dynamic> item = {
          'id_quote_item': row.cells['ID_Column']!.value,
          'line_item': row.cells['LINE_ITEM_Column']!.value,
          'unit_price': row.cells['UNIT_PRICE_Column']!.value,
          'unit_cost': row.cells['UNIT_COST_Column']!.value.toDouble(),
          'quantity': row.cells['QUANTITY_Column']!.value,
        };
        itemsList.add(item);
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
          "demarcation_point": demarcationPointController.text,
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
          "subtotal": revenue,
          "cost": cost,
          "tax": double.parse(taxController.text),
          "total": net,
          "total_tax": pricePlusTax,
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
            "adjustment": row.cells['UNIT_COST_Column']!.value.toDouble(),
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

      if (imageBytes != null) {
        var responseImage = await supabase.storage.from('demarcation-points').uploadBinary('orderInfo_${resp["id"].toString()}_demarcationPoint.png', imageBytes!);

        if (responseImage.isNotEmpty) {
          responseImage = supabase.storage.from('demarcation-points').getPublicUrl(
                'orderInfo_${resp["id"].toString()}_demarcationPoint.png',
              );
          await supabaseCRM.from('order_info').update(
            {'demarcation_url': responseImage, 'demarcation_doc': 'orderInfo_${resp["id"].toString()}_demarcationPoint.png'},
          ).eq('id', resp["id"]);
        }
      }

      //History
      await supabaseCRM.from('leads_history').insert(
        {
          "action": 'INSERT',
          "description": 'Order Created',
          "table": 'order_info',
          "id_table": resp["id"].toString(),
          "user": currentUser!.id,
          "name": "${currentUser!.name} ${currentUser!.lastName}"
        },
      );

      await callAirflow();

      //Update Status
      /* await supabaseCRM.rpc(
        'update_quote_status',
        params: {"id_status": 4, "id": quote.quoteid, "user_uuid": currentUser!.id}, //Engineer Validate
      ); */
      //await salesAcceptsQuoteOperation(); //Sales a Operations

      //History
      /* await supabaseCRM.from('leads_history').insert(
        {
          "action": 'UPDATE',
          "description": 'OrderCreated - Change Quote Status',
          "table": 'x2_quotes',
          "id_table": quote.quoteid,
          "user": currentUser!.id,
          "name": "${currentUser!.name} ${currentUser!.lastName}"
        },
      ); */

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

  Future<void> callAirflow() async {
    var request = http.Request('POST', Uri.parse(apiGatewayURL));
    var headers = {'Content-Type': 'application/json', 'key': supabase.auth.currentSession!.accessToken};
    request.headers.addAll(headers);
    request.body = json.encode(
      {
        "action": "AIRFLOW",
        "process": "quote_validate_v1",
        "data": {
          "x2_quote_id": quote.quoteid,
          "x2_quote_name": quote.quote,
          "x2_quote_account": quote.account,
          "id_status": quote.idStatus,
          "currentUserId": currentUser!.id,
          "currentUserFullName": currentUser!.fullName,
          "validated": true,
        }
      },
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      log(await response.stream.bytesToString());
    } else {
      log(response.reasonPhrase!);
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
