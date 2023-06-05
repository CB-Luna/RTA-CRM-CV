import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart' hide State;
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/constants.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/accounts/opportunity_model.dart';
import 'package:rta_crm_cv/models/models.dart';

import 'package:http/http.dart' as http;

class OpportunityProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  //checks box pop up
  bool timeline = false,
      decisionmaker = false,
      techspec = false,
      budget = false;
  //
  State? selectedState;
  int pageRowCount = 10;
  int page = 1;
  List<State> states = [];
  List<Role> roles = [];
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

  Role? selectedRole;
  String? imageName;
////////////////////////////////////////////////////////////////////////////
  OpportunityProvider() {
    updateState();
  }

  Future<void> updateState() async {
    rows.clear();
    await getOpportunity();
  }

//listas Drop Menu
  void selectStage(String stage) {
    selectedRole = roles.firstWhere((elem) => elem.roleName == stage);
    notifyListeners();
  }

  void selectAssigned(String assigned) {
    selectedRole = roles.firstWhere((elem) => elem.roleName == assigned);
    notifyListeners();
  }

  void selectLead(String lead) {
    selectedRole = roles.firstWhere((elem) => elem.roleName == lead);
    notifyListeners();
  }

//Tabla Opportunities
  Future<void> getOpportunity() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      final res = await supabaseCRM.from('opportunity').select();
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
              'NAME_Column': PlutoCell(value: user.name),
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

//PopUp create Opportunity
  Future<Map<String, String>?> registerUser() async {
    try {
      //Registrar al usuario con una contraseña temporal
      var response = await http.post(
        Uri.parse('$supabaseUrl/auth/v1/s'),
        headers: {'Content-Type': 'application/json', 'apikey': anonKey},
        body: json.encode(
          {
            "email": nameController.text,
            "password": 'default',
          },
        ),
      );
      if (response.statusCode > 204)
        return {'Error': 'The user already exists'};

      final String? userId = jsonDecode(response.body)['user']['id'];

      //retornar el id del usuario
      if (userId != null) return {'userId': userId};

      return {'Error': 'Error registering user'};
    } catch (e) {
      log('Error en registrarUsuario() - $e');
      return {'Error': 'Error registering user'};
    }
  }

  Future<bool> createUserProfile(String userId) async {
    if (selectedState == null || selectedRole == null) return false;
    try {
      await supabase.from('user_pr').insert(
        {
          'user_profile_id': userId,
          'name': nameController.text,
          'last_name': contactController.text,
          'home_phone': closedateController.text,
          'address': '123 Main St.',
          'image': imageName,
          'birthdate': DateTime.now().toIso8601String(),
          'id_role_fk': selectedRole!.id,
          'state_fk': selectedState!.id,
        },
      );
      return true;
    } catch (e) {
      log('Error in createUserProfile() - $e');
      return false;
    }
  }

  Future<void> getStates({bool notify = true}) async {
    final res = await supabase.from('state').select().order(
          'name',
          ascending: true,
        );

    states = (res as List<dynamic>)
        .map((pais) => State.fromJson(jsonEncode(pais)))
        .toList();

    if (notify) notifyListeners();
  }

  Future<void> getRoles({bool notify = true}) async {
    final res = await supabase.from('role').select().order(
          'name',
          ascending: true,
        );

    roles = (res as List<dynamic>)
        .map((rol) => Role.fromJson(jsonEncode(rol)))
        .toList();

    if (notify) notifyListeners();
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
