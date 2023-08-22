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
  bool ordercreate = false;
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
  final rackLocationController = TextEditingController();
  final detailController = TextEditingController();
  final bandwidthController = TextEditingController();

////////////////////////////////////////////////////////////////////////////
  OrdersProvider() {
    updateState();
  }

  clearAll() {
    id = 0;
    editmode = false;
    ordercreate = false;
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
    rackLocationController.clear();
    detailController.clear();
    bandwidthController.clear();
  }

  Future<void> updateState() async {
    await clearAll();
  }

////////////////////////////////////////////////////////////////////////////
  Future<bool> getDemarkationImage(String x2quoteid) async {
    try {
      dynamic response = await supabaseCRM.from('order_info').select('demarcation_url').eq('x2_quote_nameId', x2quoteid);
      demarcationImage = DemarcationImage.fromJson(jsonEncode(response[0]));
      titulo = demarcationImage.demarcationUrl.toString();
      notifyListeners();
      return true;
    } catch (e) {
      log('Error getDemarkationImage() : e');
      return false;
    }
  }

  Future<void> getData(int idQuote, String x2quoteid) async {
    try {
      await clearAll();
      await getDemarkationImage(x2quoteid);
      var response = await supabaseCRM.from('x2_quotes_view_v2').select().eq('quoteid', idQuote);
      quote = ModelX2V2QuotesView.fromJson(jsonEncode(response[0]));
      //print(jsonEncode(response[0]));
      //Nombre popup
      typesSelectedValue.text = quote.orderInfo!.type!;
      orderTypesSelectedValue.text = quote.orderInfo!.orderType!;
      circuitTypeSelectedValue.text = quote.circuitInfo!.circuitType!;
      
      //Datos Form
      if ((typesSelectedValue.text == 'Migration' || typesSelectedValue.text == 'New Circuit' || typesSelectedValue.text == 'Upgrade') &&
          (circuitTypeSelectedValue.text == 'ASEoD' || circuitTypeSelectedValue.text == 'PTP')) {
        circuitAddressController.text = quote.orderInfo!.address!;
        circuitDetailController.text = quote.description!;
        portSizeSelectedValue.text = quote.circuitInfo!.portSize!;
        cirSelectedValue.text = quote.circuitInfo!.cir!;
      }
      if (circuitTypeSelectedValue.text == 'DIA') {
        circuitAddressController.text = quote.orderInfo!.address!;
        bandwidthController.text = quote.circuitInfo!.bandwidth!;
      }
      if (typesSelectedValue.text != 'Circuit Removal' && (circuitTypeSelectedValue.text == 'ASEoD' || circuitTypeSelectedValue.text == 'PTP')) {
        handoffSelectedValue.text = quote.orderInfo!.handoff!;
        demarcationPointController.text = quote.orderInfo!.demarcationPoint!;
        circuitAddressController.text = quote.orderInfo!.address!;
      }
      if (circuitTypeSelectedValue.text == 'NNI' || circuitTypeSelectedValue.text == 'X-Connect') {
        circuitAddressController.text = quote.orderInfo!.address!;
        rackLocationController.text = quote.orderInfo!.rackLocation!;
      }
      if (circuitTypeSelectedValue.text == 'X-Connect') {
        circuitAddressController.text = quote.orderInfo!.address!;
        detailController.text = quote.comments!.first.comment!; //quote.description!;
      }
      dataCenterSelectedValue.text = quote.orderInfo!.dataCenterLocation!;
    } catch (e) {
      log('Error en GetData() - $e');
    }
  }
}
