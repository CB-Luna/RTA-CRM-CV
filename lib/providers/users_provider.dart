import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:http/http.dart' as http;

import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/models.dart';
import 'package:rta_crm_cv/models/user_role.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:uuid/uuid.dart';

import '../functions/date_format.dart';
import '../models/vehicle.dart';

class UsersProvider extends ChangeNotifier {
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
  List<Role> selectedRoles = [];
  Company? selectedCompany;
  Company? selectedCompanyUpdate;
  List<State> states = [];
  List<dynamic> roleInstallers = [];
  List<dynamic> usersRoleInstaller = [];
  List<User> installers = [];
  List<UserRole> usersRoleInstallers = [];
  List<String> idsinstallers = [];
  bool? pagesearch = false;
  UserRole? userRoleInstaller;
  UserRole? userSelected;
  String? dropdownvalue = "Active";
  String? dropdownvalueUpdate = "Not Active";
  State? selectedState;
  State? selectedStateUpdate;
  Vehicle? selectedVehicle;
  Vehicle? selectedVehicleUpdate;
  String? selectVehiclePlates;
  String? imageName;
  Uint8List? webImage;
  Vehicle? actualVehicle;
  String? placeHolderImage;
  String? imageUrl;
  String? imageUrlUpdate;
  Uuid uuid = const Uuid();

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
  final addressController = TextEditingController();

  //Variables para Exportar
  String companySel = "All";
  int confirmacion = 0;

  //Empresa del Manager
  String company = '';

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
  final addressControllerUpdate = TextEditingController();

  void updateControllers(User user) {
    nameControllerUpdate.text = user.name;
    lastNameControllerUpdate.text = user.lastName;
    emailControllerUpdate.text = user.email;
    phoneControllerUpdate.text = user.homePhone ?? "-";
    selectedStateUpdate = user.state;
    selectedRoles = [...user.roles];
    selectedCompanyUpdate = user.company;
    selectedVehicleUpdate = null;
    addressControllerUpdate.text = user.address;
    dropdownvalueUpdate = user.status ?? "Not Active";
    licenseControllerUpdate.text = user.license ?? "-";
    certificationControllerUpdate.text = user.certification ?? "-";
    selectVehiclePlates = user.licensePlates;
    imageUrlUpdate = user.image == null
        ? "$supabaseUrl/storage/v1/object/public/assets/user_profile/"
        : user.image!.replaceAll(
            "$supabaseUrl/storage/v1/object/public/assets/user_profile/", "");
  }

  void clearControllers({bool notify = true}) {
    nameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    stateController.clear();
    roleController.clear();
    addressController.clear();
    selectedCompany = null;
    selectedState = null;
    selectedRoles.clear();
    selectedVehicle = null;
    companyCOntroller.clear();
    statusController.clear();
    licenseController.clear();
    certificationController.clear();
    webImage = null;
    if (notify) notifyListeners();
  }

