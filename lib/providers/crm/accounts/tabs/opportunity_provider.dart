import 'dart:convert';
import 'dart:developer';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart' hide State;
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/functions/date_format.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/crm/accounts/opportunity_model.dart';
import 'package:rta_crm_cv/models/crm/accounts/quotes_model.dart';
import 'package:rta_crm_cv/models/models.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class OpportunityProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  //checks box pop up
  bool timeline = false, decisionmaker = false, techspec = false, budget = false;

  bool editmode = false;
  late int? id;
  //
  State? selectedState;
  int pageRowCount = 10;
  int page = 1;
  DateTime create = DateTime.now();
  late DateTime close = DateTime.parse(closedateController.text);
  double slydervalue = 10, min = 0, max = 100;
  //Controladores Basic Information
  final nameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final accountController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
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
    slydervalue = 0;
    timeline = false;
    decisionmaker = false;
    techspec = false;
    budget = false;
    nameController.clear();

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

  //listas Drop Menu
  late String selectSaleStoreValue, selectAssignedTValue, selectLeadSourceValue, selectContactValue;
  List<String> saleStoreList = [
    '',
    'Mike Haddock',
    'Rosalia Silvey',
    'Tom Carrol',
    'Vini Garcia',
  ];
  List<String> assignedList = [
    '',
    'Frank Befera',
    'Rosalia Silvey',
    'Tom Carrol',
    'Mike Haddock',
  ];
  List<String> leadSourceList = [
    '',
    'Social Media',
    'Campain',
    'TV',
    'Email',
    'Web',
  ];
  List<String> contactList = [
    '',
    'Steve Shanks',
    'Tyler Weinrich',
    'Chris Byrd',
    'Michael Pulk',
    'Wade Moore',
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

  void selectContact(String selected) {
    selectContactValue = selected;
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
      List<Opportunity> opportunity = (res as List<dynamic>).map((usuario) => Opportunity.fromJson(jsonEncode(usuario))).toList();

      rows.clear();
      for (Opportunity user in opportunity) {
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: user.id),
              'ACCOUNT_Column': PlutoCell(value: user.account),
              'NAME_Column': PlutoCell(value: user.organitationName),
              'AMOUNT_Column': PlutoCell(value: user.quotes.first.total),
              'PROBABILITY_Column': PlutoCell(value: user.probability),
              'CLOSED_Column': PlutoCell(value: user.expectedClose),
              'CREATE_Column': PlutoCell(value: user.quotes.last.createdAt),
              'LAST_Column': PlutoCell(value: user.quotes.first.updatedAt),
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
      var resp = (await supabaseCRM.from('lead').insert({
        "name_lead": nameController.text,
        "quote_amount": quoteamountController.text,
        "probability": slydervalue.toString(),
        "expected_close": create.toString(),
        "assigned_to": selectAssignedTValue,
        "status": "In process",
        "organitation_name": accountController.text, //company en quotes account en leads
        "sales_stage": selectSaleStoreValue,
        "account": accountController.text,
        "lead_source": selectLeadSourceValue,
        "time_line": timeline,
        "decision_maker": decisionmaker,
        "teach_spec": techspec,
        "budget": budget,
        "contact": selectContactValue,
        "description": descriptionController.text,
      }).select())[0];

      await supabaseCRM.from('leads_history').insert({
        "user": currentUser!.id,
        "action": 'INSERT',
        "description": 'New opportunity created',
        "table": 'opportunity',
        "id_table": resp["id"].toString(),
        "name": "${currentUser!.name} ${currentUser!.lastName}"
      });
    } catch (e) {
      log('Error en registrarOpportunity() - $e');
    }
  }

  Future<void> getData() async {
    if (id != null) {
      var response = await supabaseCRM.from('opportunities_view').select().eq('id', id);

      if (response == null) {
        log('Error en getData()');
        return;
      }
      Opportunity opportunity = Opportunity.fromJson(jsonEncode(response[0]));
      nameController.text = opportunity.nameLead;
      accountController.text = opportunity.account;
      selectSaleStoreValue = opportunity.salesStage;
      selectContactValue = opportunity.contact;
      accountController.text = opportunity.account;
      selectAssignedTValue = opportunity.assignedTo;
      selectLeadSourceValue = opportunity.leadSource;
      closedateController.text = opportunity.expectedClose.toString();
      quoteamountController.text = opportunity.quoteAmount.toString();
      timeline = opportunity.timeLine;
      decisionmaker = opportunity.decisionMaker;
      techspec = opportunity.teachSpec;
      budget = opportunity.budget;
      slydervalue = opportunity.probability.toDouble();
      descriptionController.text = opportunity.description;
    }

    notifyListeners();
  }

  Future<void> updateOpportunity() async {
    try {
      {
        var resp = (await supabaseCRM
            .from('leads')
            .update({
              "name_lead": nameController.text,
              "quote_amount": quoteamountController.text,
              "probability": slydervalue.toString(),
              "expected_close": create.toString(),
              "assigned_to": selectAssignedTValue,
              "organitation_name": accountController.text,
              "sales_stage": selectSaleStoreValue,
              "account": accountController.text,
              "lead_source": selectLeadSourceValue,
              "contact": selectContactValue,
              "time_line": timeline,
              "decision_maker": decisionmaker,
              "teach_spec": techspec,
              "budget": budget,
              "description": descriptionController.text,
            })
            .eq('id', id)
            .select())[0];

        await supabaseCRM.from('leads_history').insert({
          "user": currentUser!.id,
          "action": 'UPDATE',
          "description": 'Opportunity updated',
          "table": 'opportunity',
          "id_table": resp["id"].toString(),
          "name": "${currentUser!.name} ${currentUser!.lastName}"
        });
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

  ////////////////////////////////////////////////////////
  /////////////////////////Export/////////////////////////
  ////////////////////////////////////////////////////////

  Future<void> exportData() async {
    var res = await supabaseCRM.from('quotes_view').select().neq('status', 'Closed');

    List<Quotes> quotes = (res as List<dynamic>).map((quote) => Quotes.fromJson(jsonEncode(quote))).toList();

    Excel excel = Excel.createExcel();
    Sheet? sheet = excel.sheets[excel.getDefaultSheet()];

    if (sheet == null) return;

    sheet.removeRow(0);

    CellStyle cellStyle = CellStyle(bold: true);

    //Agregar primera linea
    sheet.appendRow([
      'Title',
      'Opportunities Report',
      '',
      'User',
      '${currentUser?.name} ${currentUser?.lastName}',
      '',
      'Date',
      dateFormat(DateTime.now(), true),
    ]);

    for (var i = 0; i < 8; i++) {
      sheet.row(0)[i]!.cellStyle = cellStyle;
    }

    //Agregar linea vacia
    sheet.appendRow(['']);

    //Agregar headers
    sheet.appendRow([
      'DataCenter',
      'Vendor',
      'Type',
      'Description',
      'Cost',
      'Taxes',
      'Account Number',
      'Contract Number',
      'Contract Signed',
      'Term',
      'Out of Term',
      'Contact',
      'Phone',
      'Email',
      //'Notes',
    ]);

    for (var i = 0; i < 14; i++) {
      sheet.row(2)[i]!.cellStyle = cellStyle;
    }

    sheet.selectRange(
      CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0),
      end: CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0),
    );

    double cost = 0;
    double tax = 0;

    for (var quote in quotes) {
      cost = cost + quote.cost;
      tax = tax + quote.taxMoney;
      final List<dynamic> excelRow = [
        quote.orderInfo.dataCenterLocation,
        quote.vendorName,
        quote.orderInfo.circuitType,
        quote.items.first.lineItem,
        quote.cost,
        quote.totalPlusTax - quote.total,
        quote.account,
        'Contract',
        'Signed',
        'Term',
        'Out',
        quote.contact,
        quote.phoneNumber,
        quote.email,
      ];
      sheet.appendRow(excelRow);
    }

    //Agregar linea vacia
    sheet.appendRow(['']);

    sheet.appendRow([
      'Total gigFAST Network',
      '',
      '',
      '',
      cost,
      tax,
      cost + tax,
    ]);

    for (var i = 0; i < 7; i++) {
      sheet.row(sheet.rows.length - 1)[i]!.cellStyle = cellStyle;
    }

    //Descargar
    excel.save(fileName: "Opportunities_Report_${DateFormat('MMMM_dd_yyyy').format(DateTime.now())}.xlsx");
  }
}
