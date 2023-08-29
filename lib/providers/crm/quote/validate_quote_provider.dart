// import 'dart:developer';

import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
//import 'package:rta_crm_cv/models/crm/accounts/quotes_model.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_%20cat_order_info_types.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_%20generic_cat.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_cat_circuit_types.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_cat_vendor_model.dart';
//import 'package:rta_crm_cv/models/crm/x2crm/model_x2_quotes_view.dart';
import 'package:rta_crm_cv/models/crm/x2crm/model_x2_quotes_view_v2.dart';
import 'package:rta_crm_cv/pages/crm/accounts/models/orders.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ValidateQuoteProvider extends ChangeNotifier {
  ValidateQuoteProvider() {
    realTimeSuscription();
    clearAll();
  }

  int id = 0;
  late ModelX2V2QuotesView quote;

  clearAll() async {
    id = 0;
    subtotal = 0;
    cost = 0;
    total = 0;
    tax = 0;
    totalPlusTax = 0;
    margin = 0;

    existingCircuitIDController.clear();
    newCircuitIDController.clear();
    newDataCenterController.clear();
    addressController.clear();
    rackLocationController.clear();
    demarcationPointController.clear();

    multicastRequired = false;
    locationController.clear();
    evcodSelectedValue = evcodList.first;
    evcCircuitIdController.clear();
    //ddosSelectedValue = ddosList.first;
    ddosSelectedValue = false;
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

    isLoading = false;

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
      }

      await supabaseCRM.from('orders_info').update({'comments': commentsList}).eq('id', quote.idOrders); */

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

  bool isLoading = false;

  void selectHandoff(String selected) async {
    handoffSelectedValue = selected;
    notifyListeners();
  }