  // NORMAL
  void setSelectedRoles(List<String> roles) {
    selectedRoles =
        this.roles.where((role) => roles.contains(role.roleName)).toList();
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

  void clearVehicle() {
    selectedVehicle = null;
    log("Entro aqui");
    notifyListeners();
  }

  // Función para inicializar la imagen
  void inicializeImage() {
    webImage = null;
    notifyListeners();
  }

  void clearVehicleLicense({bool notify = true}) {
    selectVehiclePlates = null;
    if (notify) notifyListeners();
  }

  void clearVehicleUpdate() {
    selectedVehicleUpdate = null;

    log("Entro aqui Update");
    notifyListeners();
  }

  // void selectInstaller(String installer, {bool notify = true}) {
  //   userSelected =
  //       usersRoleInstallers.firstWhere((elem) => elem.email == installer);
  //   if (notify) notifyListeners();
  // }

  void selectState(String state) {
    selectedState = states.firstWhere((elem) => elem.name == state);
    notifyListeners();
  }

  void selectCompanyUpdate(String companyName) {
    selectedCompanyUpdate =
        companys.firstWhere((elem) => elem.company == companyName);
    notifyListeners();
  }

  void getStatus(String status, {bool notify = true}) {
    dropdownvalue = status;
    if (notify) notifyListeners();
  }

  void getStatusupdate(String status, {bool notify = true}) {
    dropdownvalueUpdate = status;
    if (notify) notifyListeners();
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

  Future<void> updateVehiclestatus() async {
    try {
      await supabaseCtrlV.from('vehicle').update({'id_status_fk': 1}).eq(
          'id_vehicle', selectedVehicle?.idVehicle);
    } catch (e) {
      log('Error en updateVehiclestatus() - $e');
    }
  }

  Future<void> deleteImage() async {
    // Eliminar la imagen Anterior
    try {
      if (imageUrlUpdate != null) {
        final List<FileObject> oldImage = await supabase.storage
            .from('assets')
            .remove(['user_profile/${imageUrlUpdate!}']);
        if (oldImage.isEmpty) return;
      }
    } catch (e) {
      //print("Error in deleteImage $e");
    }
  }

  Future<void> updateVehiclestatusUpdate(User users) async {
    try {
      //print("Id del SelectedVehicleUpdate: ${selectedVehicleUpdate?.idVehicle}");
      // Aqui cambiamos el status del vehiculo que seleccionamos a Assignado
      await supabaseCtrlV.from('vehicle').update({'id_status_fk': 1}).eq(
          'id_vehicle', selectedVehicleUpdate?.idVehicle);

      // Aqui cambiamos el vehiculo viejo a disponible
      await supabaseCtrlV
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

  void updateVehiclestatusClear(User users) async {
    try {
      // Aqui cambiamos el vehiculo viejo a disponible
      await supabaseCtrlV
          .from('vehicle')
          .update({'id_status_fk': 3}).eq('id_vehicle', users.idVehicle);

      // Aqui cambiamos el id del vehiculo donde el id_sequential sea el mismo que el del usuario
      await supabase.from('user_profile').update({'id_vehicle_fk': null}).eq(
          'sequential_id', users.sequentialId);

      //print("entro a updateVehiclestatusUpdate: $res");
      //print("Entro en el cambio del vehiculo viejo $res2");
    } catch (e) {
      //print("Error in updateVehiclestatusUpdate $e");
    }
    notifyListeners();
  }

  // void clearListInstallers({bool notify = true}) {
  //   usersRoleInstallers = [];
  //   userRoleInstaller = null;
  //   idsinstallers = [];
  //   roleInstallers = [];
  //   if (notify) notifyListeners();
  // }
  // Future<void> getInstallers({bool notify = true}) async {
  //   usersRoleInstallers = [];
  //   userRoleInstaller = null;
  //   idsinstallers = [];
  //   roleInstallers = [];
  //   try {
  //     final res =
  //         await supabase.from('role').select("").eq('name', "Installers 1");
  //     // print(res);
  //     // print("--------");
  //     roleInstallers = (res as List<dynamic>);
  //     // print(roleInstallers.first["role_id"]);

  //     final res2 = await supabase
  //         .from('user_role')
  //         .select("user_fk")
  //         .eq("role_fk", roleInstallers.first["role_id"]);
  //     // print(res2);
  //     usersRoleInstaller = (res2 as List<dynamic>);

  //     // Utiliza un bucle for para obtener los IDs
  //     for (var user in usersRoleInstaller) {
  //       final id = user["user_fk"];
  //       idsinstallers.add(id);
  //     }

  //     usersRoleInstallers = [];
  //     for (int i = 0; i < idsinstallers.length; i++) {
  //       final res3 = await supabase
  //           .from("users")
  //           .select("email, name, last_name")
  //           .eq("id", idsinstallers[i]);

  //       // print("----------");
  //       // print("res3: $res3");
  //       // print("Cuantas veces va: $i");
  //       userRoleInstaller = (res3 as List<dynamic>)
  //           .map((userrole) => UserRole.fromJson(jsonEncode(userrole)))
  //           .toList()
  //           .first;
  //       usersRoleInstallers.add(userRoleInstaller!);
  //       // print("El UserRole es: ${usersRoleInstallers[i].email}");
  //     }
  //     // print("Length ids ${idsinstallers.length}");
  //     // print("Length userRoleInstallers ${usersRoleInstallers.length}");
  //     if (notify) notifyListeners();
  //   } catch (e) {
  //     log('Error in getInstallers() -$e');
  //   }
  // }

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
    final res = await supabase.rpc('get_roles');

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
  Future<void> changeStatusUser(User users) async {
    try {
      final res = await supabase.from("user_profile").update(
          {'status': 'Not Active'}).eq('sequential_id', users.sequentialId);

      vehicles = (res as List<dynamic>)
          .map((vehicles) => Vehicle.fromJson(jsonEncode(vehicles)))
          .toList();
    } catch (e) {
      log("Error in changeStatusUser() - $e");
    }
    notifyListeners();
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
              'ROLE_Column': PlutoCell(value: user.roles.first.roleName),
              'EMAIL_Column': PlutoCell(value: user.email),
              'MOBILE_Column': PlutoCell(value: user.mobilePhone),
              'ADDRESS_Column': PlutoCell(value: user.address),
              'STATE_Column': PlutoCell(value: user.state.name),
              'COMPANY_Column': PlutoCell(value: user.company.company),
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
      // var res;
      final res = await supabase
          .from('users')
          .select()
          .like('name', '%${searchController.text}%')
          .not('status', 'eq', 'Not Active')
          // .like("roles->>application",
          //     "%${currentUser!.currentRole.application}%")
          .order('sequential_id', ascending: true);
      if (res == null) {
        log('Error en getUsuarios()');
        return;
      }
      users = (res as List<dynamic>)
          .map((usuario) => User.fromMap(usuario))
          .toList();

      rows.clear();
      for (User user in users) {
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: user.sequentialId),
              'AVATAR_Column': PlutoCell(value: user.image),
              'USER_Column': PlutoCell(value: user.fullName),
              'ROLE_Column': PlutoCell(value: user.roles.first.roleName),
              'EMAIL_Column': PlutoCell(value: user.email),
              'MOBILE_Column': PlutoCell(value: user.mobilePhone),
              'ADDRESS_Column': PlutoCell(value: user.address),
              'STATE_Column': PlutoCell(value: user.state.name),
              'COMPANY_Column': PlutoCell(value: user.company.company),
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

      return {'Error': 'Error registering user'};
    } catch (e) {
      log('Error en registrarUsuario() - $e');
      return {'Error': 'Error registering user'};
    }
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
            'birthdate': DateTime.now().toIso8601String(),
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
            'address': addressController.text,
            'image': imageUrl,
            'birthdate': DateTime.now().toIso8601String(),
            'state_fk': selectedState!.id,
            'id_company_fk': selectedCompany!.id,
            'id_vehicle_fk': selectedVehicle?.idVehicle,
            'status': dropdownvalue,
            'license':
                licenseController.text.isEmpty ? null : licenseController.text,
            'certification': certificationController.text.isEmpty
                ? null
                : licenseController.text
          },
        );
      }
      return true;
    } catch (e) {
      log('Error in createUserProfile() - $e');
      return false;
    }
  }

  Future<bool> deleteUserAuth(User users) async {
    try {
      final res =
          await supabase.rpc('borrar_usuario', params: {'correo': users.email});
      if (res == null) {
        log('Error in res null, deleteUserAuth');
        return false;
      }
      return true;
    } catch (e) {
      log('Error in deleteUserAuth() - $e');
      return false;
    }
  }

  Future<bool> updateUser(User users) async {
    //TODO: agregar multiples roles
    try {
      await supabase.from('user_profile').update({
        'user_profile_id': users.id,
        'name': nameControllerUpdate.text,
        'last_name': lastNameControllerUpdate.text,
        'home_phone': phoneControllerUpdate.text,
        'mobile_phone': phoneControllerUpdate.text,
        'address': addressControllerUpdate.text,
        'image': imageUrl,
        'birthdate': DateTime.now().toIso8601String(),
        // 'id_role_fk': selectedRoleUpdate?.id ?? users.role.id,
        'state_fk': selectedStateUpdate?.id ?? users.state.id,
        'id_vehicle_fk': selectedVehicleUpdate?.idVehicle ?? users.idVehicle,
        'id_company_fk': selectedCompanyUpdate?.id ?? users.company.id,
        'status': dropdownvalueUpdate,
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

  // Función para seleccionar la imagen
  Future<bool> selectImage() async {
    final ImagePicker picker = ImagePicker();

    XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    webImage = await pickedImage?.readAsBytes();

    if (pickedImage != null) {
      if (await pickedImage.length() <= 1000000) {
        // String? placeHolderImage;
        notifyListeners();
        placeHolderImage = "${uuid.v4()}${pickedImage.name}";

        // final storageResponse =
        //     await supabase.storage.from('assets/user_profile').uploadBinary(
        //           placeHolderImage!,
        //           webImage!,
        //           fileOptions: const FileOptions(
        //             cacheControl: '3600',
        //             upsert: false,
        //           ),
        //         );

        // if (storageResponse.isNotEmpty) {
        //   imageUrl = supabase.storage.from('assets/user_profile').getPublicUrl(
        //         placeHolderImage,
        //       );
        // }
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  void clearImage() {
    webImage = null;
    imageName = null;
    notifyListeners();
  }

  Future<void> uploadImage() async {
    try {
      final storageResponse =
          await supabase.storage.from('assets/user_profile').uploadBinary(
                placeHolderImage!,
                webImage!,
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );

      if (storageResponse.isNotEmpty) {
        imageUrl = supabase.storage.from('assets/user_profile').getPublicUrl(
              placeHolderImage!,
            );
      }

      // return imageName;
    } catch (e) {
      log('Error in uploadImage() - $e');
      // return null;
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
        if (users[x].company.company == companySel) {
          selectedComp.add(users[x]);
        }
      }
    } else {
      selectedComp = users;
    }
    //Agregar datos
    for (int i = 0; i < selectedComp.length; i++) {
      //Sortear por Compania

      User report = selectedComp[i];

      final List<dynamic> row = [
        report.sequentialId,
        report.name,
        report.lastName,
        report.roles.first.roleName,
        report.email,
        report.mobilePhone,
        report.state.name,
        report.company.company,
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
}
