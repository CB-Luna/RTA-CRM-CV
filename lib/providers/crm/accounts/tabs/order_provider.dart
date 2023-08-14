import 'dart:convert';
import 'dart:developer';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide State;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_%20cat_order_info_types.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_%20generic_cat.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_cat_circuit_types.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_cat_vendor_model.dart';
import 'package:rta_crm_cv/models/crm/dashboard_crm/demarkation_imagen.dart';
import 'package:rta_crm_cv/models/crm/x2crm/model_x2_quotes_view.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class OrdersProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<String> vendorsList = [];
  bool editmode = false;
  bool ordercreate = false;
  late int? id;
  DateTime create = DateTime.now();
  late ModelX2QuotesView quote;
  late DemarcationImage demarcationImage;
  late String titulo;

  //Nombre popup
  final  typesSelectedValue= TextEditingController();
  final  orderTypesSelectedValue= TextEditingController();
  final  circuitTypeSelectedValue= TextEditingController();

  //Datos Form
  final circuitAddressController = TextEditingController();
  final circuitDetailController = TextEditingController();
  final  dataCenterSelectedValue= TextEditingController();
  final  portSizeSelectedValue= TextEditingController();
  final  cirSelectedValue= TextEditingController();
  final  handoffSelectedValue= TextEditingController();
  final demarcationPointController = TextEditingController();
  final rackLocationController = TextEditingController();

////////////////////////////////////////////////////////////////////////////
  OrdersProvider() {
    updateState();
  }

  clearAll() {
    id = 0;
    editmode = false;
    ordercreate = false;
    create = DateTime.now();
    titulo='';
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
  }

  Future<void> updateState() async {
    await clearAll();
  }

////////////////////////////////////////////////////////////////////////////

  Future<void> selectdate(
    BuildContext context,
  ) async {
    DateTime? newDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppTheme.of(context).primaryColor, // color Appbar
                onPrimary: AppTheme.of(context).primaryBackground, // Color letras
                onSurface: AppTheme.of(context).primaryColor, // Color Meses
              ),
              dialogBackgroundColor: AppTheme.of(context).primaryBackground,
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: create,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (newDate == null) return;
    create = newDate;
    notifyListeners();
  }

  Future<void> createOrder() async {
    try {
      //Registrar al usuario con una contraseña temporal
      var resp = (await supabaseCRM.from('leads').insert({
        "probability": '',
        "expected_close": create.toString(),
        "assigned_to": 'selectAssignedTValue',
        "status": "In process",
        "sales_stage": 'selectSaleStoreValue',
        "lead_source": 'selectLeadSourceValue',
      }).select())[0];

      await supabaseCRM.from('leads_history').insert({
        "user": currentUser!.id,
        "action": 'INSERT',
        "description": 'New Lead created',
        "table": 'leads',
        "id_table": resp["id"].toString(),
        "name": "${currentUser!.name} ${currentUser!.lastName}"
      });
    } catch (e) {
      log('Error en registrarOpportunity() - $e');
    }
  }

  
  Future<bool> getDemarkationImage(String x2quoteid) async {
    try {
      dynamic response = await supabaseCRM.from('orders_info').select('demarcation_url').eq('x2_quote_nameId', x2quoteid);
      demarcationImage = DemarcationImage.fromJson(jsonEncode(response[0]));
      titulo=demarcationImage.demarcationUrl.toString();
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
      var response = await supabaseCRM.from('x2_quotes_view').select().eq('quoteid', idQuote);
      quote = ModelX2QuotesView.fromRawJson(jsonEncode(response[0]));
      //Nombre popup
      typesSelectedValue.text = quote.orderInfo!.type!;
      orderTypesSelectedValue.text = quote.orderInfo!.orderType!;
      circuitTypeSelectedValue.text = quote.circuitInfo!.circuitType!;
      //addres circuit

      //Datos Form
      circuitAddressController.text = quote.circuitInfo!.location!;
      circuitDetailController.text = quote.circuitInfo!.bgpType!;
      dataCenterSelectedValue.text = quote.orderInfo!.dataCenterLocation!;
      portSizeSelectedValue.text = quote.circuitInfo!.portSize!;
      cirSelectedValue.text = quote.circuitInfo!.cir!;
      demarcationPointController.text = quote.orderInfo!.demarcationPoint!;
      handoffSelectedValue.text = quote.orderInfo!.handoff!;
      rackLocationController.text = quote.orderInfo!.rackLocation!;
    } catch (e) {
      log('Error en GetData() - $e');
    }
  }

  Future<void> getVendors() async {
    var response = await supabaseCRM.from('cat_vendors').select();

    List<Vendor> vendors = (response as List<dynamic>).map((vendor) => Vendor.fromJson(jsonEncode(vendor))).toList();

    vendorsList.clear();
    for (var vendor in vendors) {
      vendorsList.add(vendor.vendorName!);
    }
    notifyListeners();
  }

  void showErrorToast(String errorMessage) {
    Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      webPosition: 'center',
      webShowClose: true,
      fontSize: 16.0,
    );
  }
}
