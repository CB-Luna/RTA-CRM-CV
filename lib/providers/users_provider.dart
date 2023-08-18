// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart' hide State;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rive/rive.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:uuid/uuid.dart';

import '../models/vehicle.dart';

class UsersProvider extends ChangeNotifier {
  bool isOpen = true;
  bool forcedOpen = true;
  List<User> users = [];
  List<Vehicle> vehicles = [];
  List<Vehicle> vehiclexUser = [];
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  int pageRowCount = 10;
  int page = 1;

  Future<void> updateState() async {
    rows.clear();
    await getUsers();
  }

  List<Role> roles = [];
  List<Company> companys = [];
  List<String> statusy = [];
  Role? selectedRole;
  Role? selectedRoleUpdate;
  Company? selectedCompany;
  Company? selectedCompanyUpdate;
  List<State> states = [];
  String? dropdownvalue = "Active";
  State? selectedState;
  State? selectedStateUpdate;
  Vehicle? selectedVehicle;
  Vehicle? selectedVehicleUpdate;
  String? imageName;
  Uint8List? webImage;
  Vehicle? actualVehicle;

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final stateController = TextEditingController();
  final roleController = TextEditingController();
  final companyCOntroller = TextEditingController();
  final statusController = TextEditingController();
  final licenseController = TextEditingController();
  final certificationController = TextEditingController();

  // EDIT
  final nameControllerUpdate = TextEditingController();
  final lastNameControllerUpdate = TextEditingController();
  final emailControllerUpdate = TextEditingController();
  final phoneControllerUpdate = TextEditingController();
  final stateControllerUpdate = TextEditingController();
  final roleControllerUpdate = TextEditingController();
  final companyCOntrollerUpdate = TextEditingController();
  final statusControllerUpdate = TextEditingController();
  final licenseControllerUpdate = TextEditingController();
  final certificationControllerUpdate = TextEditingController();

  void updateControllers(User users) {
    nameControllerUpdate.text = users.name;
    lastNameControllerUpdate.text = users.lastName;
    emailControllerUpdate.text = users.email;
    phoneControllerUpdate.text = users.homePhone ?? "-";
    selectedStateUpdate = selectedState;
    selectedRoleUpdate = selectedRole;
    selectedCompanyUpdate = selectedCompany;
    selectedVehicleUpdate = null;
    statusControllerUpdate.text = users.status ?? "-";
    licenseControllerUpdate.text = users.license ?? "-";
    certificationControllerUpdate.text = users.certification ?? "-";
  }

  void clearControllers({bool notify = true}) {
    nameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    stateController.clear();
    roleController.clear();
    selectedCompany = null;
    selectedState = null;
    selectedRole = null;
    selectedVehicle = null;
    companyCOntroller.clear();
    statusController.clear();
    licenseController.clear();
    certificationController.clear();

    if (notify) notifyListeners();
  }

  // NORMAL
  void selectRole(String role) {
    selectedRole = roles.firstWhere((elem) => elem.roleName == role);
    notifyListeners();
  }

  void selectCompany(String companyName) {
    selectedCompany =
        companys.firstWhere((elem) => elem.company == companyName);
    notifyListeners();
  }

  void selectedVehiclee(String vehicle) {
    selectedVehicle =
        vehicles.firstWhere((element) => element.licesensePlates == vehicle);
    notifyListeners();
  }

  void selectState(String state) {
    selectedState = states.firstWhere((elem) => elem.name == state);
    notifyListeners();
  }

  // UPDATE
  void selectRoleUpdate(String role) {
    selectedRoleUpdate = roles.firstWhere((elem) => elem.roleName == role);
    notifyListeners();
  }

  void selectCompanyUpdate(String companyName) {
    selectedCompanyUpdate =
        companys.firstWhere((elem) => elem.company == companyName);
    notifyListeners();
  }

  void selectVehicleUpdates(String vehicle) {
    selectedVehicleUpdate =
        vehicles.firstWhere((element) => element.licesensePlates == vehicle);
    //print("-----------");
    //print("selectedVehicleUpdate: ${selectedVehicleUpdate?.licesensePlates}");
    notifyListeners();
  }

  void selectStateUpdate(String state) {
    selectedStateUpdate = states.firstWhere((elem) => elem.name == state);
    notifyListeners();
  }

