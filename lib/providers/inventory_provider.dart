import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../helpers/globals.dart';
import '../models/vehicle.dart';

class InventoryProvider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];
  //ALTA USUARIO
  TextEditingController nombreController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController apellidosController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController areaTrabajoController = TextEditingController();
  TextEditingController extController = TextEditingController();
  TextEditingController proveedorController = TextEditingController();
  TextEditingController nombreProveedorController = TextEditingController();
  TextEditingController cuentaProveedorController = TextEditingController();
  TextEditingController puntosController = TextEditingController();
  String altaDropValue = "";
  int areaTrabajoId = 7; //por definir

  String? cuentasDropValue = '';
  late int rolParaRegistro;
  String headerText = 'Nuevo usuario';
  String? imageName;
  Uint8List? webImage;

  //List<RolApi> roles = [];
  List<String> dropdownMenuItems = [];

  List<Vehicle> vehicles = [];
  //List<Empleados> usuarios = [];
  //List<Empleados> usuariosTesoreros = [];

  //List<RolApi> rolesSeleccionados = [];
  List<String> areaNames = [];
  bool isProveedor = false;
  bool isTesoreroLocal = false;
  String? selectedRadio;
  int? proveedorId;
  String? responsableId;
  String? estatusFiltrado;
  bool botonTransferir = false;
  // Variables para las tarjetas de los vehiculos
  // Total
  int totalVehicleODE = 0;
  int totalVehicleCRY = 0;
  int totalVehicleSMI = 0;
  // Repair
  int totalRepairODE = 0;
  int totalRepairCRY = 0;
  int totalRepairSMI = 0;
  // Assigned
  int totalAssignedODE = 0;
  int totalAssignedCRY = 0;
  int totalAssignedSMI = 0;
  // Available
  int totalAvailableODE = 0;
  int totalAvailableCRY = 0;
  int totalAvailableSMI = 0;

  //Variables usadas para el popup confirmar trnsaccion
  String? jefeOld;
  String? avatarNew;
  String? nombreNew;
//------------------------------------------
  //PANTALLA USUARIOS
  final busquedaController = TextEditingController();
  late final TextEditingController filasController;
  int countF = 20;
  String orden = "usuario_id_secuencial";
  bool asc = true;
  bool filtroSimple = false;
  final AutoSizeGroup tableTopGroup = AutoSizeGroup();
  final AutoSizeGroup tableContentGroup = AutoSizeGroup();

  //----------------------------------------------Paginador variables

  int seccionActual = 1;
  int totalSecciones = 1;
  int totalFilas = 0;
  int from = 0;
  int hasta = 20;
  //----------------------------------------------

  InventoryProvider() {
    getInventory();
    filasController = TextEditingController(text: countF.toString());
  }

