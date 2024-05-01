import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:uuid/uuid.dart';

import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/models.dart';
import 'package:rta_crm_cv/models/user_role.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';

import '../functions/date_format.dart';
import '../models/vehicle.dart';

class UsersProvider extends ChangeNotifier {
  List<User> users = [];
  User? usersFilter;

  List<Vehicle> vehicles = [];
  List<Vehicle> vehiclexUser = [];
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  int pageRowCount = 10;
  int page = 1;
  List<dynamic> usersRoleInstaller = [];
  List<String> idusers = [];

  List<Role> roles = [];
  List<Company> companies = [];
  List<Role> selectedRoles = [];
  List<Company> selectedCompanies = [];
  Company? selectedCompany;
  List<State> states = [];
  List<UserRole> usersRoleInstallers = [];
  List<String> installersIds = [];
  bool? pageSearch = false;
  UserRole? userRoleInstaller;
  UserRole? userSelected;
  String? selectedStatus = "Active";
  State? selectedState;
  Vehicle? selectedVehicle;
  String? imageName;

  Uint8List? webImage;
  String? imageUrl;

  Uuid uuid = const Uuid();

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final licenseController = TextEditingController();
  final certificationController = TextEditingController();
  final addressController = TextEditingController();

  //Variables para Exportar
  String companySel = "All";
  int confirmacion = 0;

  //Empresa del Manager
  String company = '';

  Future<void> updateState() async {
    rows.clear();
    await getUsers();
  }

  void initEditUser(User user) {
    nameController.text = user.name;
    lastNameController.text = user.lastName;
    emailController.text = user.email;
    phoneController.text = user.homePhone ?? "-";
    licenseController.text = user.license ?? "-";
    certificationController.text = user.certification ?? "-";
    addressController.text = user.address;
    selectedState = user.state;
    selectedRoles = [...user.roles];
    selectedCompanies = [...user.companies];
    // selectedCompany = user.company;
    selectedVehicle = null;
    selectedStatus = user.status ?? "Not Active";
  }

  void clearControllers({bool notify = true}) {
    nameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    selectedCompany = null;
    selectedState = null;
    selectedRoles.clear();
    selectedVehicle = null;
    licenseController.clear();
    certificationController.clear();

    imageName = null;
    webImage = null;

    if (notify) notifyListeners();
  }

  // NORMAL
  void setSelectedRoles(List<String> roles) {
    selectedRoles = this.roles.where((role) => roles.contains(role.roleName)).toList();
    notifyListeners();
  }

  void setSelectedCompany(List<String> companies) {
    selectedCompanies = this.companies.where((company) => companies.contains(company.company)).toList();
    notifyListeners();
  }

  void selectCompany(String companyName) {
    selectedCompany = companies.firstWhere((elem) => elem.company == companyName);
    notifyListeners();
  }

  void selectedVehiclee(String vehicle) {
    selectedVehicle = vehicles.firstWhere((element) => element.licesensePlates == vehicle);
    notifyListeners();
  }

  void clearVehicle() {
    selectedVehicle = null;
    notifyListeners();
  }

  void selectState(String state) {
    selectedState = states.firstWhere((elem) => elem.name == state);
    notifyListeners();
  }

