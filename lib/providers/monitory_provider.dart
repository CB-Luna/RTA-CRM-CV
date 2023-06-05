import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:excel/excel.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../functions/date_format.dart';
import '../helpers/globals.dart';
import '../models/monitory.dart';

class MonitoryProvider extends ChangeNotifier {
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

  List<Monitory> monitory = [];
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

  MonitoryProvider() {
    getMonitory();
    filasController = TextEditingController(text: countF.toString());
  }

//---------------------------------------------
  Future<void> setSeccionActual(int value) async {
    seccionActual = value;
    await getMonitory();
  }

  updaterolParaRegistro(int valor, String header) {
    rolParaRegistro = valor;
    headerText = header;
    /*  notifyListeners(); */
    clearControllers();
    return;
  }

  Future<void> getMonitory() async {
    try {
      final res = await supabase.from('monitory_view').select();

      monitory = (res as List<dynamic>)
          .map((monitory) => Monitory.fromJson(jsonEncode(monitory)))
          .toList();

      rows.clear();

      for (Monitory monitory in monitory) {
        rows.add(
          PlutoRow(
            cells: {
              "id_control_form": PlutoCell(value: monitory.idControlForm),
              "id_vehicle": PlutoCell(value: monitory.idVehicle),
              "date_added": PlutoCell(value: monitory.dateAdded),
              "employee": PlutoCell(value: monitory.employee.name),
              "typeForm": PlutoCell(value: monitory.typeForm),
              "vin": PlutoCell(value: monitory.vin),
              "license_plates": PlutoCell(value: monitory.licesensePlates),
              "company": PlutoCell(value: monitory.company.company),
              "gas": PlutoCell(value: monitory.gas),
              "mileage": PlutoCell(value: monitory.mileage),
              "details": PlutoCell(value: monitory),
              //"vehicle": PlutoCell(value: monitory.vehicle),
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
      print("erro en: MonitoryProvider: getMonitory() $e");
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
  /*
  void initEditarUsuario(Empleados usuario) {
    nombreController.text = usuario.nombre;
    apellidosController.text = usuario.apellidos;
    correoController.text = usuario.email;
    webImage = null;
    //TODO: revisar roles e inicializar
    isProveedor = false;
    isTesoreroLocal = false;
    proveedorId = null;
    responsableId = null;
  }
  */
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

  Future<bool> excelActivityReports() async {
    //Crear excel
    var excel = Excel.createExcel();
    Sheet? sheet = excel.sheets[excel.getDefaultSheet()];

    if (sheet == null) return false;


    CellStyle titulo = CellStyle(
      fontFamily: getFontFamily(FontFamily.Calibri),
      fontSize: 16,
      bold: true,
      horizontalAlign: HorizontalAlign.Center,
      verticalAlign: VerticalAlign.Center,
    );
    //Agregar primera linea
    //mas grande y en bold
    // sheet.appendRow([
    //   'Títle',
    //   'Monitory Reports',
    //   '',
    //   'Fecha',
    //   dateFormat(DateTime.now()),
    // ]);
    var cellT = sheet.cell(CellIndex.indexByString("A1"));
    cellT.value = "Title";
    cellT.cellStyle = titulo;

    var cellT2 = sheet.cell(CellIndex.indexByString("B1"));
    cellT2.value = "Monitory Reports";
    cellT2.cellStyle = titulo;

    var cellD = sheet.cell(CellIndex.indexByString("D1"));
    cellD.value = "Date";
    cellD.cellStyle = titulo;

    var cellD2 = sheet.cell(CellIndex.indexByString("E1"));
    cellD2.value = dateFormat(DateTime.now());
    cellD2.cellStyle = titulo;
    //Agregar linea vacia
    sheet.appendRow(['']);


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
    cell.value = "Id Control Form";
    cell.cellStyle = cellStyle;

    var cell2 = sheet.cell(CellIndex.indexByString("B3"));
    cell2.value = "Id Vehicle";
    cell2.cellStyle = cellStyle;

    var cell3 = sheet.cell(CellIndex.indexByString("C3"));
    cell3.value = "Employee";
    cell3.cellStyle = cellStyle;

    var cell4 = sheet.cell(CellIndex.indexByString("D3"));
    cell4.value = "Type Form";
    cell4.cellStyle = cellStyle;

    var cell5 = sheet.cell(CellIndex.indexByString("E3"));
    cell5.value = "VIN";
    cell5.cellStyle = cellStyle;

    var cell6 = sheet.cell(CellIndex.indexByString("F3"));
    cell6.value = "License Plates";
    cell6.cellStyle = cellStyle;

    var cell7 = sheet.cell(CellIndex.indexByString("G3"));
    cell7.value = "Company";
    cell7.cellStyle = cellStyle;

    var cell8 = sheet.cell(CellIndex.indexByString("H3"));
    cell8.value = "Gas";
    cell8.cellStyle = cellStyle;

    var cell9 = sheet.cell(CellIndex.indexByString("I3"));
    cell9.value = "Mileage";
    cell9.cellStyle = cellStyle;

    var cell10 = sheet.cell(CellIndex.indexByString("J3"));
    cell10.value = "Date Added";
    cell10.cellStyle = cellStyle;
    //Agregar headers
    // sheet.appendRow([
    //   'Id Control Form',
    //   'Id Vehicle',
    //   'Employee',
    //   'Type Form',
    //   'VIN',
    //   'License Plates',
    //   'Company',
    //   'Gas',
    //   'Mileage',
    //   'Date Added',
    // ]);

    //Agregar datos
    for (var vehicle in monitory) {
      final List<dynamic> row = [
        vehicle.idControlForm,
        vehicle.idVehicle,
        vehicle.employee.name,
        vehicle.typeForm.toString(),
        vehicle.vin,
        vehicle.licesensePlates,
        vehicle.company.company,
        vehicle.gas,
        vehicle.mileage,
        DateFormat("MMM-dd-yyyy").format(vehicle.dateAdded),
      ];
      sheet.appendRow(row);
    }

    //Descargar
    final List<int>? fileBytes =
        excel.save(fileName: "Monitory_Followup.xlsx");
    if (fileBytes == null) return false;

    return true;
  }
}
