import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart' hide State;
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/constants.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/accounts/leads_model.dart';
import 'package:rta_crm_cv/models/models.dart';
import 'package:http/http.dart' as http;

class LeadsProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;

  State? selectedState;
  int pageRowCount = 10;
  int page = 1;
  List<State> states = [];
  List<Role> roles = [];
  //Controladores Basic Information
  final nameController = TextEditingController();
  final lastnameController = TextEditingController();
  final accountController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  //Controladores Other Information
  final closedateController = TextEditingController();
  final quoteamountController = TextEditingController();
  final probabilityController = TextEditingController();
  //Controlador Description
  final descriptionController = TextEditingController();

  Role? selectedRole;

  String? imageName;
////////////////////////////////////////////////////////////////////////////
  LeadsProvider() {
    updateState();
  }

  Future<void> updateState() async {
    rows.clear();
    await getLeads();
  }

  List<bool> tabBar = [
    false,
    false,
    true,
    false,
    false,
  ];
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
              'NAME_Column': PlutoCell(value: lead.name),
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

//PopUp create Lead
  Future<Map<String, String>?> registerUser() async {
    try {
      //Registrar al usuario con una contraseña temporal
      var response = await http.post(
        Uri.parse('$supabaseUrl/auth/v1/si'),
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
      await supabase.from('user_p').insert(
        {
          'user_profile_id': userId,
          'name': nameController.text,
          'last_name': emailController.text,
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
