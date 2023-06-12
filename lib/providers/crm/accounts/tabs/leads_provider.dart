import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart' hide State;
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/accounts/leads_model.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class LeadsProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  bool editmode = false;
  int pageRowCount = 10;
  int page = 1;
  late int? id;
  DateTime create = DateTime.now();
  double slydervalue = 0, min = 0, max = 100;
  late DateTime close = DateTime.parse(closedateController.text);
  //Controladores Basic Information
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final accountController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  //Controladores Other Information
  final closedateController = TextEditingController();
  final quoteamountController = TextEditingController();
  final probabilityController = TextEditingController();
  //Controlador Description
  final descriptionController = TextEditingController();

//Listas DropdownMenu
  late String selectSaleStoreValue, selectAssignedTValue, selectLeadSourceValue;
  List<String> saleStoreList = [
    'Mike Haddock',
    'Rosalia Silvey',
    'Tom Carrol',
    'Vini Garcia',
  ];
  List<String> assignedList = [
    'Frank Befera',
    'Rosalia Silvey',
    'Tom Carrol',
    'Mike Haddock',
  ];
  List<String> leadSourceList = [
    'Social Media',
    'Campain',
    'TV',
    'Email',
    'Web',
  ];
  void selectSaleStore(String selected) {
    selectSaleStoreValue = selected;
    notifyListeners();
  }

  void selectAssigned(String selected) {
    selectAssignedTValue = selected;
    notifyListeners();
  }

  void selectLeadSource(String selected) {
    selectLeadSourceValue = selected;
    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////////
  LeadsProvider() {
    clearAll();
    updateState();
  }

  clearAll() {
    editmode = false;
    create = DateTime.now();
    slydervalue = 0;
    firstNameController.clear();
    lastNameController.clear();
    accountController.clear();
    closedateController.clear();
    quoteamountController.clear();
    probabilityController.clear();
    descriptionController.clear();
    emailController.clear();
    phoneController.clear();

    selectSaleStoreValue = saleStoreList.first;
    selectAssignedTValue = assignedList.first;
    selectLeadSourceValue = leadSourceList.first;
  }

  Future<void> updateState() async {
    rows.clear();
    await clearAll();
    await getLeads();
  }

  List<bool> tabBar = [
    false,
    false,
    true,
    false,
    false,
  ];
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

//Tabla Leads
  Future<void> getLeads() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      final res = await supabaseCRM.from('leads_view').select();
      if (res == null) {
        log('Error en getLeads()');
        return;
      }
      List<Leads> leads = (res as List<dynamic>).map((lead) => Leads.fromJson(jsonEncode(lead))).toList();

      rows.clear();
      for (Leads lead in leads) {
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: lead.id),
              'NAME_Column': PlutoCell(value: lead.account),
              'AMOUNT_Column': PlutoCell(value: lead.quoteAmount),
              'PROBABILITY_Column': PlutoCell(value: lead.probability),
              'CLOSED_Column': PlutoCell(value: lead.expectedClose),
              'CREATE_Column': PlutoCell(value: lead.createdAt),
              'LAST_Column': PlutoCell(value: lead.lastActivity),
              'ASSIGNED_Column': PlutoCell(value: lead.assignedTo),
              'STATUS_Column': PlutoCell(value: lead.status),
              'ACTIONS_Column': PlutoCell(value: ''),
            },
          ),
        );
      }
      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getLeads() - $e');
    }

    notifyListeners();
  }