  void getStatus(String status, {bool notify = true}) {
    selectedStatus = status;
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

  Future<void> updateVehicleStatus() async {
    try {
      await supabaseCtrlV.from('vehicle').update({'id_status_fk': 1}).eq('id_vehicle', selectedVehicle?.idVehicle);
    } catch (e) {
      log('Error en updateVehiclestatus() - $e');
    }
  }

  Future<void> updateVehicleStatusUpdate(User user) async {
    try {
      // Aqui cambiamos el status del vehiculo que seleccionamos a Assignado
      await updateVehicleStatus();

      // Aqui cambiamos el vehiculo viejo a disponible
      await supabaseCtrlV.from('vehicle').update({'id_status_fk': 3}).eq('id_vehicle', user.idVehicle);
    } catch (e) {
      log("Error in updateVehiclestatusUpdate $e");
    }
    notifyListeners();
  }

  Future<void> getInstallers({bool notify = true}) async {
    usersRoleInstallers.clear();
    userRoleInstaller = null;

    List<dynamic> roleInstallers = [];
    List<dynamic> usersRoleInstaller = [];

    installersIds.clear();

    try {
      final res = await supabase.from('role').select("").eq('name', "Installers 1");
      roleInstallers = (res as List<dynamic>);

      final res2 = await supabase.from('user_role').select("user_fk").eq("role_fk", roleInstallers.first["role_id"]);
      usersRoleInstaller = (res2 as List<dynamic>);

      for (var user in usersRoleInstaller) {
        final id = user["user_fk"];
        installersIds.add(id);
      }

      usersRoleInstallers = [];
      for (int i = 0; i < installersIds.length; i++) {
        final res3 = await supabase.from("users").select("email, name, last_name").eq("id", installersIds[i]);

        userRoleInstaller = (res3 as List<dynamic>).map((userRole) => UserRole.fromMap(userRole)).toList().first;
        usersRoleInstallers.add(userRoleInstaller!);
      }

      if (notify) notifyListeners();
    } catch (e) {
      log('Error in getInstallers() -$e');
    }
  }

  Future<void> getStates({bool notify = true}) async {
    try {
      final res = await supabase.from('state').select().order(
            'name',
            ascending: true,
          );

      states = (res as List<dynamic>).map((state) => State.fromMap(state)).toList();

      if (notify) notifyListeners();
    } catch (e) {
      log('Error en getStates() -$e');
    }
  }

  Future<void> getCompanies({bool notify = true}) async {
    try {
      final res = await supabase.from('company').select().order(
            'company',
            ascending: true,
          );

      companies = (res as List<dynamic>).map((company) => Company.fromMap(company)).toList();

      if (notify) notifyListeners();
    } catch (e) {
      log('Error en getCompanies() -$e');
    }
  }

  Future<bool> addCompany(String userId) async {
    try {
      for (final Company company in selectedCompanies) {
        await supabase.from('user_company').insert(
          {
            'user_fk': userId,
            'company_fk': company.id,
          },
        );
      }
      return true;
    } catch (e) {
      log('Error en addCompany() - $e');
      return false;
    }
  }

  Future<bool> editCompanys(User editedUser) async {
    //Se inicializan los paises a agregar (todos)
    final List<Company> addedCompanies = [...selectedCompanies];
    //Se inicializan los paises a eliminar (todos)
    final List<Company> deletedCompanies = [...editedUser.companies];

    for (Company company in selectedCompanies) {
      //seleccionados - usuario
      //[a,b,c] - [d] => [a,b,c] - [d]
      //[a,b,c] - [a,b] => [c] - []
      //[a,b,c] - [a,b,d] => [c] - [d]
      //[d] - [a,b] => [d] - [a,b]
      if (editedUser.companies.contains(company)) {
        //Si lo contiene, se elimina de los roles a agregar
        addedCompanies.remove(company);
        //Si lo contiene, se elimina de los roles a eliminar
        deletedCompanies.remove(company);
      }
    }

    for (final Company company in deletedCompanies) {
      await supabase.from('user_company').delete().eq('user_fk', editedUser.id).eq(
            'company_fk',
            company.id,
          );
    }

    for (final Company company in addedCompanies) {
      await supabase.from('user_company').insert(
        {
          'user_fk': editedUser.id,
          'company_fk': company.id,
        },
      );
    }

    return true;
  }

  Future<void> getRoles({bool notify = true}) async {
    final res = await supabase.rpc('get_roles', params: {'application': currentUser!.currentRole.application});

    roles = (res as List<dynamic>).map((rol) => Role.fromMap(rol)).toList();

    if (notify) notifyListeners();
  }

  Future<bool> addRoles(String userId) async {
    try {
      for (final Role role in selectedRoles) {
        await supabase.from('user_role').insert(
          {
            'user_fk': userId,
            'role_fk': role.id,
          },
        );
      }
      return true;
    } catch (e) {
      log('Error en addRoles() - $e');
      return false;
    }
  }

  Future<bool> editRoles(User editedUser) async {
    //Se inicializan los paises a agregar (todos)
    final List<Role> addedRoles = [...selectedRoles];
    //Se inicializan los paises a eliminar (todos)
    final List<Role> deletedRoles = [...editedUser.roles];

    for (Role role in selectedRoles) {
      //seleccionados - usuario
      //[a,b,c] - [d] => [a,b,c] - [d]
      //[a,b,c] - [a,b] => [c] - []
      //[a,b,c] - [a,b,d] => [c] - [d]
      //[d] - [a,b] => [d] - [a,b]
      if (editedUser.roles.contains(role)) {
        //Si lo contiene, se elimina de los roles a agregar
        addedRoles.remove(role);
        //Si lo contiene, se elimina de los roles a eliminar
        deletedRoles.remove(role);
      }
    }

    for (final Role role in addedRoles) {
      await supabase.from('user_role').insert(
        {
          'user_fk': editedUser.id,
          'role_fk': role.id,
        },
      );
    }

    for (final Role role in deletedRoles) {
      await supabase.from('user_role').delete().eq('user_fk', editedUser.id).eq(
            'role_fk',
            role.id,
          );
    }

    return true;
  }

  Future<void> getVehicleUser(User users, {bool notify = true}) async {
    try {
      final resC = await supabaseCtrlV.from('inventory_view').select().eq('id_vehicle', users.idVehicle);

      vehiclexUser = (resC as List<dynamic>).map((vehiclexUser) => Vehicle.fromMap(vehiclexUser)).toList();
    } catch (e) {
      log("Error in getVehicleUser() - $e");
    }
    if (notify) notifyListeners();
  }

  // Esta función lo que hace es muestra los vehiculos que sean del mismo company que el usuario.
  Future<void> getVehicleActiveInit(User users, {bool notify = true}) async {
    try {
      List<int> companyIds = users.companies.map((Company company) => company.id).toList();

      final res = await supabaseCtrlV
          .from('inventory_view')
          .select()
          .eq('status ->id_status', 3)
          .in_('company ->id_company', companyIds);

      vehicles = (res as List<dynamic>).map((vehicles) => Vehicle.fromJson(jsonEncode(vehicles))).toList();
    } catch (e) {
      log("Error in getVehicleActiveInit - $e");
    }
    if (notify) notifyListeners();
  }

  Future<void> getVehicleActive(String val, {bool notify = true}) async {
    try {
      final resC = await supabase.from('company').select().eq('company', val);
      final company = (resC as List<dynamic>);

      final res = await supabaseCtrlV
          .from('inventory_view')
          .select()
          .eq('status ->id_status', 3)
          .eq('company ->id_company', company.first["id_company"]);

      vehicles = (res as List<dynamic>).map((vehicles) => Vehicle.fromJson(jsonEncode(vehicles))).toList();
      //print("Entro a getVehicles");
    } catch (e) {
      log("Error in getVehicleActive - $e");
    }
    if (notify) notifyListeners();
  }

  Future<void> changeStatusUser(User users) async {
    try {
      final res =
          await supabase.from("user_profile").update({'status': 'Not Active'}).eq('sequential_id', users.sequentialId);

      vehicles = (res as List<dynamic>).map((vehicles) => Vehicle.fromJson(jsonEncode(vehicles))).toList();
    } catch (e) {
      log("Error in changeStatusUser() - $e");
    }
    notifyListeners();
  }

  Future<void> getUsers({String active = 'Active'}) async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      final query = supabase.from('users').select().like('name', '%${searchController.text}%').eq('status', active);

      if (currentUser!.isManagerJSA) query.eq('id_company_fk', currentUser!.companyFk);

      final res = await query.order('sequential_id', ascending: true);

      if (res == null) {
        log('Error en getUsuarios()');
        return;
      }
      users = (res as List<dynamic>).map((usuario) => User.fromMap(usuario)).toList();

      users = users
          .where((user) => user.roles.any((role) => role.application == currentUser!.currentRole.application))
          .toList();

      if (currentUser!.isLeadJSA) {
        users.clear();
        idusers.clear();
        final res2 = await supabase.from('user_permission').select().eq('report_to', currentUser!.id);
        usersRoleInstaller = (res2 as List<dynamic>);
        for (var user in usersRoleInstaller) {
          final id = user["user_fk"];
          idusers.add(id);
        }

        for (int i = 0; i < idusers.length; i++) {
          final resLead = await supabase
              .from('users')
              .select()
              .eq('status', active)
              .eq('user_profile_id', idusers[i])
              .order('sequential_id', ascending: true);

          dynamic userMap = (resLead as List<dynamic>).first;
          User userFilter = User.fromMap(userMap);

          users.add(userFilter);
        }
      }

      rows.clear();

      for (User user in users) {
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: user.sequentialId),
              'AVATAR_Column': PlutoCell(value: user.image),
              'USER_Column': PlutoCell(value: user.fullName),
              'ROLE_Column': PlutoCell(value: user.currentAppRole),
              'EMAIL_Column': PlutoCell(value: user.email),
              'MOBILE_Column': PlutoCell(value: user.mobilePhone),
              'ADDRESS_Column': PlutoCell(value: user.address),
              'STATE_Column': PlutoCell(value: user.state.name),
              'COMPANY_Column': PlutoCell(value: user.companies),
              'STATUS_Column': PlutoCell(value: user.status),
              'LicenseP_Column': PlutoCell(value: user.licensePlates),
              'LICENSE_Column': PlutoCell(value: user.license),
              'CERTIFICATION_Column': PlutoCell(value: user.certification),
              'ACTIONS_Column': PlutoCell(value: user),
            },
          ),
        );
      }
      if (stateManager != null) stateManager!.notifyListeners();
      notifyListeners();
    } catch (e) {
      log('Error en getUsuarios() - $e');
    }
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
    } catch (e) {
      log('Error in registerUser() - $e');
    }
    return {'Error': 'Error registering user'};
  }

  Future<bool> createUserProfile(String userId) async {
    if (selectedState == null || selectedRoles.isEmpty) return false;
    try {
      //TODO: agregar multiples roles
      if (currentUser!.isCRM) {
        await supabase.from('user_profile').insert(
          {
            'user_profile_id': userId,
            'name': nameController.text,
            'last_name': lastNameController.text,
            'home_phone': phoneController.text,
            'mobile_phone': phoneController.text,
            'address': '123 Main St.',
            'image': imageUrl,
            'status': selectedStatus,
            'birthdate': DateTime.now().toIso8601String(),
            'state_fk': selectedState!.id,
          },
        );
      } else if (currentUser!.isCV || currentUser!.isDashboardsRTATEL) {
        await supabase.from('user_profile').insert(
          {
            'user_profile_id': userId,
            'name': nameController.text,
            'last_name': lastNameController.text,
            'home_phone': phoneController.text,
            'mobile_phone': phoneController.text,
            'address': addressController.text,
            'image': imageUrl,
            'birthdate': DateTime.now().toIso8601String(),
            'state_fk': selectedState!.id,
            'id_company_fk': selectedCompany!.id,
            'id_vehicle_fk': selectedVehicle?.idVehicle,
            'status': selectedStatus,
            'license': licenseController.text.isEmpty ? null : licenseController.text,
            'certification': certificationController.text.isEmpty ? null : licenseController.text
          },
        );
      }
      return true;
    } catch (e) {
      log('Error in createUserProfile() - $e');
      return false;
    }
  }

  Future<bool> deleteUser(User user) async {
    final rolesToDelete = user.roles.where((role) => role.application == currentUser!.currentRole.application).toList();
    final roleIds = rolesToDelete.map((role) => role.id).toList();

    try {
      //first delete roles in current application
      await supabase.from('user_role').delete().eq('user_fk', user.id).in_('role_fk', roleIds);

      //if application is jsa - delete jsa records
      if (currentUser!.currentRole.application == 'JSA') {
        await supabase.rpc('delete_jsa_user', params: {'user_id': user.id});
      }

      //if role deleted is last role - delete user completely
      if (rolesToDelete.length == user.roles.length) {
        await supabase.rpc('delete_user', params: {'user_id': user.id});
      }

      return true;
    } catch (e) {
      log('Error in deleteUser() - $e');
      return false;
    }
  }

  Future<bool> updateUser(User users) async {
    //TODO: agregar multiples roles
    try {
      await supabase.from('user_profile').update({
        'user_profile_id': users.id,
        'name': nameController.text,
        'last_name': lastNameController.text,
        'home_phone': phoneController.text,
        'mobile_phone': phoneController.text,
        'address': addressController.text,
        'image': imageUrl,
        'birthdate': DateTime.now().toIso8601String(),
        'state_fk': selectedState?.id ?? users.state.id,
        'id_vehicle_fk': selectedVehicle?.idVehicle ?? users.idVehicle,
        // 'id_company_fk': selectedCompany?.id ?? users.company.id,
        'status': selectedStatus,
        'license': licenseController.text,
        'certification': certificationController.text
      }).eq('user_profile_id', users.id);

      return true;
    } catch (e) {
      log('Error in UpdateUser() - $e');
      return false;
    }
  }

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) return;

    final String fileExtension = path.extension(pickedImage.name);
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
      if (webImage!.length > 1000000) {
        ApiErrorHandler.callToast('Image is bigger than 1 MB');
      }
      await supabase.storage.from('avatars').uploadBinary(
            imageName!,
            webImage!,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: false,
            ),
          );

      return imageName;
    }
    return null;
  }

  Future<void> validateImage(String? image) async {
    if (image == null) {
      if (webImage != null) {
        //usuario no tiene imagen y se agrego => se sube imagen
        final res = await uploadImage();
        if (res == null) {
          ApiErrorHandler.callToast('Could not upload image');
        }
      }
      //usuario no tiene imagen y no se agrego => no hace nada
    } else {
      //usuario tiene imagen y se borro => se borra en bd
      if (webImage == null && imageName == null) {
        await supabase.storage.from('avatars').remove([image]);
      }
      //usuario tiene imagen y no se modifico => no se hace nada

      //usuario tiene imagen y se cambio => se borra en bd y se sube la nueva
      if (webImage != null && imageName != image) {
        await supabase.storage.from('avatars').remove([image]);
        final res2 = await uploadImage();
        if (res2 == null) {
          ApiErrorHandler.callToast('Could not upload image');
        }
      }
    }
  }

  void clearControllerExportData({bool notify = true}) {
    companySel = "All";
    if (notify) notifyListeners();
  }

  void getCompanyFilter(String comp, {bool notify = true}) {
    companySel = comp;
    confirmacion++;
    if (notify) notifyListeners();
  }

  Future<bool> excelActivityReports() async {
    //Crear excel
    Excel excel = Excel.createExcel();
    Sheet? sheet = excel.sheets[excel.getDefaultSheet()];
    List<User> selectedComp = [];

    //TITULO
    sheet?.merge(CellIndex.indexByString("B1"), CellIndex.indexByString("C1"));
    //Headers para secciones

    sheet?.setColWidth(4, 25);
    sheet?.setColWidth(5, 30);

    if (sheet == null) return false;
    CellStyle titulo = CellStyle(
      fontFamily: getFontFamily(FontFamily.Calibri),
      fontSize: 16,
      bold: true,
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
    );
    var cellT = sheet.cell(CellIndex.indexByString("A1"));
    cellT.value = "Title";
    cellT.cellStyle = titulo;

    var cellT2 = sheet.cell(CellIndex.indexByString("B1"));
    cellT2.value = "Users";
    cellT2.cellStyle = titulo;

    var cellD = sheet.cell(CellIndex.indexByString("D1"));
    cellD.value = "Date";
    cellD.cellStyle = titulo;

    var cellD2 = sheet.cell(CellIndex.indexByString("E1"));
    cellD2.value = dateFormat(DateTime.now());
    cellD2.cellStyle = titulo;

    //Agregar primera linea
    sheet.appendRow(['']);
    //Agregar linea vacia

    //blanco, bold y mas grande
    CellStyle cellStyle = CellStyle(
      backgroundColorHex: "#1E90FF",
      fontColorHex: Colors.white.value.toRadixString(16),
      fontFamily: getFontFamily(FontFamily.Calibri),
      fontSize: 16,
      bold: true,
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
    );
    var cell = sheet.cell(CellIndex.indexByString("A3"));
    cell.value = "Id";
    cell.cellStyle = cellStyle;

    var cell2 = sheet.cell(CellIndex.indexByString("B3"));
    cell2.value = "Name";
    cell2.cellStyle = cellStyle;

    var cell3 = sheet.cell(CellIndex.indexByString("C3"));
    cell3.value = "Last Name";
    cell3.cellStyle = cellStyle;

    var cell4 = sheet.cell(CellIndex.indexByString("D3"));
    cell4.value = "Role";
    cell4.cellStyle = cellStyle;

    var cell5 = sheet.cell(CellIndex.indexByString("E3"));
    cell5.value = "Email";
    cell5.cellStyle = cellStyle;

    var cell6 = sheet.cell(CellIndex.indexByString("F3"));
    cell6.value = "Mobile Phone";
    cell6.cellStyle = cellStyle;

    var cell7 = sheet.cell(CellIndex.indexByString("G3"));
    cell7.value = "State";
    cell7.cellStyle = cellStyle;

    var cell8 = sheet.cell(CellIndex.indexByString("H3"));
    cell8.value = "Company";
    cell8.cellStyle = cellStyle;

    var cell9 = sheet.cell(CellIndex.indexByString("I3"));
    cell9.value = "Status";
    cell9.cellStyle = cellStyle;

    var cell10 = sheet.cell(CellIndex.indexByString("J3"));
    cell10.value = "License";
    cell10.cellStyle = cellStyle;

    var cell11 = sheet.cell(CellIndex.indexByString("K3"));
    cell11.value = "Certification";
    cell11.cellStyle = cellStyle;

    var cell12 = sheet.cell(CellIndex.indexByString("L3"));
    cell12.value = "Adress";
    cell12.cellStyle = cellStyle;

    //sortear por su Id
    users.sort((a, b) => a.sequentialId.compareTo(b.sequentialId));

    //Filtrat por compania
    if (companySel != "All") {
      for (int x = 0; x < users.length; x++) {
        List<String> listCompanySel = [];
        for (var company in users[x].companies) {
          listCompanySel.add(company.company);
        }
        if (listCompanySel.contains(companySel)) {
          selectedComp.add(users[x]);
        }
        // if (companySel == listCompanySel) {
        //   selectedComp.add(users[x]);
        // }
      }
    } else {
      selectedComp = users;
    }

    //Agregar datos
    for (int i = 0; i < selectedComp.length; i++) {
      //Sortear por Compania
      User report = selectedComp[i];
      List<String> listCompany = [];
      for (var company in report.companies) {
        listCompany.add(company.company);
      }
      final List<dynamic> row = [
        report.sequentialId,
        report.name,
        report.lastName,
        report.roles.first.roleName,
        report.email,
        report.mobilePhone,
        report.state.name,
        // report.companies,
        listCompany,
        report.status,
        report.license,
        report.certification,
        report.address
      ];
      sheet.appendRow(row);
    }

    //Descargar
    final List<int>? fileBytes = excel.save(fileName: "Users.xlsx");
    //Limpiar controladores y variables
    companySel = "All";

    if (fileBytes == null) return false;

    return true;
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    licenseController.dispose();
    certificationController.dispose();
    addressController.dispose();
    super.dispose();
  }
}
