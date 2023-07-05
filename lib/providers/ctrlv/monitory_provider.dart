import 'dart:convert';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:excel/excel.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/functions/date_format.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/monitory.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/issues.dart';
import '../../models/issues_comments.dart';

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

  //int para popUp
  int viewPopup = 0;

  //List<RolApi> roles = [];
  List<String> dropdownMenuItems = [];

  List<Monitory> monitory = [];
  List<Appointment> meet = <Appointment>[];
  //List<Empleados> usuarios = [];
  //List<Empleados> usuariosTesoreros = [];

  //Variables para calendario
  DateTime actualDate = DateTime.now();
  int numCheckOutCRY = 0;
  int numCheckOutODE = 0;
  int numCheckOutSMI = 0;
  int numCheckInCRY = 0;
  int numCheckInODE = 0;
  int numCheckInSMI = 0;

  List<bool> isTaped = [
    false, //numCheckOutCRY   0
    false, //numCheckOutODE   1
    false, //numCheckOutSMI   2
    false, //numCheckInCRY    3
    false, //numCheckInODE    4
    false, //numCheckInSMI    5
  ];

  //variable para las secciones del detail popup
  Issues? issue;
  // Listas R
  List<IssuesComments> bucketInspectionR = [];
  List<IssuesComments> carBodyWorkR = [];
  List<IssuesComments> equipmentR = [];
  List<IssuesComments> extraR = [];
  List<IssuesComments> fluidCheckR = [];
  List<IssuesComments> lightsR = [];
  List<IssuesComments> measureR = [];
  List<IssuesComments> securityR = [];

  // Listas D
  List<IssuesComments> bucketInspectionD = [];
  List<IssuesComments> carBodyWorkD = [];
  List<IssuesComments> equipmentD = [];
  List<IssuesComments> extraD = [];
  List<IssuesComments> fluidCheckD = [];
  List<IssuesComments> lightsD = [];
  List<IssuesComments> measureD = [];
  List<IssuesComments> securityD = [];

  //variables para banderas
  bool bucketInspectR = true;
  late bool bucketInspectD;
  late bool carBodyInspectR;
  late bool carBodyInspectD;
  late bool equipmentInspectR;
  late bool equipmentInspectD;
  late bool extraInspectR;
  late bool extraInspectD;
  late bool fluidCheckInspectR;
  late bool fluidCheckInspectD;
  late bool ligthsInspectR;
  late bool ligthsInspectD;
  late bool measureInspectR;
  late bool measureInspectD;
  late bool securityInspectR;
  late bool securityInspectD;

  //IssuesCommentsActual
  List<IssuesComments> actualIssuesComments = [];

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

  CalendarController calendarController = CalendarController();
  List<Monitory> idEventos = [];
  String selectedDay = DateFormat("MMM-dd-yyyy").format(DateTime.now());
  String selectedMonth = DateFormat("MMMM").format(DateTime.now());
  int current = 0;

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
      final res = await supabaseCtrlV.from('monitory_view').select();

      monitory = (res as List<dynamic>)
          .map((monitory) => Monitory.fromJson(jsonEncode(monitory)))
          .toList();

      rows.clear();

      for (Monitory monitory in monitory) {
        rows.add(
          PlutoRow(
            cells: {
              // "id_control_form": PlutoCell(value: monitory.idControlForm),
              // "id_vehicle": PlutoCell(value: monitory.idVehicle),
              // "date_added": PlutoCell(value: DateFormat("MMM-dd-yyyy").format(monitory.dateAdded)),
              "employee": PlutoCell(value: monitory.employee.name),
              "vin": PlutoCell(value: monitory.vin),
              "license_plates": PlutoCell(value: monitory.licensePlates),
              "company": PlutoCell(value: monitory.company.company),
              "check_out": PlutoCell(
                  value: DateFormat("MMM-dd-yyyy hh:mm:ss")
                      .format(monitory.dateAddedR)),
              "check_in": PlutoCell(
                  value: monitory.dateAddedD == null
                      ? 'N/A'
                      : DateFormat("MMM-dd-yyyy hh:mm:ss")
                          .format(monitory.dateAddedD!)),
              "status": PlutoCell(value: monitory.vehicle.status.status),
              // "mileage": PlutoCell(value: monitory.mileage),
              "details": PlutoCell(value: monitory),
              //"vehicle": PlutoCell(value: monitory.vehicle),
            },
          ),
        );
      }

      getAppointments();

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

  // int getNumAppoint(int index, Appointment event) {
  //   if(event.startTime.day == selected)
  //   switch (index) {
  //     case 1:
  //       break;
  //       case 2:
  //       break;
  //       case 3:
  //       break;
  //       case 4:
  //       break;
  //       case 5:
  //       break;
  //       case 6:
  //       break;
  //     default:
  //   }
  // }

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
    cell4.value = "Status";
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
    cell10.value = "Check In";
    cell10.cellStyle = cellStyle;

    var cell11 = sheet.cell(CellIndex.indexByString("K3"));
    cell11.value = "Check Out";
    cell11.cellStyle = cellStyle;

    //Agregar datos
    for (var vehicle in monitory) {
      final List<dynamic> row = [
        vehicle.idControlForm,
        vehicle.idVehicle,
        "${vehicle.employee.name} ${vehicle.employee.lastName}",
        vehicle.vehicle.status.status,
        vehicle.vin,
        vehicle.licensePlates,
        vehicle.company.company,
        vehicle.gasR,
        vehicle.mileageR,
        DateFormat("MMM-dd-yyyy").format(vehicle.dateAddedR),
        vehicle.dateAddedD != null
            ? DateFormat("MMM-dd-yyyy").format(vehicle.dateAddedD!)
            : "NA",
      ];
      sheet.appendRow(row);
    }

    //Descargar
    final List<int>? fileBytes = excel.save(fileName: "Vehicle_Status.xlsx");
    if (fileBytes == null) return false;

    return true;
  }

  void updateViewPopup(int value) {
    viewPopup = value;
    notifyListeners();
  }

  void initializeViewPopup() {
    viewPopup = 0;
    notifyListeners();
  }

  bool cambiodeVista = true;
  void cambioVista() {
    cambiodeVista = !cambiodeVista;
    notifyListeners();
  }

  void updateActualDate(DateTime selectedDate) {
    actualDate = selectedDate;
    notifyListeners();
  }



  bool getAppointmentsByDate() {
    // meet.clear();
    idEventos.clear();
    numCheckOutCRY = 0;
    numCheckOutODE = 0;
    numCheckOutSMI = 0;
    numCheckInCRY = 0;
    numCheckInODE = 0;
    numCheckInSMI = 0;

    for (Monitory event in monitory) {
      //si hay final
      if (event.dateAddedD != null) {
        switch (event.company.company) {
          case "CRY":
            if ((calendarController.selectedDate!.day == event.dateAddedR.day) &
                (calendarController.selectedDate!.month == event.dateAddedR.month) &
                (calendarController.selectedDate!.year == event.dateAddedR.year)) {
              
              // idEventos.add(event);
              numCheckOutCRY += 1;
            }
            if ((calendarController.selectedDate!.day == event.dateAddedD!.day) &
                (calendarController.selectedDate!.month == event.dateAddedD!.month) &
                (calendarController.selectedDate!.year == event.dateAddedD!.year)) {
                  idEventos.add(event);
                  numCheckOutCRY -= 1;
              numCheckInCRY += 1;
            }
            continue;
          case "ODE":
            if ((calendarController.selectedDate!.day == event.dateAddedR.day) &
                (calendarController.selectedDate!.month == event.dateAddedR.month) &
                (calendarController.selectedDate!.year == event.dateAddedR.year)) {
                  // idEventos.add(event);
              numCheckOutODE += 1;
            }

            if ((calendarController.selectedDate!.day == event.dateAddedD!.day) &
                (calendarController.selectedDate!.month == event.dateAddedD!.month) &
                (calendarController.selectedDate!.year == event.dateAddedD!.year)) {
                  idEventos.add(event);
                  numCheckOutODE -= 1;
              numCheckInODE += 1;
            }
            continue;
          case "SMI":
            if ((calendarController.selectedDate!.day == event.dateAddedR.day) &
                (calendarController.selectedDate!.month == event.dateAddedR.month) &
                (calendarController.selectedDate!.year == event.dateAddedR.year)) {
                  // idEventos.add(event);
              numCheckOutSMI += 1;
            }

            if ((calendarController.selectedDate!.day == event.dateAddedD!.day) &
                (calendarController.selectedDate!.month == event.dateAddedD!.month) &
                (calendarController.selectedDate!.year == event.dateAddedD!.year)) {
                  idEventos.add(event);
                  numCheckOutSMI -= 1;
              numCheckInSMI += 1;
            }
            continue;
          default:
        }
      }
      //no hay final
      else {
        switch (event.company.company) {
          case "CRY":
            if ((calendarController.selectedDate!.day == event.dateAddedR.day) &
                (calendarController.selectedDate!.month == event.dateAddedR.month) &
                (calendarController.selectedDate!.year == event.dateAddedR.year)) {
                  idEventos.add(event);
              numCheckOutCRY += 1;
            }
            continue;
          case "ODE":
            if ((calendarController.selectedDate!.day == event.dateAddedR.day) &
                (calendarController.selectedDate!.month == event.dateAddedR.month) &
                (calendarController.selectedDate!.year == event.dateAddedR.year)) {
                  idEventos.add(event);
              numCheckOutODE += 1;
            }
            continue;
          case "SMI":
            if ((calendarController.selectedDate!.day == event.dateAddedR.day) &
                (calendarController.selectedDate!.month == event.dateAddedR.month) &
                (calendarController.selectedDate!.year == event.dateAddedR.year)) {
                  idEventos.add(event);
              numCheckOutSMI += 1;
            }
            continue;
          default:
        }
      }
    }
    notifyListeners();
    return true;
  }

  bool getAppointments() {
    final today = DateTime.now();
    meet.clear();
    numCheckOutCRY = 0;
    numCheckOutODE = 0;
    numCheckOutSMI = 0;
    numCheckInCRY = 0;
    numCheckInODE = 0;
    numCheckInSMI = 0;

    for (Monitory event in monitory) {
      //si hay final
      if (event.dateAddedD != null) {
        switch (event.company.company) {
          case "CRY":
            meet.add(Appointment(
              startTime: event.dateAddedR,
              endTime: event.dateAddedR.add(const Duration(hours: 1)),
              subject: "${event.employee.name} ${event.employee.lastName}",
              color: const Color(0XFF345694),
              id: event.idControlForm,
              // recurrenceRule: 'FREQ=DAILY;COUNT=10',
              // isAllDay: true,
            ));
            if ((today.day == event.dateAddedR.day) &
                (today.month == event.dateAddedR.month) &
                (today.year == event.dateAddedR.year)) {
              numCheckOutCRY += 1;
            }

            meet.add(Appointment(
              startTime: event.dateAddedD!.add(const Duration(hours: -1)),
              endTime: event.dateAddedD!,
              subject: "${event.employee.name} ${event.employee.lastName}",
              color: const Color(0XFF345694),
              id: event.idControlForm,
              // recurrenceRule: 'FREQ=DAILY;COUNT=10',
              // isAllDay: true,
            ));
            if ((today.day == event.dateAddedD!.day) &
                (today.month == event.dateAddedD!.month) &
                (today.year == event.dateAddedD!.year)) {
              numCheckInCRY += 1;
            }
            break;
          case "ODE":
            meet.add(Appointment(
              startTime: event.dateAddedR,
              endTime: event.dateAddedR.add(const Duration(hours: 1)),
              subject: "${event.employee.name} ${event.employee.lastName} R",
              color: const Color(0XFFB2333A),
              id: event.idControlForm,
            ));
            if ((today.day == event.dateAddedR.day) &
                (today.month == event.dateAddedR.month) &
                (today.year == event.dateAddedR.year)) {
              numCheckOutODE += 1;
            }
            meet.add(Appointment(
              startTime: event.dateAddedD!.add(const Duration(hours: -1)),
              endTime: event.dateAddedD!,
              subject: "${event.employee.name} ${event.employee.lastName} D",
              color: const Color(0XFFB2333A),
              id: event.idControlForm,
            ));
            if ((today.day == event.dateAddedD!.day) &
                (today.month == event.dateAddedD!.month) &
                (today.year == event.dateAddedD!.year)) {
              numCheckInODE += 1;
            }
            break;
          case "SMI":
            meet.add(Appointment(
              startTime: event.dateAddedR,
              endTime: event.dateAddedR.add(const Duration(hours: 1)),
              subject: "${event.employee.name} ${event.employee.lastName}",
              color: Color.fromRGBO(255, 138, 0, 1),
              id: event.idControlForm,
            ));
            if ((today.day == event.dateAddedR.day) &
                (today.month == event.dateAddedR.month) &
                (today.year == event.dateAddedR.year)) {
              numCheckOutSMI += 1;
            }

            meet.add(Appointment(
              startTime: event.dateAddedD!.add(const Duration(hours: -1)),
              endTime: event.dateAddedD!,
              subject: "${event.employee.name} ${event.employee.lastName}",
              color: Color.fromRGBO(255, 138, 0, 1),
              id: event.idControlForm,
            ));
            if ((today.day == event.dateAddedD!.day) &
                (today.month == event.dateAddedD!.month) &
                (today.year == event.dateAddedD!.year)) {
              numCheckInSMI += 1;
            }
            break;
          default:
        }
      }
      //no hay final
      else {
        switch (event.company.company) {
          case "CRY":
            meet.add(Appointment(
              startTime: event.dateAddedR,
              endTime: event.dateAddedR.add(const Duration(hours: 1)),
              subject: "${event.employee.name} ${event.employee.lastName}",
              color: const Color(0XFF345694),
              id: event.idControlForm,
              // recurrenceRule: 'FREQ=DAILY;COUNT=10',
              // isAllDay: true,
            ));
            if ((today.day == event.dateAddedR.day) &
                (today.month == event.dateAddedR.month) &
                (today.year == event.dateAddedR.year)) {
              numCheckOutCRY += 1;
            }
            break;
          case "ODE":
            meet.add(Appointment(
              startTime: event.dateAddedR,
              endTime: event.dateAddedR.add(const Duration(hours: 1)),
              subject: "${event.employee.name} ${event.employee.lastName} R",
              color: const Color(0XFFB2333A),
              id: event.idControlForm,
            ));
            if ((today.day == event.dateAddedR.day) &
                (today.month == event.dateAddedR.month) &
                (today.year == event.dateAddedR.year)) {
              numCheckOutODE += 1;
            }
            break;
          case "SMI":
            meet.add(Appointment(
              startTime: event.dateAddedR,
              endTime: event.dateAddedR.add(const Duration(hours: 1)),
              subject: "${event.employee.name} ${event.employee.lastName}",
              color: Color.fromRGBO(255, 138, 0, 1),
              id: event.idControlForm,
            ));

            if ((today.day == event.dateAddedR.day) &
                (today.month == event.dateAddedR.month) &
                (today.year == event.dateAddedR.year)) {
              numCheckOutSMI += 1;
            }
            break;
          default:
        }
      }
    }
    notifyListeners();
    return true;
  }

  void getActualIssuesComments(List<IssuesComments> issuesComments) {
    actualIssuesComments = issuesComments;
    notifyListeners();
  }

  Future<bool> getIssues(Monitory monitory) async {
    // Limpiar listas
    issue = null;
    bucketInspectR = true;
    bucketInspectD = true;
    carBodyInspectR = true;
    carBodyInspectD = true;
    equipmentInspectR = true;
    equipmentInspectD = true;
    extraInspectR = true;
    extraInspectD = true;
    fluidCheckInspectR = true;
    fluidCheckInspectD = true;
    ligthsInspectR = true;
    ligthsInspectD = true;
    measureInspectR = true;
    measureInspectD = true;
    securityInspectR = true;
    securityInspectD = true;

    bucketInspectionR.clear();
    bucketInspectionD.clear();
    carBodyWorkR.clear();
    carBodyWorkD.clear();
    equipmentR.clear();
    equipmentD.clear();
    extraR.clear();
    extraD.clear();
    fluidCheckR.clear();
    fluidCheckD.clear();
    lightsR.clear();
    lightsD.clear();
    measureR.clear();
    measureD.clear();
    securityR.clear();
    securityD.clear();

    try {
      final res = await supabaseCtrlV
          .from('issues_view')
          .select()
          .eq('id_control_form', monitory.idControlForm);
      if (res != null) {
        final listData = res as List<dynamic>;
        issue = Issues.fromJson(jsonEncode(listData[0]));

        //Repetir esto con todas las listas
        issue!.bucketInspectionR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            bucketInspectR = false;
            String nameIssue = key;
            String? comments =
                issue!.bucketInspectionR.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.bucketInspectionR
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.bucketInspectionR.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            bucketInspectionR.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments =
                issue!.bucketInspectionR.toMap()["${nameIssue}_comments"];
            if (issue!.bucketInspectionR.toMap()["${nameIssue}_image"] !=
                null) {
              List<String> listImage = issue!.bucketInspectionR
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded = DateTime.parse(
                  issue!.bucketInspectionR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              bucketInspectionR.add(newIssuesComments);
            } else {
              DateTime dateAdded = DateTime.parse(
                  issue!.bucketInspectionR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              bucketInspectionR.add(newIssuesComments);
            }
          }
        });
        //Bucket delivered llamada a su lista
        issue!.bucketInspectionD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            bucketInspectD = false;
            String nameIssue = key;
            String? comments =
                issue!.bucketInspectionD.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.bucketInspectionD
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.bucketInspectionD.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            bucketInspectionD.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments =
                issue!.bucketInspectionD.toMap()["${nameIssue}_comments"];
            if (issue!.bucketInspectionD.toMap()["${nameIssue}_image"] !=
                null) {
              List<String> listImage = issue!.bucketInspectionD
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded = DateTime.parse(
                  issue!.bucketInspectionD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              bucketInspectionD.add(newIssuesComments);
            } else {
              DateTime dateAdded = DateTime.parse(
                  issue!.bucketInspectionD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              bucketInspectionD.add(newIssuesComments);
            }
          }
        });

        //Car BodyWork R
        issue!.carBodyworkR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            carBodyInspectR = false;
            String nameIssue = key;
            String? comments =
                issue!.carBodyworkR.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.carBodyworkR
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.carBodyworkR.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            carBodyWorkR.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments =
                issue!.carBodyworkR.toMap()["${nameIssue}_comments"];
            if (issue!.carBodyworkR.toMap()["${nameIssue}_image"] != null) {
              List<String> listImage = issue!.carBodyworkR
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded =
                  DateTime.parse(issue!.carBodyworkR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              carBodyWorkR.add(newIssuesComments);
            } else {
              DateTime dateAdded =
                  DateTime.parse(issue!.carBodyworkR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              carBodyWorkR.add(newIssuesComments);
            }
          }
        });

        //Car BodyWork D
        issue!.carBodyworkD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            carBodyInspectD = false;
            String nameIssue = key;
            String? comments =
                issue!.carBodyworkD.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.carBodyworkD
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.carBodyworkD.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            carBodyWorkD.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments =
                issue!.carBodyworkD.toMap()["${nameIssue}_comments"];
            if (issue!.carBodyworkD.toMap()["${nameIssue}_image"] != null) {
              List<String> listImage = issue!.carBodyworkD
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded =
                  DateTime.parse(issue!.carBodyworkD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              carBodyWorkD.add(newIssuesComments);
            } else {
              DateTime dateAdded =
                  DateTime.parse(issue!.carBodyworkD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              carBodyWorkD.add(newIssuesComments);
            }
          }
        });

        // Equipment R
        issue!.equimentR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            equipmentInspectR = false;
            String nameIssue = key;
            String? comments =
                issue!.equimentR.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.equimentR
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.equimentR.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            equipmentR.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments =
                issue!.equimentR.toMap()["${nameIssue}_comments"];
            if (issue!.equimentR.toMap()["${nameIssue}_image"] != null) {
              List<String> listImage = issue!.equimentR
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded =
                  DateTime.parse(issue!.equimentR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              equipmentR.add(newIssuesComments);
            } else {
              DateTime dateAdded =
                  DateTime.parse(issue!.equimentR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              equipmentR.add(newIssuesComments);
            }
          }
        });

        //Equipment R
        issue!.equimentD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            equipmentInspectD = false;
            String nameIssue = key;
            String? comments =
                issue!.equimentD.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.equimentD
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.equimentD.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            equipmentD.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments =
                issue!.equimentD.toMap()["${nameIssue}_comments"];
            if (issue!.equimentD.toMap()["${nameIssue}_image"] != null) {
              List<String> listImage = issue!.equimentD
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded =
                  DateTime.parse(issue!.equimentD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              equipmentD.add(newIssuesComments);
            } else {
              DateTime dateAdded =
                  DateTime.parse(issue!.equimentD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              equipmentD.add(newIssuesComments);
            }
          }
        });

        //Extra R
        issue!.extraR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            extraInspectR = false;
            String nameIssue = key;
            String? comments = issue!.extraR.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.extraR
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.extraR.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            extraR.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments = issue!.extraR.toMap()["${nameIssue}_comments"];
            if (issue!.extraR.toMap()["${nameIssue}_image"] != null) {
              List<String> listImage = issue!.extraR
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded =
                  DateTime.parse(issue!.extraR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              extraR.add(newIssuesComments);
            } else {
              DateTime dateAdded =
                  DateTime.parse(issue!.extraR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              extraR.add(newIssuesComments);
            }
          }
        });

        //Extra D
        issue!.extraD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            extraInspectD = false;
            String nameIssue = key;
            String? comments = issue!.extraD.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.extraD
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.extraD.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            extraD.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments = issue!.extraD.toMap()["${nameIssue}_comments"];
            if (issue!.extraD.toMap()["${nameIssue}_image"] != null) {
              List<String> listImage = issue!.extraD
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded =
                  DateTime.parse(issue!.extraD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              extraD.add(newIssuesComments);
            } else {
              DateTime dateAdded =
                  DateTime.parse(issue!.extraD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              extraD.add(newIssuesComments);
            }
          }
        });

        //Fluid Check R
        issue!.fluidCheckR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            fluidCheckInspectR = false;
            String nameIssue = key;
            String? comments =
                issue!.fluidCheckR.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.fluidCheckR
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.fluidCheckR.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            fluidCheckR.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments =
                issue!.fluidCheckR.toMap()["${nameIssue}_comments"];
            if (issue!.fluidCheckR.toMap()["${nameIssue}_image"] != null) {
              List<String> listImage = issue!.fluidCheckR
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded =
                  DateTime.parse(issue!.fluidCheckR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              fluidCheckR.add(newIssuesComments);
            } else {
              DateTime dateAdded =
                  DateTime.parse(issue!.fluidCheckR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              fluidCheckR.add(newIssuesComments);
            }
          }
        });

        //Fluid Check D
        issue!.fluidCheckD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            fluidCheckInspectD = false;
            String nameIssue = key;
            String? comments =
                issue!.fluidCheckD.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.fluidCheckD
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.fluidCheckD.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            fluidCheckD.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments =
                issue!.fluidCheckD.toMap()["${nameIssue}_comments"];
            if (issue!.fluidCheckD.toMap()["${nameIssue}_image"] != null) {
              List<String> listImage = issue!.fluidCheckD
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded =
                  DateTime.parse(issue!.fluidCheckD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              fluidCheckD.add(newIssuesComments);
            } else {
              DateTime dateAdded =
                  DateTime.parse(issue!.fluidCheckD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              fluidCheckD.add(newIssuesComments);
            }
          }
        });

        //Lights R
        issue!.lightsR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            ligthsInspectR = false;
            String nameIssue = key;
            String? comments = issue!.lightsR.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.lightsR
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.lightsR.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            lightsR.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments = issue!.lightsR.toMap()["${nameIssue}_comments"];
            if (issue!.lightsR.toMap()["${nameIssue}_image"] != null) {
              List<String> listImage = issue!.lightsR
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded =
                  DateTime.parse(issue!.lightsR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              lightsR.add(newIssuesComments);
            } else {
              DateTime dateAdded =
                  DateTime.parse(issue!.lightsR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              lightsR.add(newIssuesComments);
            }
          }
        });

        //Lights D
        issue!.lightsD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            ligthsInspectD = false;
            String nameIssue = key;
            String? comments = issue!.lightsD.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.lightsD
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.lightsD.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            lightsD.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments = issue!.lightsD.toMap()["${nameIssue}_comments"];
            if (issue!.lightsD.toMap()["${nameIssue}_image"] != null) {
              List<String> listImage = issue!.lightsD
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded =
                  DateTime.parse(issue!.lightsD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              lightsD.add(newIssuesComments);
            } else {
              DateTime dateAdded =
                  DateTime.parse(issue!.lightsD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              lightsD.add(newIssuesComments);
            }
          }
        });

        //Measure R
        issue!.measureR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            measureInspectR = false;
            String nameIssue = key;
            String? comments = issue!.measureR.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.measureR
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.measureR.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            measureR.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments = issue!.measureR.toMap()["${nameIssue}_comments"];
            if (issue!.measureR.toMap()["${nameIssue}_image"] != null) {
              List<String> listImage = issue!.measureR
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded =
                  DateTime.parse(issue!.measureR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              measureR.add(newIssuesComments);
            } else {
              DateTime dateAdded =
                  DateTime.parse(issue!.measureR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              measureR.add(newIssuesComments);
            }
          }
        });

        //Measure D
        issue!.measureD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            measureInspectD = false;
            String nameIssue = key;
            String? comments = issue!.measureD.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.measureD
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.measureD.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            measureD.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments = issue!.measureD.toMap()["${nameIssue}_comments"];
            if (issue!.measureD.toMap()["${nameIssue}_image"] != null) {
              List<String> listImage = issue!.measureD
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded =
                  DateTime.parse(issue!.measureD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              measureD.add(newIssuesComments);
            } else {
              DateTime dateAdded =
                  DateTime.parse(issue!.measureD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              measureD.add(newIssuesComments);
            }
          }
        });

        //Security R
        issue!.securityR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            securityInspectR = false;
            String nameIssue = key;
            String? comments =
                issue!.securityR.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.securityR
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.securityR.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            securityR.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments =
                issue!.securityR.toMap()["${nameIssue}_comments"];
            if (issue!.securityR.toMap()["${nameIssue}_image"] != null) {
              List<String> listImage = issue!.securityR
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded =
                  DateTime.parse(issue!.securityR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              securityR.add(newIssuesComments);
            } else {
              DateTime dateAdded =
                  DateTime.parse(issue!.securityR.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              securityR.add(newIssuesComments);
            }
          }
        });

        //Security D
        issue!.securityD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            securityInspectD = false;
            String nameIssue = key;
            String? comments =
                issue!.securityD.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue!.securityD
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue!.securityD.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            securityD.add(newIssuesComments);
          }
          if (value == 'Good' && !(key.contains("_comments"))) {
            String nameIssue = key;
            String? comments =
                issue!.securityD.toMap()["${nameIssue}_comments"];
            if (issue!.securityD.toMap()["${nameIssue}_image"] != null) {
              List<String> listImage = issue!.securityD
                  .toMap()["${nameIssue}_image"]
                  .toString()
                  .split('|');

              DateTime dateAdded =
                  DateTime.parse(issue!.securityD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: listImage,
                  dateAdded: dateAdded,
                  status: true);
              securityD.add(newIssuesComments);
            } else {
              DateTime dateAdded =
                  DateTime.parse(issue!.securityD.toMap()["date_added"]);
              IssuesComments newIssuesComments = IssuesComments(
                  nameIssue: nameIssue,
                  comments: comments,
                  listImages: null,
                  dateAdded: dateAdded,
                  status: true);
              securityD.add(newIssuesComments);
            }
          }
        });
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("error ${e}");
      return false;
    }
  }

  void getWeekDay(){

    switch(calendarController.selectedDate?.weekday){
      case 1:
        selectedDay = "Monday";
        break;
      case 2:
        selectedDay = "Tuesday";
        break;
      case 3:
        selectedDay = "Wednesday";
        break;
      case 4:
        selectedDay = "Thrusday";
        break;
      case 5:
        selectedDay = "Friday";
        break;
      case 6:
        selectedDay = "Saturday";
        break;
      case 7:
        selectedDay = "Sunday";
        break;

    }
  }
  void getMonth(){

    switch(calendarController.selectedDate?.month){
      case 1:
        selectedMonth = "Jan";
        break;
      case 2:
        selectedMonth = "Feb";
        break;
      case 3:
        selectedMonth = "Mar";
        break;
      case 4:
        selectedMonth = "Apr";
        break;
      case 5:
        selectedMonth = "May";
        break;
      case 6:
        selectedMonth = "Jun";
        break;
      case 7:
        selectedMonth = "Jul";
        break;
      case 8:
        selectedMonth = "Aug";
        break;
      case 9:
        selectedMonth = "Sep";
        break;
      case 10:
        selectedMonth = "Oct";
        break;
      case 11:
        selectedMonth = "Nov";
        break;
      case 12:
        selectedMonth = "Dec";
        break;

    }
  }
}
