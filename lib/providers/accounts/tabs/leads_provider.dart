import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart' hide State;
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/accounts/leads_model.dart';
import 'package:rta_crm_cv/models/models.dart';

class LeadsProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  bool editmode = false;

  State? selectedState;
  int pageRowCount = 10;
  int page = 1;
  List<State> states = [];
  List<Role> roles = [];
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
      ],
      assignedList = [
        'Frank Befera',
        'Rosalia Silvey',
        'Tom Carrol',
        'Mike Haddock',
      ],
      leadSourceList = [
        'lead1',
        'lead2',
        'lead3',
      ];
//
  late int? id;
////////////////////////////////////////////////////////////////////////////
  LeadsProvider() {
    clearAll();
    updateState();
  }

  clearAll() {
    firstNameController.clear();
    lastNameController.clear();
    accountController.clear();
    closedateController.clear();
    quoteamountController.clear();
    probabilityController.clear();
    descriptionController.clear();

    selectSaleStoreValue = saleStoreList.first;
    selectAssignedTValue = assignedList.first;
    selectLeadSourceValue = leadSourceList.first;
  }

  Future<void> updateState() async {
    rows.clear();
    await getLeads();
  }

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

  List<bool> tabBar = [
    false,
    false,
    true,
    false,
    false,
  ];
  //listas Drop Menu

//Tabla Opportunities
  Future<void> getLeads() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      final res = await supabaseCRM.from('leads').select();
      if (res == null) {
        log('Error en getLeads()');
        return;
      }
      List<Leads> leads = (res as List<dynamic>)
          .map((lead) => Leads.fromJson(jsonEncode(lead)))
          .toList();

      rows.clear();
      for (Leads lead in leads) {
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: lead.id),
              'NAME_Column': PlutoCell(value: lead.nameLead),
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

//PopUps Leads
  Future<void> createLead() async {
    try {
      //Registrar al usuario con una contraseña temporal
      await supabaseCRM.from('leads').insert({
        "name_lead": "${firstNameController.text} ${lastNameController.text}",
        "quote_amount": quoteamountController.text,
        "probability": probabilityController.text,
        "expected_close":
            DateTime.now().add(const Duration(days: 30)).toString(),
        "assigned_to": selectAssignedTValue,
        "status": "In proccess",
        "organitation_name":
            "${firstNameController.text} ${lastNameController.text}",
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "phone_number": phoneController.text,
        "email": emailController.text,
        "sales_stage": selectSaleStoreValue,
        "account": accountController.text,
        "lead_source": selectLeadSourceValue,
        "description": descriptionController.text,
      });
    } catch (e) {
      log('Error en registrarOpportunity() - $e');
    }
  }

  Future<void> getData() async {
    if (id != null) {
      var response = await supabaseCRM.from('leads').select().eq('id', id);

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
      probabilityController.text = leads.probability.toString();
      selectAssignedTValue = leads.assignedTo;
      descriptionController.text = leads.description;
    }

    notifyListeners();
  }

  Future<void> updateLead() async {
    try {
      {
        await supabaseCRM.from('leads').update({
          "name_lead": "${firstNameController.text} ${lastNameController.text}",
          "quote_amount": quoteamountController.text,
          "probability": probabilityController.text,
          "expected_close":
              DateTime.now().add(const Duration(days: 30)).toString(),
          "assigned_to": selectAssignedTValue,
          "status": "In proccess",
          "organitation_name":
              "${firstNameController.text} ${lastNameController.text}",
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "phone_number": phoneController.text,
          "email": emailController.text,
          "sales_stage": selectSaleStoreValue,
          "account": accountController.text,
          "lead_source": selectLeadSourceValue,
          "description": descriptionController.text,
        }).eq('id', id);
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

//Leads details

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
