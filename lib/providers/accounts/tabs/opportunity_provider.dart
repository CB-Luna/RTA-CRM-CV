import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart' hide State;
import 'package:pluto_grid/pluto_grid.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/accounts/opportunity_model.dart';
import 'package:rta_crm_cv/models/models.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class OpportunityProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  //checks box pop up
  bool timeline = false,
      decisionmaker = false,
      techspec = false,
      budget = false;

  bool editmode = false;
  late int? id;
  //
  State? selectedState;
  int pageRowCount = 10;
  int page = 1;
  DateTime create = DateTime.now();
  //Controladores Basic Information
  final nameController = TextEditingController();
  final accountController = TextEditingController();
  final contactController = TextEditingController();
  //Controladores Other Information
  final closedateController = TextEditingController();
  final quoteamountController = TextEditingController();
  final probabilityController = TextEditingController();
  //Controlador Description
  final descriptionController = TextEditingController();
////////////////////////////////////////////////////////////////////////////
  OpportunityProvider() {
    clearAll();
    updateState();
  }
  clearAll() {
    timeline = false;
    decisionmaker = false;
    techspec = false;
    budget = false;

    nameController.clear();
    accountController.clear();
    contactController.clear();
    closedateController.clear();
    quoteamountController.clear();
    probabilityController.clear();
    descriptionController.clear();

    selectSaleStoreValue = saleStoreList.first;
    selectAssignedTValue = assignedList.first;
    selectLeadSourceValue = leadSourceList.first;
  }

  Future<void> updateState() async {
    create;
    rows.clear();
    await clearAll();
    await getOpportunity();
  }

  Future<void> selectdate(
    BuildContext context,
  ) async {
    DateTime? newDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppTheme.of(context).primaryColor, // color Appbar
                onPrimary:
                    AppTheme.of(context).primaryBackground, // Color letras
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

  //listas Drop Menu
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

//Tabla Opportunities
  Future<void> getOpportunity() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      final res = await supabaseCRM.from('opportunities_view').select();
      if (res == null) {
        log('Error en getOpportunity()');
        return;
      }
      List<Opportunity> opportunity = (res as List<dynamic>)
          .map((usuario) => Opportunity.fromJson(jsonEncode(usuario)))
          .toList();

      rows.clear();
      for (Opportunity user in opportunity) {
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: user.id),
              'NAME_Column': PlutoCell(value: user.nameLead),
              'AMOUNT_Column': PlutoCell(value: user.quoteAmount),
              'PROBABILITY_Column': PlutoCell(value: user.probability),
              'CLOSED_Column': PlutoCell(value: user.expectedClose),
              'CREATE_Column': PlutoCell(value: user.createdAt),
              'LAST_Column': PlutoCell(value: user.lastActivity),
              'ASSIGNED_Column': PlutoCell(value: user.assignedTo),
              'STATUS_Column': PlutoCell(value: user.status),
              'ACTIONS_Column': PlutoCell(value: ''),
            },
          ),
        );
      }
      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getOpportunity() - $e');
    }

    notifyListeners();
  }

//CRUD Opportunity
  Future<void> createOpportunity() async {
    try {
      //Registrar al usuario con una contraseña temporal
      await supabaseCRM.from('opportunity').insert({
        "name": nameController.text,
        "quote_amount": quoteamountController.text,
        "probability": probabilityController.text,
        "last_activity": DateTime.now().toString(),
        "expected_close": create.toString(),
        "assigned_to": selectAssignedTValue,
        "status": "Opened",
        "account": accountController.text,
        "sales_stage": selectSaleStoreValue,
        "contact": contactController.text,
        "lead_source": selectLeadSourceValue,
        "time_line": timeline,
        "decision_maker": decisionmaker,
        "teach_spec": techspec,
        "budget": budget,
        "description": descriptionController.text,
      });
    } catch (e) {
      log('Error en registrarOpportunity() - $e');
    }
  }

  Future<void> getData() async {
    if (id != null) {
      var response =
          await supabaseCRM.from('opportunities_view').select().eq('id', id);

      if (response == null) {
        log('Error en getData()');
        return;
      }
      Opportunity opportunity = Opportunity.fromJson(jsonEncode(response[0]));
      nameController.text = opportunity.nameLead;
      accountController.text = opportunity.account;
      selectSaleStoreValue = opportunity.salesStage;
      accountController.text = opportunity.account;
      contactController.text = "${opportunity.firstName} ${opportunity.lastName}";
      selectAssignedTValue = opportunity.assignedTo;
      selectLeadSourceValue = opportunity.leadSource;
      closedateController.text = opportunity.expectedClose.toString();
      quoteamountController.text = opportunity.quoteAmount.toString();
      /* timeline = opportunity.timeLine;
      decisionmaker = opportunity.decisionMaker;
      techspec = opportunity.teachSpec;
      budget = opportunity.budget; */
      probabilityController.text = opportunity.probability.toString();
      descriptionController.text = opportunity.description;
    }

    notifyListeners();
  }

  Future<void> updateOpportunity() async {
    try {
      {
        await supabaseCRM.from('opportunity').update({
          "name": nameController.text,
          "quote_amount": quoteamountController.text,
          "probability": probabilityController.text,
          "last_activity": DateTime.now().toString(),
          "expected_close":
              DateTime.now().add(const Duration(days: 30)).toString(),
          "assigned_to": selectAssignedTValue,
          "status": "Opened",
          "account": accountController.text,
          "sales_stage": selectSaleStoreValue,
          "contact": contactController.text,
          "lead_source": selectLeadSourceValue,
          "time_line": timeline,
          "decision_maker": decisionmaker,
          "teach_spec": techspec,
          "budget": budget,
          "description": descriptionController.text,
        }).eq('id', id);
      }

      if (stateManager != null) stateManager!.notifyListeners();

      notifyListeners();
    } catch (e) {
      log('Error en UpdateOpportunity() - $e');
    }
    await getOpportunity();
    notifyListeners();
  }

  Future<void> deleteOpportunity() async {
    try {
      await supabaseCRM.from('opportunity').delete().eq('id', id);

      if (stateManager != null) stateManager!.notifyListeners();

      notifyListeners();
    } catch (e) {
      log('Error en deleteOpportunity() - $e');
    }
    await getOpportunity();
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
