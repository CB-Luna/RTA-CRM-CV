// import 'dart:developer';

import 'dart:convert';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
//import 'package:rta_crm_cv/models/crm/accounts/quotes_model.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_%20cat_order_info_types.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_%20generic_cat.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_cat_circuit_types.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_cat_vendor_model.dart';
//import 'package:rta_crm_cv/models/crm/x2crm/model_x2_quotes_view.dart';
import 'package:rta_crm_cv/models/crm/x2crm/model_x2_quotes_view_v2.dart';
import 'package:rta_crm_cv/models/user.dart';
import 'package:rta_crm_cv/pages/crm/accounts/models/orders.dart';

import 'package:supabase_flutter/supabase_flutter.dart' hide User;

import 'package:http/http.dart' as http;

class ValidateQuoteProvider extends ChangeNotifier {
  ValidateQuoteProvider() {
    realTimeSuscription();
    clearAll();
  }

  int id = 0;
  late ModelX2V2QuotesView quote;
  List<User> users = [];

  clearAll() async {
    id = 0;
    revenue = 0;
    cost = 0;
    net = 0;
    tax = 0;
    pricePlusTax = 0;
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
  double revenue = 0;
  double cost = 0;
  double net = 0;
  double tax = 0;
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
  bool? powerMode;

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

  void selectPowerMode() {
    powerMode = !powerMode!;
    notifyListeners();
  }

//////////////////////////////////////////////////
  //operations a sen exec y fiananzas
  /* Future<bool> operationAcceptsQuoteSenExec() async {
    try {
      final res = await supabase.rpc('get_correo', params: {"role_id": 9});
      if (res == null) {
        log('Error en get_correo()');
      }
      for (var email in res) {
        //Json del correo;
        String body = jsonEncode(
          {
            "action": "rtaMail",
            "template": "SalesAcceptsQuoteSenExec",
            "subject": "Validate quote - RTA WHOLESALE",
            "mailto": email['email'], //Sen Exec nestalon1993@gmail.com
            "variables": [
              {"name": "quote.quote", "value": "${quote.quote}"},
              {"name": "quote.quoteid", "value": "${quote.quoteid}"},
              {"name": "quote.status", "value": "Sen. Exec. Validate"},
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
  }

  Future<bool> operationAcceptsQuoteFinance() async {
    try {
      final res = await supabase.rpc('get_correo', params: {"role_id": 8});
      if (res == null) {
        log('Error en getemail()');
      }
      for (var email in res) {
        //Json del correo;
        String body = jsonEncode(
          {
            "action": "rtaMail",
            "template": "SalesAcceptsQuoteFinance",
            "subject": "Validate quote - RTA WHOLESALE",
            "mailto": email['email'], //Finance kevin.14985@gmail.com
            "variables": [
              {"name": "quote.quote", "value": quote.quote},
              {"name": "quote.quoteid", "value": "${quote.quoteid}"},
              {"name": "quote.status", "value": "Finance Validate"},
              {"name": "quote.account", "value": quote.account},
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
        }
      }
      return true;
    } catch (e) {
      log('insertQuoteInfo() - Error: $e');
      notifyListeners();
      return false;
    }
  }

  /// finanzas y operations
  Future<bool> senExecAcceptsQuote() async {
    try {
      final res = await supabase.rpc('get_correo', params: {"role_id": 8});
      if (res == null) {
        log('Error en getemail()');
      }
      for (var email in res) {
        //Json del correo;
        String body = jsonEncode(
          {
            "action": "rtaMail",
            "template": "SenExecAcceptsQuote",
            "subject": "Validate quote - RTA WHOLESALE",
            "mailto": email['email'], //Finance
            "variables": [
              {"name": "quote.quote", "value": quote.quote},
              {"name": "quote.quoteid", "value": "${quote.quoteid}"},
              {"name": "quote.status", "value": "Finance Validate"},
              {"name": "quote.account", "value": quote.account},
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
        }
      }
      return true;
    } catch (e) {
      log('insertQuoteInfo() - Error: $e');
      notifyListeners();
      return false;
    }
  }

  Future<bool> financeAcceptsQuote() async {
    try {
      final res = await supabase.rpc('get_correo', params: {"role_id": 7});
      if (res == null) {
        log('Error en getemail()');
      }
      for (var email in res) {
        //Json del correo;
        String body = jsonEncode(
          {
            "action": "rtaMail",
            "template": "FinanceAcceptsQuote",
            "subject": "Validate quote - RTA WHOLESALE",
            "mailto": email['email'], //Operations erich.kaiser@rtatel.com  "kevin.ramos@cbluna.com"
            "variables": [
              {"name": "quote.quote", "value": quote.quote},
              {"name": "quote.quoteid", "value": "${quote.quoteid}"},
              {"name": "quote.status", "value": quote.status},
              {"name": "quote.account", "value": "Engineer Validate"},
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
        }
      }
      return true;
    } catch (e) {
      log('insertQuoteInfo() - Error: $e');
      notifyListeners();
      return false;
    }
  }

  ////////Aceepts QUotes
  Future<bool> senExecAcceptsQuoteSales() async {
    try {
      final res = await supabase.rpc('get_correo', params: {"role_id": 6});
      if (res == null) {
        log('Error en getemail()');
      }
      for (var email in res) {
        //URL Servidor apis

        //Json del correo;
        String body = jsonEncode(
          {
            "action": "rtaMail",
            "template": "SenExecAcceptsQuoteSales",
            "subject": "Quote accepted by Sen Exec - RTA WHOLESALE",
            "mailto": email['email'], //sales frank.befera@rtatel.com  "nestor.lopez@cbluna.com"
            "variables": [
              {"name": "quote.quote", "value": quote.quote},
              {"name": "quote.quoteid", "value": "${quote.quoteid}"},
              {"name": "quote.status", "value": "Approved"},
              {"name": "quote.account", "value": quote.account},
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
  }

  Future<bool> financeAcceptsQuoteSales() async {
    try {
      final res = await supabase.rpc('get_correo', params: {"role_id": 6});
      if (res == null) {
        log('Error en getemail()');
      }
      for (var email in res) {
        //Json del correo;
        String body = jsonEncode(
          {
            "action": "rtaMail",
            "template": "FinanceAcceptsQuoteSales",
            "subject": "Quote Accepted by Finance - RTA WHOLESALE ",
            "mailto": email['email'], //sales frank.befera@rtatel.com
            "variables": [
              {"name": "quote.quote", "value": quote.quote},
              {"name": "quote.quoteid", "value": "${quote.quoteid}"},
              {"name": "quote.status", "value": "Approved"},
              {"name": "quote.account", "value": quote.account},
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
        }
      }
      return true;
    } catch (e) {
      log('insertQuoteInfo() - Error: $e');
      notifyListeners();
      return false;
    }
  }

  Future<bool> opperationsAcceptQuoteSales() async {
    try {
      final res = await supabase.rpc('get_correo', params: {"role_id": 6});
      if (res == null) {
        log('Error en getemail()');
      }
      for (var email in res) {
        //Json del correo;
        String body = jsonEncode(
          {
            "action": "rtaMail",
            "template": "OpperationsAcceptQuoteSales",
            "subject": "Quote Accepted by Operations - RTA WHOLESALE",
            "mailto": email['email'], //sales frank.befera@rtatel.com
            "variables": [
              {"name": "quote.quote", "value": quote.quote},
              {"name": "quote.quoteid", "value": "${quote.quoteid}"},
              {"name": "quote.status", "value": "Approved"},
              {"name": "quote.account", "value": quote.account},
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

////////Reject QUotes
  /* Future<bool> senExecRejectsQuote() async {
    try {
      final res = await supabase.rpc('get_correo', params: {"role_id": 6});
      if (res == null) {
        log('Error en getemail()');
      }
      for (var email in res) {
        //Json del correo;
        String body = jsonEncode(
          {
            "action": "rtaMail",
            "template": "SenExecRejectsQuote",
            "subject": "Rejected QUOTE - RTA WHOLESALE",
            "mailto": email['email'], //sales frank.befera@rtatel.com
            "variables": [
              {"name": "quote.quote", "value": quote.quote},
              {"name": "quote.quoteid", "value": "${quote.quoteid}"},
              {"name": "quote.status", "value": "Rejected"},
              {"name": "quote.account", "value": quote.account},
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
        }
      }
      return true;
    } catch (e) {
      log('insertQuoteInfo() - Error: $e');
      notifyListeners();
      return false;
    }
  }

  Future<bool> financeRejectsQuote() async {
    try {
      final res = await supabase.rpc('get_correo', params: {"role_id": 6});
      if (res == null) {
        log('Error en getemail()');
      }
      for (var email in res) {
        //Json del correo;
        String body = jsonEncode(
          {
            "action": "rtaMail",
            "template": "FinanceRejectsQuote",
            "subject": "Rejected QUOTE - RTA WHOLESALE",
            "mailto": email['email'], //sales frank.befera@rtatel.com
            "variables": [
              {"name": "quote.quote", "value": quote.quote},
              {"name": "quote.quoteid", "value": "${quote.quoteid}"},
              {"name": "quote.status", "value": "Rejected"},
              {"name": "quote.account", "value": quote.account},
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
        }
      }
      return true;
    } catch (e) {
      log('insertQuoteInfo() - Error: $e');
      notifyListeners();
      return false;
    }
  }

  Future<bool> opperationsRejectsQuote() async {
    try {
      final res = await supabase.rpc('get_correo', params: {"role_id": 6});
      if (res == null) {
        log('Error en getemail()');
      }
      for (var email in res) {
        //Json del correo;
        String body = jsonEncode(
          {
            "action": "rtaMail",
            "template": "OpperationsRejectsQuote",
            "subject": "Operations Reject Quote - RTA WHOLESALE",
            "mailto": email['email'], //sales frank.befera@rtatel.com
            "variables": [
              {"name": "quote.quote", "value": quote.quote},
              {"name": "quote.quoteid", "value": "${quote.quoteid}"},
              {"name": "quote.status", "value": "Rejected"},
              {"name": "quote.account", "value": quote.account},
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
        }
      }

      return true;
    } catch (e) {
      log('insertQuoteInfo() - Error: $e');
      notifyListeners();
      return false;
    }
  } */

////////////////////////////////////////////////////
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

      callAirflow(validate);

      if (validate) {
        if (currentUser!.isOpperations) {
          /* if (margin >= 20) {
            await updateRegister(3, quote.quoteid!); //Finance Validate
            await operationAcceptsQuoteFinance(); //operations a finance
            await opperationsAcceptQuoteSales(); //operations a sales
          } else {
            await updateRegister(2, quote.quoteid!); //Sen. Exec. Validate
            await operationAcceptsQuoteSenExec(); //operations a senExec
            await opperationsAcceptQuoteSales(); //Operations a senExec
          } */

          await supabaseCRM.from('order_info').update({
            "handoff": handoffSelectedValue,
            "rack_location": null, //rackLocationController.text,
            //"demarcation_point": demarcationPointController.text,
            "existing_circuit_id": typesList[typesList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(typesSelectedValue))].parameters!.existingCircuitId!
                ? existingCircuitIDController.text
                : null,
            "new_circuit_id":
                typesList[typesList.map((type) => type.name!).toList().indexWhere((element) => element.startsWith(typesSelectedValue))].parameters!.newCircuitId! ? newCircuitIDController.text : null,
            "bandwidth": null, //bandwidthController.text,
            "power_mode": powerMode! ? "DC" : "AC",
          }).eq('id', quote.idOrders!);

          await supabaseCRM.from('leads_history').insert({
            "user": currentUser!.id,
            "action": 'UPDATE',
            "description": 'Order Updated by Engineering',
            "table": 'order_info',
            "id_table": quote.idOrders!,
            "name": "${currentUser!.name} ${currentUser!.lastName}"
          });
        } else if (currentUser!.isSenExec) {
          /* await updateRegister(7, quote.quoteid!); //Approved
          await senExecAcceptsQuote(); //senExec a finances
          await senExecAcceptsQuoteSales(); //senExec a sales */

          await supabaseCRM.from('leads_history').insert({
            "user": currentUser!.id,
            "action": 'UPDATE',
            "description": 'Quote validated by Sen. Exec.',
            "table": 'x2_quotes',
            "id_table": quote.quoteid,
            "name": "${currentUser!.name} ${currentUser!.lastName}"
          });
        } else if (currentUser!.isFinance) {
          /* await updateRegister(7, quote.quoteid!); //Approved
          await financeAcceptsQuoteSales(); //finances a sales */

          await supabaseCRM.from('leads_history').insert({
            "user": currentUser!.id,
            "action": 'UPDATE',
            "description": 'Quote validated by Finance',
            "table": 'x2_quotes',
            "id_table": quote.quoteid,
            "name": "${currentUser!.name} ${currentUser!.lastName}",
          });
        }
        returning = true;
      } else {
        //Rejected
        /* await updateRegister(5, quote.quoteid!);
        if (currentUser!.isSenExec) {
          await senExecRejectsQuote();
        } else if (currentUser!.isFinance) {
          await financeRejectsQuote();
        } else {
          await opperationsRejectsQuote();
        } */

        /* await supabaseCRM.from('order_info').update({
          "handoff": handoffSelectedValue,
          "rack_location": rackLocationController.text,
          //"demarcation_point": demarcationPointController.text,
          "existing_circuit_id": existingCircuitIDController.text,
          "new_circuit_id": newCircuitIDController.text,
        }).eq('id', quote.idOrders!); */

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

  Future<void> callAirflow(bool validated) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $airflowPW',
    };
    var request = http.Request('POST', Uri.parse('$airflowURL/quote_validate_v1/dagRuns'));
    request.body = json.encode({
      "conf": {
        "x2_quote_id": quote.quoteid,
        "x2_quote_name": quote.quote,
        "x2_quote_account": quote.account,
        if (currentUser!.isOpperations) "margin": margin,
        "id_status": quote.idStatus,
        "currentUserId": currentUser!.id,
        "currentUserFullName": currentUser!.fullName,
        "validated": validated,
      },
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      log(await response.stream.bytesToString());
    } else {
      log(response.reasonPhrase!);
    }
  }

