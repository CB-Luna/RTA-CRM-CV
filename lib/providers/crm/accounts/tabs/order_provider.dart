import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart' hide State;
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/crm/dashboard_crm/demarkation_imagen.dart';
import 'package:rta_crm_cv/models/crm/x2crm/model_x2_quotes_view_v2.dart';

class OrdersProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<String> vendorsList = [];
  bool editmode = false;
  late int? id;
  DateTime create = DateTime.now();
  late ModelX2V2QuotesView quote;
  late DemarcationImage demarcationImage;
  late String titulo;

  //Nombre popup
  final typesSelectedValue = TextEditingController();
  final orderTypesSelectedValue = TextEditingController();
  final circuitTypeSelectedValue = TextEditingController();

  //Datos Form
  final circuitAddressController = TextEditingController();
  final circuitDetailController = TextEditingController();
  final dataCenterSelectedValue = TextEditingController();
  final portSizeSelectedValue = TextEditingController();
  final cirSelectedValue = TextEditingController();
  final handoffSelectedValue = TextEditingController();
  final demarcationPointController = TextEditingController();
  final powermodeController = TextEditingController();
  //final rackLocationController = TextEditingController();
  final detailController = TextEditingController();
  //final bandwidthController = TextEditingController();

////////////////////////////////////////////////////////////////////////////
  OrdersProvider() {
    updateState();
  }

  clearAll() {
    id = 0;
    editmode = false;
    create = DateTime.now();
    titulo = '';
    //Nombre popup
    typesSelectedValue.clear();
    orderTypesSelectedValue.clear();
    circuitTypeSelectedValue.clear();
    //addres circuit

    //Datos Form
    circuitAddressController.clear();
    circuitDetailController.clear();
    dataCenterSelectedValue.clear();
    portSizeSelectedValue.clear();
    cirSelectedValue.clear();
    handoffSelectedValue.clear();
    demarcationPointController.clear();
    powermodeController.clear();
    //rackLocationController.clear();
    detailController.clear();
    //bandwidthController.clear();
  }

  Future<void> updateState() async {
    await clearAll();
  }

////////////////////////////////////////////////////////////////////////////

  Future<void> getData(int idQuote) async {
    try {
      await clearAll();
      var response = await supabaseCRM.from('x2_quotes_view_v2').select().eq('quoteid', idQuote);
      quote = ModelX2V2QuotesView.fromJson(jsonEncode(response[0]));
      //print(jsonEncode(response[0]));
      //Nombre popup
      typesSelectedValue.text = quote.orderInfo!.type!;
      orderTypesSelectedValue.text = quote.orderInfo!.orderType!;
      circuitTypeSelectedValue.text = quote.circuitInfo!.circuitType!;
      if (quote.demarcationUrl == null) {
        titulo = '';
      } else {
        titulo = quote.demarcationUrl!.toString();
      }

      //Datos Form
      if (circuitTypeSelectedValue.text == 'ASEoD' || circuitTypeSelectedValue.text == 'PTP') {
        circuitAddressController.text = quote.orderInfo!.address!;
        circuitDetailController.text = quote.description!;
        portSizeSelectedValue.text = quote.circuitInfo!.portSize!;
        cirSelectedValue.text = quote.circuitInfo!.cir!;
      }
      if (circuitTypeSelectedValue.text == 'DIA') {
        circuitAddressController.text = quote.orderInfo!.address!;
        //bandwidthController.text = quote.circuitInfo!.bandwidth!;
      }
      if (typesSelectedValue.text != 'Removal' && (circuitTypeSelectedValue.text == 'ASEoD' || circuitTypeSelectedValue.text == 'PTP')) {
        handoffSelectedValue.text = quote.orderInfo!.handoff!;
        demarcationPointController.text = quote.orderInfo!.demarcationPoint!;
        circuitAddressController.text = quote.orderInfo!.address!;
      }
      if (circuitTypeSelectedValue.text == 'NNI' || circuitTypeSelectedValue.text == 'X-Connect') {
        circuitAddressController.text = quote.orderInfo!.address!;
        //rackLocationController.text = quote.orderInfo!.rackLocation!;
      }
      if (circuitTypeSelectedValue.text == 'X-Connect') {
        circuitAddressController.text = quote.orderInfo!.address!;
        detailController.text = quote.comments!.first.comment!; //quote.description!;
      }
      dataCenterSelectedValue.text = quote.orderInfo!.dataCenterLocation!;
      powermodeController.text = quote.orderInfo!.powerMode! ? 'DC' : 'AC';
    } catch (e) {
      log('Error en GetData() - $e');
    }
  }
}