/* 
  Future<void> validate(bool validate) async {
    try {
      isLoading = true;
      notifyListeners();
      if (validate) {
        if (currentUser!.isSenExec) {
          await supabaseCRM.rpc(
            'update_quote_status',
            params: {"id_status": 3, "id": id, "user_uuid": currentUser!.id}, //Finance Validate
          );
          await supabaseCRM.from('leads_history').insert({
            "user": currentUser!.id,
            "action": 'UPDATE',
            "description": 'Quote validated by Sen. Exec.',
            "table": 'quotes',
            "id_table": id,
            "name": "${currentUser!.name} ${currentUser!.lastName}"
          });
        } else if (currentUser!.isFinance) {
          await supabaseCRM.rpc(
            'update_quote_status',
            params: {"id_status": 4, "id": id, "user_uuid": currentUser!.id}, //Engineer Validate
          );
          await supabaseCRM.from('leads_history').insert(
              {"user": currentUser!.id, "action": 'UPDATE', "description": 'Quote validated by Finance', "table": 'quotes', "id_table": id, "name": "${currentUser!.name} ${currentUser!.lastName}"});
        } else if (currentUser!.isOpperations) {
          await supabaseCRM.rpc(
            'update_quote_status',
            params: {"id_status": 7, "id": id, "user_uuid": currentUser!.id}, //Approved
          );
          await supabaseCRM.from('leads_history').insert({
            "user": currentUser!.id,
            "action": 'UPDATE',
            "description": 'Quote validated by Opperations',
            "table": 'quotes',
            "id_table": id,
            "name": "${currentUser!.name} ${currentUser!.lastName}"
          });
        }
      } else {
        await supabaseCRM.rpc(
          'update_quote_status',
          params: {"id_status": 5, "id": id, "user_uuid": currentUser!.id}, //Rejected
        );
        await supabaseCRM
            .from('leads_history')
            .insert({"user": currentUser!.id, "action": 'UPDATE', "description": 'Quote rejected', "table": 'quotes', "id_table": id, "name": "${currentUser!.name} ${currentUser!.lastName}"});
      }
    } catch (e) {
      log('Error en validate() - $e');
    }
    clearAll();
  }
 */
  Future<bool> validateV2(bool validate) async {
    bool returning = false;
    try {
      isLoading = true;
      notifyListeners();
      if (validate) {
        if (currentUser!.isSenExec) {
          await updateRegister(3, quote.quoteid!);

          await supabaseCRM.from('leads_history').insert({
            "user": currentUser!.id,
            "action": 'UPDATE',
            "description": 'Quote validated by Sen. Exec.',
            "table": 'x2_quotes',
            "id_table": quote.quoteid,
            "name": "${currentUser!.name} ${currentUser!.lastName}"
          });
        } else if (currentUser!.isFinance) {
          await updateRegister(4, quote.quoteid!);

          await supabaseCRM.from('leads_history').insert({
            "user": currentUser!.id,
            "action": 'UPDATE',
            "description": 'Quote validated by Finance',
            "table": 'x2_quotes',
            "id_table": quote.quoteid,
            "name": "${currentUser!.name} ${currentUser!.lastName}",
          });
        } else if (currentUser!.isOpperations) {
          await updateRegister(7, quote.quoteid!);

          await supabaseCRM.from('order_info').update({
            "handoff": handoffSelectedValue,
            "rack_location": rackLocationController.text,
            "demarcation_point": demarcationPointController.text,
            "existing_circuit_id": existingCircuitIDController.text,
            "new_circuit_id": newCircuitIDController.text,
            "bandwidth": bandwidthController.text,
          }).eq('id', quote.idOrders!);

          await supabaseCRM.from('leads_history').insert({
            "user": currentUser!.id,
            "action": 'UPDATE',
            "description": 'Quote validated by Opperations',
            "table": 'x2_quotes',
            "id_table": quote.quoteid,
            "name": "${currentUser!.name} ${currentUser!.lastName}"
          });
        }
        returning = true;
      } else {
        await updateRegister(5, quote.quoteid!);

        await supabaseCRM.from('order_info').update({
          "handoff": handoffSelectedValue,
          "rack_location": rackLocationController.text,
          "demarcation_point": demarcationPointController.text,
          "existing_circuit_id": existingCircuitIDController.text,
          "new_circuit_id": newCircuitIDController.text,
        }).eq('id', quote.idOrders!);

        await supabaseCRM.from('leads_history').insert({
          "user": currentUser!.id,
          "action": 'UPDATE',
          "description": 'Quote rejected',
          "table": 'quotes',
          "id_table": id,
          "name": "${currentUser!.name} ${currentUser!.lastName}",
        });
        returning = true;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      log('Error en validate() - $e');
      return returning;
    }
    clearAll();
    return returning;
  }

  Future<void> updateRegister(int idStatus, int quoteId) async {
    await supabaseCRM.rpc(
      'update_quote_status',
      params: {"id_status": idStatus, "id": quoteId, "user_uuid": currentUser!.id}, //Network Cross Connected
    );

    /* await supabaseCRM.from('x2_quotes').update({
      'id_status': idStatus,
    }).eq('id', quoteId);
    await supabaseCRM.from('order_info').update(
      {
        'updated_at': DateTime.now().toIso8601String(),
        'updated_by': currentUser!.id,
      },
    ).eq('id', orderId); */
  }

/*   Future<void> getData() async {
    clearAll();

    if (id != null) {
      var response = await supabaseCRM.from('quotes_view').select().eq('id', id);

      if (response == null) {
        log('Error en getData()-DetailQuoteProvider');
        return;
      }

      Quotes quote = Quotes.fromJson(jsonEncode(response[0]));

      orderTypesSelectedValue = quote.orderInfo.orderType;
      typesSelectedValue = quote.orderInfo.type;
      if (quote.orderInfo.type == 'New') {
        newCircuitIDController.text = quote.orderInfo.newCircuitId!;
      } else if (quote.orderInfo.type == 'Disconnect') {
        evcCircuitId.text = quote.orderInfo.existingCircuitId!;
      } else if (quote.orderInfo.type == 'Upgrade') {
        evcCircuitId.text = quote.orderInfo.existingCircuitId!;
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

      companyController.clear();
      nameController.clear();
      lastNameController.clear();
      emailController.clear();
      phoneController.clear();

      var responseLead = await supabaseCRM.from('leads').select().eq('id', quote.idLead);

      Leads lead = Leads.fromJson(jsonEncode(responseLead[0]));

      companyController.text = lead.account;
      nameController.text = lead.firstName;
      lastNameController.text = lead.lastName;
      emailController.text = lead.email;
      phoneController.text = lead.phoneNumber;

      subtotal = quote.subtotal;
      cost = quote.cost;
      total = quote.total;
      tax = quote.tax;
      totalPlusTax = quote.totalPlusTax;
      margin = quote.margin;

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
 */

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
      /* if (parameter.parameters.newCircuitId) {
        newCircuitIDController.text = quote.orderInfo!.newCircuitId ?? '';
      }
      if (parameter.parameters.existingCircuitId) {
        existingCircuitIDController.text = quote.orderInfo!.existingCircuitId ?? '';
      } */

      addressController.text = quote.orderInfo!.address!;

      if (quote.orderInfo!.dataCenterType == 'New') {
        dataCenterSelectedValue = 'New';
        newDataCenterController.text = quote.orderInfo!.dataCenterLocation!;
      } else {
        dataCenterSelectedValue = quote.orderInfo!.dataCenterLocation!;
      }

      //rackLocationController.text = quote.orderInfo!.rackLocation ?? '';
      //handoffSelectedValue = quote.orderInfo!.handoff ?? '';
      //demarcationPointController.text = quote.orderInfo!.demarcationPoint ?? '';

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
          evcCircuitId.text = quote.circuitInfo!.evcCircuitId!;
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

      ddosSelectedValue = quote.circuitInfo!.ddosType!;
      if (quote.circuitInfo!.circuitType == 'DIA') {
        bgpSelectedValue = quote.circuitInfo!.bgpType!;
      }

      ipAdressSelectedValue = quote.circuitInfo!.ipType!;
      if (quote.circuitInfo!.ipType == 'Interface') {
        ipInterfaceSelectedValue = quote.circuitInfo!.interfaceType!;
      } else {
        subnetSelectedValue = quote.circuitInfo!.subnetType!;
      }

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
}