//---------------------------------------------
  Future<void> setSeccionActual(int value) async {
    seccionActual = value;
    await getInventory();
  }

  updaterolParaRegistro(int valor, String header) {
    rolParaRegistro = valor;
    headerText = header;
    /*  notifyListeners(); */
    clearControllers();
    return;
  }

  Future<void> getInventory() async {
    try {
      final res = await supabase.from('inventory_view').select();
      vehicles = (res as List<dynamic>)
          .map((vehicles) => Vehicle.fromJson(jsonEncode(vehicles)))
          .toList();

      rows.clear();
      totalVehicleODE = 0;
      totalVehicleCRY = 0;
      totalVehicleSMI = 0;
      // Repair
      totalRepairODE = 0;
      totalRepairCRY = 0;
      totalRepairSMI = 0;
      // Assigned
      totalAssignedODE = 0;
      totalAssignedCRY = 0;
      totalAssignedSMI = 0;
      // Available
      totalAvailableODE = 0;
      totalAvailableCRY = 0;
      totalAvailableSMI = 0;
      for (Vehicle vehicle in vehicles) {
        if (vehicle.company.company == "ODE") {
          totalVehicleODE = totalVehicleODE + 1;
          if (vehicle.status.status == "Repair") {
            totalRepairODE = totalRepairODE + 1;
          }
          if (vehicle.status.status == "Assigned") {
            totalAssignedODE = totalAssignedODE + 1;
          }
          if (vehicle.status.status == "Available") {
            totalAvailableODE = totalAvailableODE + 1;
          }
        }
        if (vehicle.company.company == "CRY") {
          totalVehicleCRY = totalVehicleCRY + 1;
          if (vehicle.status.status == "Repair") {
            totalRepairCRY = totalRepairCRY + 1;
          }
          if (vehicle.status.status == "Assigned") {
            totalAssignedCRY = totalAssignedCRY + 1;
          }
          if (vehicle.status.status == "Available") {
            totalAvailableCRY = totalAvailableCRY + 1;
          }
        }
        if (vehicle.company.company == "SMI") {
          totalVehicleSMI = totalVehicleSMI + 1;
          if (vehicle.status.status == "Repair") {
            totalRepairSMI = totalRepairSMI + 1;
          }
          if (vehicle.status.status == "Assigned") {
            totalAssignedSMI = totalAssignedSMI + 1;
          }
          if (vehicle.status.status == "Available") {
            totalAvailableSMI = totalAvailableSMI + 1;
          }
        }
        rows.add(
          PlutoRow(
            cells: {
              "id_vehicle": PlutoCell(value: vehicle.idVehicle),
              "image": PlutoCell(value: vehicle.image),
              "make": PlutoCell(value: vehicle.make),
              "model": PlutoCell(value: vehicle.model),
              "year": PlutoCell(value: vehicle.year),
              "vin": PlutoCell(value: vehicle.vin),
              "license_plates": PlutoCell(value: vehicle.licesensePlates),
              "motor": PlutoCell(value: vehicle.motor),
              "color": PlutoCell(value: vehicle.color),
              "status": PlutoCell(value: vehicle.status.status),
              "company": PlutoCell(value: vehicle.company.company),
              "date_added": PlutoCell(value: vehicle.dateAdded)
            },
          ),
        );
      }

      if (stateManager != null) {
        stateManager!.notifyListeners();
      } else {
        notifyListeners();
        return;
      }
    } catch (e) {
      print("erro en: InventoryProvider: getInventory() $e");
    }
  }

  Future<bool> editarPerfilDeEmpleado(String userId) async {
    final res = await supabase
        .from('perfil_usuario')
        .update(
          {
            'perfil_usuario_id': userId,
            'nombre': nombreController.text,
            'apellidos': apellidosController.text,
            'email': correoController.text,
            'telefono': telefonoController.text,
            'id_area_fk': areaTrabajoId,
            'avatar': imageName ??
                'https://xpbhozetzdxldzcbhcei.supabase.co/storage/v1/object/public/avatars/avatar-e42c5bd0-9110-11ed-98e7-3f1db831fd3c.png',
          },
        )
        .eq('perfil_usuario_id', userId)
        .select();

    if (res == null) {
      print(res.error!.message);
      return false;
    }
    return true;
  }

  // void initEditarUsuario(Empleados usuario) {
  //   nombreController.text = usuario.nombre;
  //   apellidosController.text = usuario.apellidos;
  //   correoController.text = usuario.email;
  //   webImage = null;
  //   //TODO: revisar roles e inicializar
  //   isProveedor = false;
  //   isTesoreroLocal = false;
  //   proveedorId = null;
  //   responsableId = null;
  // }
//----------------------------------------------

  void clearControllers() {
    nombreController.clear();
    correoController.clear();
    apellidosController.clear();
    telefonoController.clear();
    extController.clear();
    proveedorController.clear();
    nombreProveedorController.clear();
    cuentaProveedorController.clear();

/*     paisesSeleccionados = []; */
    //rolesSeleccionados = [];
    isProveedor = false;
    isTesoreroLocal = false;

/*     notifyListeners(); */
  }

  void clearImage() {
    webImage = null;
    imageName = null;
/*     notifyListeners(); */
  }

  @override
  void dispose() {
    busquedaController.dispose();
    nombreController.dispose();
    correoController.dispose();
    apellidosController.dispose();
    telefonoController.dispose();
    extController.dispose();
    proveedorController.dispose();
    nombreProveedorController.dispose();
    cuentaProveedorController.dispose();
    super.dispose();
  }
}