//CRUD Leads
  Future<void> createLead() async {
    try {
      //Registrar al usuario con una contraseña temporal
      var resp = (await supabaseCRM.from('leads').insert({
        "name_lead": "${firstNameController.text} ${lastNameController.text}",
        "quote_amount": quoteamountController.text,
        "probability": slydervalue.toString(),
        "expected_close": create.toString(),
        "assigned_to": selectAssignedTValue,
        "status": "In process",
        "organitation_name": "${firstNameController.text} ${lastNameController.text}",
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "phone_number": phoneController.text,
        "email": emailController.text,
        "sales_stage": selectSaleStoreValue,
        "account": accountController.text,
        "lead_source": selectLeadSourceValue,
        "description": descriptionController.text,
      }).select())[0];

      await supabaseCRM.from('leads_history').insert({
        "user": currentUser!.id,
        "action": 'INSERT',
        "description": 'New Lead created',
        "table": 'leads',
        "id_table": resp["id"].toString(),
      });
    } catch (e) {
      log('Error en registrarOpportunity() - $e');
    }
  }

  Future<void> getData() async {
    if (id != null) {
      var response = await supabaseCRM.from('leads_view').select().eq('id', id);

      if (response == null) {
        log('Error en getData()');
        return;
      }
      Leads leads = Leads.fromJson(jsonEncode(response[0]));
      firstNameController.text = leads.firstName;
      lastNameController.text = leads.lastName;
      selectSaleStoreValue = leads.salesStage;
      accountController.text = leads.account;
      emailController.text = leads.email;
      selectLeadSourceValue = leads.leadSource;
      phoneController.text = leads.phoneNumber;
      closedateController.text = leads.expectedClose.toString();
      quoteamountController.text = leads.quoteAmount.toString();
      slydervalue = leads.probability.toDouble();
      selectAssignedTValue = leads.assignedTo;
      descriptionController.text = leads.description;
    }

    notifyListeners();
  }

  Future<void> updateLead() async {
    try {
      {
        var resp = (await supabaseCRM
            .from('leads')
            .update({
              "name_lead": "${firstNameController.text} ${lastNameController.text}",
              "quote_amount": quoteamountController.text,
              "probability": slydervalue.toString(),
              "expected_close": create.toString(),
              "assigned_to": selectAssignedTValue,
              "status": "In process",
              "organitation_name": "${firstNameController.text} ${lastNameController.text}",
              "first_name": firstNameController.text,
              "last_name": lastNameController.text,
              "phone_number": phoneController.text,
              "email": emailController.text,
              "sales_stage": selectSaleStoreValue,
              "account": accountController.text,
              "lead_source": selectLeadSourceValue,
              "description": descriptionController.text,
            })
            .eq('id', id)
            .select())[0];

        await supabaseCRM.from('leads_history').insert({
          "user": currentUser!.id,
          "action": 'UPDATE',
          "description": 'Lead updated',
          "table": 'leads',
          "id_table": resp["id"].toString(),
        });
      }

      if (stateManager != null) stateManager!.notifyListeners();

      notifyListeners();
    } catch (e) {
      log('Error en UpdateOpportunity() - $e');
    }
    await getLeads();
    notifyListeners();
  }

  Future<void> deleteLead() async {
    try {
      await supabaseCRM.from('leads').delete().eq('id', id);

      if (stateManager != null) stateManager!.notifyListeners();

      notifyListeners();
    } catch (e) {
      log('Error en deleteOpportunity() - $e');
    }
    await getLeads();
    notifyListeners();
  }

  Future setIndex(int index) async {
    for (var i = 0; i < tabBar.length; i++) {
      tabBar[i] = false;
    }
    tabBar[index] = true;

    notifyListeners();
  }

//Controladores Paginado Pluto?
  void clearControllers({bool notify = true}) {
    searchController.clear();

    if (notify) notifyListeners();
  }

  void setPageSize(String x) {
    switch (x) {
      case 'more':
        if (pageRowCount < rows.length) pageRowCount++;
        break;
      case 'less':
        if (pageRowCount > 1) pageRowCount--;
        break;
      default:
        return;
    }
    stateManager!.createFooter;
    notifyListeners();
  }

  void setPage(String x) {
    switch (x) {
      case 'next':
        if (page < stateManager!.totalPage) page++;
        break;
      case 'previous':
        if (page > 1) page--;
        break;
      case 'start':
        page = 1;
        break;
      case 'end':
        page = stateManager!.totalPage;
        break;
      default:
        return;
    }
    stateManager!.setPage(page);
    notifyListeners();
  }

  void load() {
    stateManager!.setShowLoading(true);
  }
}
