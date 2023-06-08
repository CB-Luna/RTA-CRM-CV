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

class UsersProvider extends ChangeNotifier {
  bool isOpen = true;
  bool forcedOpen = true;
  List<User> users = [];

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

  Role? selectedRole;

  List<State> states = [];

  State? selectedState;

  String? imageName;
  Uint8List? webImage;

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final stateController = TextEditingController();
  final roleController = TextEditingController();

  void clearControllers({bool notify = true}) {
    nameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    stateController.clear();
    roleController.clear();

    if (notify) notifyListeners();
  }

  void selectRole(String role) {
    selectedRole = roles.firstWhere((elem) => elem.roleName == role);
    notifyListeners();
  }

  void selectState(String state) {
    selectedState = states.firstWhere((elem) => elem.name == state);
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

  void load() {
    stateManager!.setShowLoading(true);
  }

  Future<void> getStates({bool notify = true}) async {
    try {
      final res = await supabase.from('state').select().order(
            'name',
            ascending: true,
          );

      states = (res as List<dynamic>).map((pais) => State.fromJson(jsonEncode(pais))).toList();

      if (notify) notifyListeners();
    } catch (e) {
      log('Error en getStates() -$e');
    }
  }

  Future<void> getRoles({bool notify = true}) async {
    final res = await supabase.from('role').select().order(
          'name',
          ascending: true,
        );

    roles = (res as List<dynamic>).map((rol) => Role.fromJson(jsonEncode(rol))).toList();

    if (notify) notifyListeners();
  }

  Future<void> getUsers() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      final res = await supabase.from('users').select().like('name', '%${searchController.text}%');

      if (res == null) {
        log('Error en getUsuarios()');
        return;
      }
      users = (res as List<dynamic>).map((usuario) => User.fromJson(jsonEncode(usuario))).toList();

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
              'ACTIONS_Column': PlutoCell(value: user.id),
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
            // TODO: implementar campo de Company
            'id_company_fk': 1,
          },
        );
      }
      return true;
    } catch (e) {
      log('Error in createUserProfile() - $e');
      return false;
    }
  }

  Future<bool> deleteUser(String userId) async {
    try {
      await supabase.rpc(
        'delete_user',
        params: {'user_id': userId},
      );
      return true;
    } catch (e) {
      log('Error in deleteUser() - $e');
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
    final ByteData data = await rootBundle.load('assets/rive/dashboards_icon.riv');

    final file = RiveFile.import(data);

    final artboard = file.mainArtboard;

    sMCDashboards = StateMachineController.fromArtboard(artboard, 'State Machine 1');

    if (sMCDashboards != null) {
      artboard.addController(sMCDashboards!);

      iHoverDashboards = sMCDashboards!.findInput('isHovered');
      iSelectedDashboards = sMCDashboards!.findInput('isSelected');
    }

    aRDashboards = artboard;
  }
}
