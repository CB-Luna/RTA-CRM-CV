import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' hide State;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/company.dart';
import 'package:rta_crm_cv/models/role.dart';
import 'package:rta_crm_cv/models/state.dart';
import 'package:rta_crm_cv/models/vehicle.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

class UserProfileProvider extends ChangeNotifier {
  // Controllers
  final nameController = TextEditingController();
  final middleController = TextEditingController();
  final lastNameController = TextEditingController();
  final homePhoneController = TextEditingController();
  final mobilePhoneController = TextEditingController();
  final birthdayController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final licenseController = TextEditingController();
  final certificationController = TextEditingController();
  final latepasswordController = TextEditingController();
  // Variables Individuales
  Uint8List? webImage;
  String? imageUrl;
  State? selectedState;
  String? selectedStatus = "Active";
  String? imageName;
  Vehicle? selectedVehicle;

  // Listas
  List<State> states = [];
  List<Role> roles = [];
  List<Vehicle> vehicles = [];
  List<Company> companies = [];
  List<Role> selectedRoles = [];
  List<Company> selectedCompanies = [];
  List<Vehicle> vehiclexUser = [];

  // Asignarle el valor al selected State
  void selectState(String state) {
    selectedState = states.firstWhere((elem) => elem.name == state);
    notifyListeners();
  }

  // Asignarle el valor a selected Status
  void getStatus(String status, {bool notify = true}) {
    selectedStatus = status;
    if (notify) notifyListeners();
  }

  // Pone cuales son las companias usuario
  void setSelectedCompany(List<String> companies) {
    selectedCompanies = this
        .companies
        .where((company) => companies.contains(company.company))
        .toList();
    notifyListeners();
  }

  // Pone cuales son los roles del usuario
  void setSelectedRoles(List<String> roles) {
    selectedRoles =
        this.roles.where((role) => roles.contains(role.roleName)).toList();
    notifyListeners();
  }

  // Función para traer los estados
  Future<void> getStates({bool notify = true}) async {
    try {
      final res = await supabase.from('state').select().order(
            'name',
            ascending: true,
          );

      states =
          (res as List<dynamic>).map((state) => State.fromMap(state)).toList();

      if (notify) notifyListeners();
    } catch (e) {
      log('Error en getStates() -$e');
    }
  }

  // Función para traer las companias
  Future<void> getCompanies({bool notify = true}) async {
    try {
      // final res = await supabase.from('company').select().order(
      //       'company',
      //       ascending: true,
      //     );
      // final res = await supabase
      //     .from('user_company')
      //     .select()
      //     .eq('user_fk', currentUser!.id);

      // companies = (res as List<dynamic>)
      //     .map((company) => Company.fromMap(company))
      //     .toList();

      if (notify) notifyListeners();
    } catch (e) {
      log('Error en getCompanies() -$e');
    }
  }

  // Función para traer los Roles
  Future<void> getRoles({bool notify = true}) async {
    final res = await supabase.rpc('get_roles',
        params: {'application': currentUser!.currentRole.application});

    roles = (res as List<dynamic>).map((rol) => Role.fromMap(rol)).toList();

    if (notify) notifyListeners();
  }

  // Obtenemos las variables y se los damos a los controladores
  void initEditUser() {
    nameController.text = currentUser!.name;
    middleController.text = currentUser!.middleName ?? "-";
    lastNameController.text = currentUser!.lastName;
    homePhoneController.text = currentUser!.homePhone ?? "-";
    mobilePhoneController.text = currentUser!.mobilePhone ?? "-";
    imageUrl = currentUser!.image ?? "";
    licenseController.text = currentUser!.license ?? "-";
    certificationController.text = currentUser!.certification ?? "-";
    addressController.text = currentUser!.address;
    selectedState = currentUser!.state;
    selectedRoles = [...currentUser!.roles];
    selectedCompanies = [...currentUser!.companies];
    birthdayController.text = currentUser!.birthDate == null
        ? ""
        : DateFormat("MMM/dd/yyyy").format(currentUser!.birthDate!);

    selectedStatus = currentUser!.status ?? "Not Active";
    // if (currentUser!.image != null) {
    //   imageUrl =
    //       supabase.storage.from('avatars').getPublicUrl(currentUser!.image!);
    //   // provider.imageUrl = null;
    // }
  }

  // Actualizar el usuario
  Future<bool> updateUser() async {
    try {
      await supabase.from('user_profile').update({
        'user_profile_id': currentUser!.id,
        'name': nameController.text,
        'last_name': lastNameController.text,
        'home_phone': homePhoneController.text,
        'mobile_phone': mobilePhoneController.text,
        'address': addressController.text,
        'image': imageUrl,
        'birthdate': DateTime.now().toIso8601String(),
        'state_fk': selectedState?.id ?? currentUser!.state.id,
        'id_vehicle_fk': selectedVehicle?.idVehicle ?? currentUser!.idVehicle,
        // 'id_company_fk': selectedCompany?.id ?? users.company.id,
        'status': selectedStatus,
        'license': licenseController.text,
        'certification': certificationController.text
      }).eq('user_profile_id', currentUser!.id);

      return true;
    } catch (e) {
      log('Error in UpdateUser() - $e');
      return false;
    }
  }

