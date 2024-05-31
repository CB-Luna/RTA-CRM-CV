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
    revenue = 0;
    cost = 0;
    net = 0;
    tax = 0;
    pricePlusTax = 0;
    margin = 0;

    existingCircuitIDController.clear();
    newCircuitIDController.clear();
    addressController.clear();
    newDataCenterController.clear();
    rackLocationController.clear();
    demarcationPointController.clear();
    latController.clear();
    longController.clear();

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
    titulo = '';

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
          "role": currentUser!.currentRole.roleName,
          "name": currentUser!.name,
          "comment": commentController.text,
          "sended": DateTime.now().toIso8601String(),
        },
      );
      comments.add(
        Comment(
          role: currentUser!.currentRole.roleName,
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

  //TOTALS
  int totalItems = 0;
  double revenue = 0;
  double cost = 0;
  double net = 0;
  double tax = 0;
  double pricePlusTax = 0;
  double margin = 0;

  //ORDER INFO
  List<GenericCat> orderTypesList = [GenericCat(name: 'Internal Circuit')];
  late String orderTypesSelectedValue;
  List<CatOrderInfoTypes> typesList = [CatOrderInfoTypes(name: 'New')];
  late String typesSelectedValue;
  final existingCircuitIDController = TextEditingController();
  final newCircuitIDController = TextEditingController();
  final addressController = TextEditingController();
  final demarcationPointController = TextEditingController();
  List<GenericCat> dataCentersList = [GenericCat(name: 'New')];
  late String dataCenterSelectedValue;
  final newDataCenterController = TextEditingController();
  final rackLocationController = TextEditingController();
  List<GenericCat> handoffList = [GenericCat(name: 'New')];
  late String handoffSelectedValue;
  bool? powerMode;
  late String titulo;
  final latController = TextEditingController();
  final longController = TextEditingController();

  //CIRCUIT INFO
  List<Vendor> vendorsList = [Vendor(vendorName: 'ATT')];
  String vendorSelectedValue = '';
  bool multicastRequired = false;
  //final locationController = TextEditingController();
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

  //ITEMS INFO
  final lineItemCenterController = TextEditingController();
  final unitPriceController = TextEditingController();
  final unitCostController = TextEditingController();
  final quantityController = TextEditingController();

  //CUSTOMER INFO
  List<String> leadsList = [''];
  String leadSelectedValue = '';
  final companyController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

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

      demarcationPointController.text = quote.orderInfo!.demarcationPoint ?? '';

      if (quote.orderInfo!.dataCenterType == 'New') {
        dataCenterSelectedValue = 'New';
        newDataCenterController.text = quote.orderInfo!.dataCenterLocation!;
      } else {
        dataCenterSelectedValue = quote.orderInfo!.dataCenterLocation!;
      }

      rackLocationController.text = quote.orderInfo!.rackLocation ?? '';
      handoffSelectedValue = quote.orderInfo!.handoff ?? '';
      powerMode = quote.orderInfo!.powerMode;
      if (quote.demarcationUrl == null) {
        titulo = '';
      } else {
        titulo = quote.demarcationUrl!.toString();
      }

      latController.text = quote.orderInfo!.lat.toString();
      longController.text = quote.orderInfo!.long.toString();

      ///////////////Circuit Info////////////////////////////////////////////////////////////////////

      vendorSelectedValue = quote.vendor!;
      multicastRequired = quote.circuitInfo!.multicast!;
      //locationController.text = quote.circuitInfo!.location!;
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
      nameController.text = quote.contactfirstname ?? 'Not Configured';
      lastNameController.text = quote.contactlastname ?? 'Not Configured';
      emailController.text = quote.contactemail ?? 'Not Configured';
      phoneController.text = quote.contactphone ?? 'Not Configured';

      ///////////////Totals////////////////////////////////////////////////////////////////////

      revenue = quote.subtotal!;
      cost = quote.totals!.cost!;
      net = quote.totals!.total!;
      tax = quote.totals!.tax!;
      pricePlusTax = quote.totals!.totalTax!;
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
