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

class ValidateQuoteProvider extends ChangeNotifier {
  /* Future<void> updateState() async {
    clearAll();
    await getData();
  } */

  ValidateQuoteProvider() {
    realTimeSuscription();
    clearAll();
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

    isLoading = false;
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

  bool isLoading = false;

  Future<void> validate(bool validate) async {
    try {
      isLoading = true;
      notifyListeners();
      if (validate) {
        if (currentUser!.isFinance) {
          await supabaseCRM.rpc('update_quote_status', params: {"estatus": "Finance Validate", "id": id, "user_uuid": currentUser!.id});
        } else if (currentUser!.isSenExec) {
          await supabaseCRM.rpc('update_quote_status', params: {"estatus": "SenExec Validate", "id": id, "user_uuid": currentUser!.id});
        } else if (currentUser!.isOpperations) {
          await supabaseCRM.rpc('update_quote_status', params: {"estatus": "Accepted", "id": id, "user_uuid": currentUser!.id});
        }
      } else {
        await supabaseCRM.rpc('update_quote_status', params: {"estatus": "Rejected", "id": id, "user_uuid": currentUser!.id});
      }
    } catch (e) {
      log('Error en validate() - $e');
    }
    id = null;
    clearAll();
  }

  Future<void> getData() async {
    clearAll();

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
}