  Future<bool> editRoles() async {
    //Se inicializan los paises a agregar (todos)
    final List<Role> addedRoles = [...selectedRoles];
    //Se inicializan los paises a eliminar (todos)
    final List<Role> deletedRoles = [...currentUser!.roles];

    for (Role role in selectedRoles) {
      //seleccionados - usuario
      //[a,b,c] - [d] => [a,b,c] - [d]
      //[a,b,c] - [a,b] => [c] - []
      //[a,b,c] - [a,b,d] => [c] - [d]
      //[d] - [a,b] => [d] - [a,b]
      if (currentUser!.roles.contains(role)) {
        //Si lo contiene, se elimina de los roles a agregar
        addedRoles.remove(role);
        //Si lo contiene, se elimina de los roles a eliminar
        deletedRoles.remove(role);
      }
    }

    for (final Role role in addedRoles) {
      await supabase.from('user_role').insert(
        {
          'user_fk': currentUser!.id,
          'role_fk': role.id,
        },
      );
    }

    for (final Role role in deletedRoles) {
      await supabase
          .from('user_role')
          .delete()
          .eq('user_fk', currentUser!.id)
          .eq(
            'role_fk',
            role.id,
          );
    }

    return true;
  }

  // Editar las companias
  Future<bool> editCompanys() async {
    //Se inicializan los paises a agregar (todos)
    final List<Company> addedCompanies = [...selectedCompanies];
    //Se inicializan los paises a eliminar (todos)
    final List<Company> deletedCompanies = [...currentUser!.companies];

    for (Company company in selectedCompanies) {
      //seleccionados - usuario
      //[a,b,c] - [d] => [a,b,c] - [d]
      //[a,b,c] - [a,b] => [c] - []
      //[a,b,c] - [a,b,d] => [c] - [d]
      //[d] - [a,b] => [d] - [a,b]
      if (currentUser!.companies.contains(company)) {
        //Si lo contiene, se elimina de los roles a agregar
        addedCompanies.remove(company);
        //Si lo contiene, se elimina de los roles a eliminar
        deletedCompanies.remove(company);
      }
    }

    for (final Company company in deletedCompanies) {
      await supabase
          .from('user_company')
          .delete()
          .eq('user_fk', currentUser!.id)
          .eq(
            'company_fk',
            company.id,
          );
    }

    for (final Company company in addedCompanies) {
      await supabase.from('user_company').insert(
        {
          'user_fk': currentUser!.id,
          'company_fk': company.id,
        },
      );
    }

    return true;
  }

  // Seleccionar la imagen
  Future<void> selectImage() async {
    try {
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
    } catch (e) {
      log("Error in selectImage -$e");
    }
  }

  void clearImage() {
    webImage = null;
    // imageUrl = null;
    imageName = null;
    notifyListeners();
  }

  // Subir Imagen
  Future<String?> uploadImage() async {
    try {
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
        // imageUrl = imageName;
        imageUrl = "$supabaseUrl/storage/v1/object/public/avatars/$imageName";
        return imageName;
      }
      return null;
    } catch (e) {
      log("Error in uploadImage - $e");
    }
    return null;
  }

  // Validar Imagen
  Future<void> validateImage(String? image) async {
    try {
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
    } catch (e) {
      log("Error in validateImage -$e");
    }
  }

  // ----------------------- SECCION CONTROL VEHICULAR X USER ------------------

  // Darle el valor a selectedVehicle
  void selectedVehiclee(String vehicle) {
    selectedVehicle =
        vehicles.firstWhere((element) => element.licesensePlates == vehicle);
    notifyListeners();
  }

  // Actualizar el status del vehiculo a Asignado
  Future<void> updateVehicleStatus() async {
    try {
      await supabaseCtrlV.from('vehicle').update({'id_status_fk': 1}).eq(
          'id_vehicle', selectedVehicle?.idVehicle);
    } catch (e) {
      log('Error en updateVehiclestatus() - $e');
    }
  }

  // Función para cambiar el vehiculo a viejo
  Future<void> updateVehicleStatusUpdate() async {
    try {
      // Aqui cambiamos el status del vehiculo que seleccionamos a Assignado
      await updateVehicleStatus();

      // Aqui cambiamos el vehiculo viejo a disponible
      await supabaseCtrlV
          .from('vehicle')
          .update({'id_status_fk': 3}).eq('id_vehicle', currentUser!.idVehicle);
    } catch (e) {
      log("Error in updateVehiclestatusUpdate $e");
    }
    notifyListeners();
  }

  // Limpiar la variable
  void clearVehicle() {
    selectedVehicle = null;
    notifyListeners();
  }

  // Función para traer el vehiculo que tiene el usuario
  Future<void> getVehicleUser({bool notify = true}) async {
    try {
      final resC = await supabaseCtrlV
          .from('inventory_view')
          .select()
          .eq('id_vehicle', currentUser!.idVehicle);

      vehiclexUser = (resC as List<dynamic>)
          .map((vehiclexUser) => Vehicle.fromMap(vehiclexUser))
          .toList();
      print("El vehiclexUser es: ${vehiclexUser.first.idVehicle}");
    } catch (e) {
      log("Error in getVehicleUser() - $e");
    }
    if (notify) notifyListeners();
  }

  // Esta función lo que hace es muestra los vehiculos que sean del mismo company que el usuario.
  Future<void> getVehicleActiveInit({bool notify = true}) async {
    try {
      List<int> companyIds =
          currentUser!.companies.map((Company company) => company.id).toList();

      final res = await supabaseCtrlV
          .from('inventory_view')
          .select()
          .eq('status ->id_status', 3)
          .in_('company ->id_company', companyIds);

      vehicles = (res as List<dynamic>)
          .map((vehicles) => Vehicle.fromJson(jsonEncode(vehicles)))
          .toList();
    } catch (e) {
      log("Error in getVehicleActiveInit - $e");
    }
    if (notify) notifyListeners();
  }
}