  void getActualVehicle(User users) async {
    try {
      final res = await supabaseCtrlV
          .from('vehicle')
          .select()
          .eq('id_vehicle', users.idVehicle);

      vehicles = (res as List<dynamic>)
          .map((vehicles) => Vehicle.fromJson(jsonEncode(vehicles)))
          .toList();

      //print("entro a getActualVehicle: $res");
    } catch (e) {
      //print("Error in getActualVehicle() $e");
    }
  }

  void selectVehicleActual(User users, {bool notify = true}) {
    actualVehicle =
        vehicles.firstWhere((element) => element.idVehicle == users.idVehicle);
    //print('ActualVehicle: ${actualVehicle?.licesensePlates}');
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

  void updateVehiclestatus() async {
    try {
      final res = await supabaseCtrlV.from('vehicle').update(
          {'id_status_fk': 1}).eq('id_vehicle', selectedVehicle?.idVehicle);
      //print("entro a updateVehicle: $res");
    } catch (e) {
      //print("Error in updateVehiclestatus $e");
    }
  }

  void updateVehiclestatusUpdate(User users) async {
    try {
      //print("Id del SelectedVehicleUpdate: ${selectedVehicleUpdate?.idVehicle}");
      // Aqui cambiamos el status del vehiculo que seleccionamos a Assignado
      final res = await supabaseCtrlV
          .from('vehicle')
          .update({'id_status_fk': 1}).eq(
              'id_vehicle', selectedVehicleUpdate?.idVehicle);

      // Aqui cambiamos el vehiculo viejo a disponible
      final res2 = await supabaseCtrlV
          .from('vehicle')
          .update({'id_status_fk': 3}).eq('id_vehicle', users.idVehicle);

      // Aqui cambiamos el id del vehiculo donde el id_sequential sea el mismo que el del usuario
      // final cambioVehiculo = await supabase
      //     .from('user_profile')
      //     .update({'id_vehicle_fk': selectedVehicleUpdate!.idVehicle}).eq(
      //         'sequential_id', users.sequentialId);

      //print("entro a updateVehiclestatusUpdate: $res");
      //print("Entro en el cambio del vehiculo viejo $res2");
    } catch (e) {
      //print("Error in updateVehiclestatusUpdate $e");
    }
    notifyListeners();
  }

  Future<void> getStates({bool notify = true}) async {
    try {
      final res = await supabase.from('state').select().order(
            'name',
            ascending: true,
          );

      states = (res as List<dynamic>)
          .map((pais) => State.fromJson(jsonEncode(pais)))
          .toList();

      if (notify) notifyListeners();
    } catch (e) {
      log('Error en getStates() -$e');
    }
  }

  Future<void> getCompany({bool notify = true}) async {
    try {
      final res = await supabase.from('company').select().order(
            'company',
            ascending: true,
          );

      companys = (res as List<dynamic>)
          .map((compani) => Company.fromJson(jsonEncode(compani)))
          .toList();

      if (notify) notifyListeners();
    } catch (e) {
      log('Error en getCompany() -$e');
    }
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

  // -----------------------------------------------
  Future<void> getVehicleUser(User users, {bool notify = true}) async {
    try {
      final resC = await supabaseCtrlV
          .from('inventory_view')
          .select()
          .eq('id_vehicle', users.idVehicle);

      vehiclexUser = (resC as List<dynamic>)
          .map((vehiclexUser) => Vehicle.fromJson(jsonEncode(vehiclexUser)))
          .toList();
      //print("Entro a getVehicleUser");
    } catch (e) {
      //print("getVehicleUser $e");
    }
    if (notify) notifyListeners();
  }

  // -----------------------------------------------
  Future<void> getVehicleActiveInit(User users, {bool notify = true}) async {
    try {
      final resC = await supabase
          .from('company')
          .select()
          .eq('company', users.company.company);

      final company = (resC as List<dynamic>);

      final res = await supabaseCtrlV
          .from('inventory_view')
          .select()
          .eq('status ->id_status', 3)
          .eq('company ->id_company', company.first["id_company"]);

      vehicles = (res as List<dynamic>)
          .map((vehicles) => Vehicle.fromJson(jsonEncode(vehicles)))
          .toList();
      //print("Entro a getVehicles");
    } catch (e) {
      //print("getVehicleActive $e");
    }
    if (notify) notifyListeners();
  }

  // -----------------------------------------------
  Future<void> getVehicleActive(String val, {bool notify = true}) async {
    try {
      final resC = await supabase.from('company').select().eq('company', val);

      final company = (resC as List<dynamic>);

      final res = await supabaseCtrlV
          .from('inventory_view')
          .select()
          .eq('status ->id_status', 3)
          .eq('company ->id_company', company.first["id_company"]);

      vehicles = (res as List<dynamic>)
          .map((vehicles) => Vehicle.fromJson(jsonEncode(vehicles)))
          .toList();
      //print("Entro a getVehicles");
    } catch (e) {
      //print("getVehicleActive $e");
    }
    if (notify) notifyListeners();
  }

  // -----------------------------------------------
  Future<void> getUsersNotActive() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      final res = await supabase
          .from('users')
          .select()
          .like('name', '%${searchController.text}%')
          .eq('status', 'Not Active')
          .order('sequential_id', ascending: true);

      if (res == null) {
        log('Error en getUsuarios()');
        return;
      }
      users = (res as List<dynamic>)
          .map((usuario) => User.fromJson(jsonEncode(usuario)))
          .toList();

      rows.clear();
      for (User user in users) {
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: user.sequentialId),
              'AVATAR_Column': PlutoCell(value: user.image),
              'USER_Column': PlutoCell(value: user.fullName),
              'ROLE_Column': PlutoCell(value: user.role.roleName),
              'EMAIL_Column': PlutoCell(value: user.email),
              'MOBILE_Column': PlutoCell(value: user.mobilePhone),
              'STATE_Column': PlutoCell(value: user.state.name),
              'COMPANY_Column': PlutoCell(value: user.company.company),
              'STATUS_Column': PlutoCell(value: user.status),
              'LICENSE_Column': PlutoCell(value: user.license),
              'CERTIFICATION_Column': PlutoCell(value: user.certification),
              'ACTIONS_Column': PlutoCell(value: user),
            },
          ),
        );
      }
      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getUsuarios() - $e');
    }

    notifyListeners();
  }

  // -----------------------------------------------
  Future<void> getUsers() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    // Por el momento lo dejare que se vean los not active por que están nulos los demás gracias
    try {
      final res = await supabase
          .from('users')
          .select()
          .like('name', '%${searchController.text}%')
          //.not('status', 'eq', 'Not Active')
          .order('sequential_id', ascending: true);

      if (res == null) {
        log('Error en getUsuarios()');
        return;
      }
      users = (res as List<dynamic>)
          .map((usuario) => User.fromJson(jsonEncode(usuario)))
          .toList();

      rows.clear();
      for (User user in users) {
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: user.sequentialId),
              'AVATAR_Column': PlutoCell(value: user.image),
              'USER_Column': PlutoCell(value: user.fullName),
              'ROLE_Column': PlutoCell(value: user.role.roleName),
              'EMAIL_Column': PlutoCell(value: user.email),
              'MOBILE_Column': PlutoCell(value: user.mobilePhone),
              'STATE_Column': PlutoCell(value: user.state.name),
              'COMPANY_Column': PlutoCell(value: user.company.company),
              'STATUS_Column': PlutoCell(value: user.status),
              'LICENSE_Column': PlutoCell(value: user.license),
              'CERTIFICATION_Column': PlutoCell(value: user.certification),
              'ACTIONS_Column': PlutoCell(value: user),
            },
          ),
        );
      }
      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getUsuarios() - $e');
    }

    notifyListeners();
  }

  Future<Map<String, String>?> registerUser() async {
    try {
      //Registrar al usuario con una contraseña temporal
      var response = await http.post(
        Uri.parse('$supabaseUrl/auth/v1/signup'),
        headers: {'Content-Type': 'application/json', 'apikey': anonKey},
        body: json.encode(
          {
            "email": emailController.text,
            "password": 'default',
          },
        ),
      );
      if (response.statusCode > 204) {
        return {'Error': 'The user already exists'};
      }

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
      if (currentUser!.isCRM) {
        await supabase.from('user_profile').insert(
          {
            'user_profile_id': userId,
            'name': nameController.text,
            'last_name': lastNameController.text,
            'home_phone': phoneController.text,
            'mobile_phone': phoneController.text,
            'address': '123 Main St.',
            'image': imageName,
            'birthdate': DateTime.now().toIso8601String(),
            'id_role_fk': selectedRole!.id,
            'state_fk': selectedState!.id,
          },
        );
      } else if (currentUser!.isCV) {
        await supabase.from('user_profile').insert(
          {
            'user_profile_id': userId,
            'name': nameController.text,
            'last_name': lastNameController.text,
            'home_phone': phoneController.text,
            'mobile_phone': phoneController.text,
            'address': '123 Main St.',
            'image': imageName,
            'birthdate': DateTime.now().toIso8601String(),
            'id_role_fk': selectedRole!.id,
            'state_fk': selectedState!.id,
            'id_company_fk': selectedCompany!.id,
            'id_vehicle_fk': selectedVehicle?.idVehicle,
            'status': dropdownvalue,
            'license': licenseController.text,
            'certification': certificationController.text
          },
        );
      }
      return true;
    } catch (e) {
      log('Error in createUserProfile() - $e');
      return false;
    }
  }

  Future<bool> deleteUser(User users) async {
    try {
      await supabase
          .from('user_profile')
          .delete()
          .match({'user_profile_id': users.id});

      return true;
    } catch (e) {
      log('Error in deleteUser() - $e');
      return false;
    }
  }

  Future<bool> updateUser(User users) async {
    try {
      await supabase.from('user_profile').update({
        'user_profile_id': users.id,
        'name': nameControllerUpdate.text,
        'last_name': lastNameControllerUpdate.text,
        'home_phone': phoneControllerUpdate.text,
        'mobile_phone': phoneControllerUpdate.text,
        'address': '124 Main St.',
        'image': imageName,
        'birthdate': DateTime.now().toIso8601String(),
        'id_role_fk': selectedRoleUpdate?.id ?? users.role.id,
        'state_fk': selectedStateUpdate?.id ?? users.state.id,
        'id_vehicle_fk': selectedVehicleUpdate?.idVehicle ?? users.idVehicle,
        'id_company_fk': selectedCompanyUpdate?.id ?? users.company.id,
        'status': statusControllerUpdate.text,
        'license': licenseControllerUpdate.text,
        'certification': certificationControllerUpdate.text
      }).eq('user_profile_id', users.id);

      //print("Certification: ${certificationControllerUpdate.text}");
      return true;
    } catch (e) {
      //print('Error in UpdateUser() - $e');
      return false;
    }
  }

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) return;

    final String fileExtension = p.extension(pickedImage.name);
    const uuid = Uuid();
    final String fileName = uuid.v1();
    imageName = 'avatar-$fileName$fileExtension';

    webImage = await pickedImage.readAsBytes();

    notifyListeners();
  }

  void clearImage() {
    webImage = null;
    imageName = null;
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (webImage != null && imageName != null) {
      try {
        await supabase.storage.from('avatars').uploadBinary(
              imageName!,
              webImage!,
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: false,
              ),
            );

        return imageName;
      } catch (e) {
        log('Error in uploadImage() - $e');
        return null;
      }
    }
    return null;
  }

  ////////////////////////////////////////////////////////
  //////////////////////////RIVE//////////////////////////
  ////////////////////////////////////////////////////////

  Future<void> loadRiveAssets() async {
    /* await dashboardsIconRive();
    await accountsIconRive();
    await schedulingsIconRive();
    await networksIconRive();
    await ticketsIconRive();
    await inventoriesIconRive();
    await reportsIconRive();
    await usersIconRive();
    notifyListeners();
    setIndex(0); */
  }

  setABSelected() {
    //iSelectedDashboards?.change(indexSelected[0]);
  }

  Artboard? aRDashboards;
  StateMachineController? sMCDashboards;
  SMIInput<bool>? iHoverDashboards;
  SMIInput<bool>? iSelectedDashboards;
  Future<void> dashboardsIconRive() async {
    final ByteData data =
        await rootBundle.load('assets/rive/dashboards_icon.riv');

    final file = RiveFile.import(data);

    final artboard = file.mainArtboard;

    sMCDashboards =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    if (sMCDashboards != null) {
      artboard.addController(sMCDashboards!);

      iHoverDashboards = sMCDashboards!.findInput('isHovered');
      iSelectedDashboards = sMCDashboards!.findInput('isSelected');
    }

    aRDashboards = artboard;
  }
}