  /* Future<void> updateRegister(int idStatus, int quoteId) async {
    await supabaseCRM.rpc(
      'update_quote_status',
      params: {"id_status": idStatus, "id": quoteId, "user_uuid": currentUser!.id}, //Network Cross Connected
    );
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
      /* if (parameter.parameters.newCircuitId) {
        newCircuitIDController.text = quote.orderInfo!.newCircuitId ?? '';
      }
      if (parameter.parameters.existingCircuitId) {
        existingCircuitIDController.text = quote.orderInfo!.existingCircuitId ?? '';
      } */

      addressController.text = quote.orderInfo!.address!;

      demarcationPointController.text = quote.orderInfo!.demarcationPoint ?? '';

      if (quote.orderInfo!.dataCenterType == 'New') {
        dataCenterSelectedValue = 'New';
        newDataCenterController.text = quote.orderInfo!.dataCenterLocation!;
      } else {
        dataCenterSelectedValue = quote.orderInfo!.dataCenterLocation!;
      }

      //rackLocationController.text = quote.orderInfo!.rackLocation ?? '';

      handoffSelectedValue = quote.orderInfo!.handoff ?? '';

      if (currentUser!.isOpperations) {
        powerMode = false;
      } else {
        powerMode = quote.orderInfo!.powerMode;
      }

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
