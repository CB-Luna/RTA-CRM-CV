import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/company_api.dart';
import 'package:rta_crm_cv/models/issues_comments.dart';
import 'package:rta_crm_cv/models/status_api.dart';
import 'package:rta_crm_cv/models/vehicle.dart';
import 'package:excel/excel.dart';

import '../../models/issues.dart';
import '../../models/issues_x_user.dart';
import '../../models/user.dart';

class InventoryProvider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];

  //------------------------------------------
  //Alta Inventario
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController vinController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController motorController = TextEditingController();
  int colorController = 0xffffffff;
  TextEditingController dateTimeControllerOil = TextEditingController();
  TextEditingController dateTimeControllerRFC = TextEditingController();
  TextEditingController dateTimeControllerLTFC = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  //TextEditingController statusController = TextEditingController();
//------------------------------------------
  //Update Inventario
  TextEditingController makeControllerUpdate = TextEditingController();
  TextEditingController modelControllerUpdate = TextEditingController();
  TextEditingController vinControllerUpdate = TextEditingController();
  TextEditingController plateNumberControllerUpdate = TextEditingController();
  TextEditingController motorControllerUpadte = TextEditingController();
  int colorControllerUpdate = 0xffffffff;
  TextEditingController dateTimeControllerOilUpdate = TextEditingController();
  TextEditingController dateTimeControllerRFCUpadte = TextEditingController();
  TextEditingController dateTimeControllerLTFCUpadte = TextEditingController();
  TextEditingController searchControllerUpadte = TextEditingController();
  TextEditingController yearControllerUpdate = TextEditingController();
  TextEditingController colorControllers = TextEditingController();
  //------------------------------------------

  //TextEditingController statusControllerUpadte = TextEditingController();
  Future<void> updateState() async {
    rows.clear();
    await getInventory();
  }
//------------------------------------------

  String? imageName;
  String? imageBase64;
  String? imageBase64Update;
  Uint8List? webImage;
  Uint8List? webImageClear;
  int idvehicle = 15;
  String? colorString = "0xffffffff";
//------------------------------------------

  //List<RolApi> roles = [];
  List<String> dropdownMenuItems = [];
  StatusApi? statusSelected;
  CompanyApi? companySelected;
  StatusApi? statusSelectedUpdate;
  CompanyApi? companySelectedUpdate;
//------------------------------------------

  // Lista de Modelos
  List<CompanyApi> company = [];
  List<StatusApi> status = [];
  List<Vehicle> vehicles = [];
  List<Issues> issues = [];
  List<IssuesXUser> issuesxUser = [];
//------------------------------------------

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
//------------------------------------------

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

//------------------------------------------
  // Variables para el Control de Issues
  bool vistaIssues = true;
  void cambioVistaIssues() {
    vistaIssues = !vistaIssues;
    notifyListeners();
  }

//------------------------------------------
  // Variables para el Control de photos and comments
  bool vistaPhotosComments = true;
  void cambiosVistaPhotosComments() {
    vistaPhotosComments = !vistaPhotosComments;
    notifyListeners();
  }
//------------------------------------------

  // void selectCompany(String state) {
  //   companySelected = companyApi.firstWhere((elem) => elem.company == company);
  //   notifyListeners();
  // }

  //----------------------------------------------Paginador variables

  InventoryProvider() {
    getInventory();
  }
  //----------------------------------------------

  void updateInventoryControllers(Vehicle vehicle) {
    makeControllerUpdate.text = vehicle.make;
    modelControllerUpdate.text = vehicle.model;
    vinControllerUpdate.text = vehicle.vin;
    plateNumberControllerUpdate.text = vehicle.licesensePlates;
    motorControllerUpadte.text = vehicle.motor;
    yearControllerUpdate.text = vehicle.year.toString();
    statusSelectedUpdate = statusSelected;
    colorControllerUpdate = colorController;
    colorControllers.text = colorController.toString();
    companySelectedUpdate = companySelected;
    dateTimeControllerOilUpdate.text =
        DateFormat("MMM/dd/yyyy").format(vehicle.oilChangeDue);
    dateTimeControllerRFCUpadte.text =
        DateFormat("MMM/dd/yyyy").format(vehicle.lastRadiatorFluidChange);
    dateTimeControllerLTFCUpadte.text =
        DateFormat("MMM/dd/yyyy").format(vehicle.lastTransmissionFluidChange);
  }
//---------------------------------------------

  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) return;

    // final String fileExtension = p.extension(pickedImage.name);
    // const uuid = Uuid();
    // final String fileName = uuid.v1();
    // imageName = 'car-$fileName$fileExtension';

    webImage = await pickedImage.readAsBytes();
    imageBase64 = base64Encode(webImage!);
    imageBase64Update = imageBase64;
    print("-------------------------");

    print(imageBase64);
    print("-------------------------");
    print(imageBase64Update);
    notifyListeners();
  }

//---------------------------------------------

//---------------------------------------------

//---------------------------------------------

  Future<void> getCompanies({bool notify = true}) async {
    final res = await supabase.from('company').select().order(
          'company',
          ascending: true,
        );

    company = (res as List<dynamic>)
        .map((companys) => CompanyApi.fromJson(jsonEncode(companys)))
        .toList();

    if (notify) notifyListeners();
  }

  Future<void> getStatus({bool notify = true}) async {
    final res = await supabaseCtrlV.from('status').select().order(
          'status',
          ascending: true,
        );

    status = (res as List<dynamic>)
        .map((statu) => StatusApi.fromJson(jsonEncode(statu)))
        .toList();

    if (notify) notifyListeners();
  }
//---------------------------------------------

  void selectCompany(String companys) {
    companySelected = company.firstWhere((elem) => elem.company == companys);
    notifyListeners();
  }

  void selectStatu(String statu) {
    statusSelected = status.firstWhere((elem) => elem.status == statu);
    notifyListeners();
  }

  void selectCompanyUpdate(String companys) {
    companySelectedUpdate =
        company.firstWhere((elem) => elem.company == companys);
    notifyListeners();
  }

  void selectStatUpdate(String statu) {
    statusSelectedUpdate = status.firstWhere((elem) => elem.status == statu);
    notifyListeners();
  }

//---------------------------------------------
  void updateColor(int colors, String colorStrings) {
    colorController = colors;
    colorControllerUpdate = colors;

    //colorString = "0xffffffff";
    colorString = colorStrings;
    notifyListeners();
  }

  //---------------------------------------------
  void inicializeColor(Vehicle vehicle) {
    colorController = int.parse(vehicle.color!);
    //colorString = "0xffffffff";
    colorString = colorController.toString();
    notifyListeners();
  }

  //---------------------------------------------
  void inicializeImage(Vehicle vehicle) {
    final List<int> codeUnits = vehicle.image.codeUnits;
    webImage = Uint8List.fromList(codeUnits);

    notifyListeners();
  }

//---------------------------------------------
  Future<bool> updateVehicle(Vehicle vehicle) async {
    print("status: ${vehicle.status.status}");
    print("company: ${vehicle.company.company}");
    try {
      await supabaseCtrlV.from('vehicle').update({
        'make': makeControllerUpdate.text,
        'model': modelControllerUpdate.text,
        'year': yearControllerUpdate.text,
        'vin': vinControllerUpdate.text,
        'license_plates': plateNumberControllerUpdate.text,
        'motor': motorControllerUpadte.text,
        'color': colorString ?? vehicle.color,
        'image': "data:image/png;base64,$imageBase64Update",
        'id_status_fk':
            statusSelectedUpdate?.statusId ?? vehicle.status.statusId,
        'id_company_fk':
            companySelectedUpdate?.companyId ?? vehicle.company.companyId,
        'date_added': DateTime.now().toIso8601String(),
        'oil_change_due': dateTimeControllerOilUpdate.text,
        'last_radiator_fluid_change': dateTimeControllerRFCUpadte.text,
        'last_transmission_fluid_change': dateTimeControllerLTFCUpadte.text
      }).eq("id_vehicle", vehicle.idVehicle);
      return true;
    } catch (e) {
      print('Error in updatevehicle() - $e');
      return false;
    }
  }
//---------------------------------------------

  Future<bool> deleteVehicle(Vehicle vehicle) async {
    try {
      // await supabase.rpc(
      //   'delete_vehicle',
      //   params: {'id_vehicle': id_vehicle},
      // );
      await supabaseCtrlV
          .from('vehicle')
          .delete()
          .match({'id_vehicle': vehicle.idVehicle});
      return true;
    } catch (e) {
      log('Error in deleteVehicle() - $e');
      return false;
    }
  }

//---------------------------------------------
  Future<bool> createVehicleInventory() async {
    try {
      await supabaseCtrlV.from('vehicle').insert(
        {
          'id_vehicle': idvehicle,
          'make': brandController.text,
          'model': modelController.text,
          'year': yearController.text,
          'vin': vinController.text,
          'license_plates': plateNumberController.text,
          'motor': motorController.text,
          'color': colorString,
          'image': "data:image/png;base64,$imageBase64",
          'id_status_fk': statusSelected?.statusId,
          'id_company_fk': companySelected?.companyId,
          'date_added': DateTime.now().toIso8601String(),
          'oil_change_due': dateTimeControllerOil.text,
          'last_radiator_fluid_change': dateTimeControllerRFC.text,
          'last_transmission_fluid_change': dateTimeControllerLTFC.text
        },
      );
      return true;
    } catch (e) {
      print('Error in createVehicleInventory() - $e');
      return false;
    }
  }
  //---------------------------------------------

  Future<void> getInventory() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      // SUPBASECTRlV es el control vehicular
      final res = await supabaseCtrlV.from('inventory_view').select();
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
              // "id_vehicle": PlutoCell(value: vehicle.idVehicle),
              // "image": PlutoCell(value: vehicle.image),
              "make": PlutoCell(value: vehicle.make),
              "model": PlutoCell(value: vehicle.model),
              "year": PlutoCell(value: vehicle.year),
              "vin": PlutoCell(value: vehicle.vin),
              "license_plates": PlutoCell(value: vehicle.licesensePlates),
              "motor": PlutoCell(value: vehicle.motor),
              // "color": PlutoCell(value: vehicle.color),
              "status": PlutoCell(value: vehicle.status.status),
              "company": PlutoCell(value: vehicle.company.company),
              // "date_added": PlutoCell(
              //     value: DateFormat("MMM/dd/yyyy")
              //         .format(vehicle.dateAdded)
              //         .toString()),
              "details": PlutoCell(value: vehicle),
              "actions": PlutoCell(value: vehicle),
              "issues": PlutoCell(value: vehicle)
            },
          ),
        );
      }

      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getInventory() - $e');
    }
    notifyListeners();
  }

  //---------------------------------------------

  Future<void> getIssues(IssuesXUser issuesXUser) async {
    // Limpiar listas
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

    //
    try {
      final res = await supabaseCtrlV
          .from('issues_view')
          .select()
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      // .match({
      //   'id_vehicle': issuesXUser.idVehicleFk,
      //   'id_user_fk': issuesXUser.userProfileId,
      // })
      // .neq('issues_r', '0')
      // .neq('issues_d', '0');

      // AQUI está el fallo
      print("Antes del map");
      issues = (res as List<dynamic>)
          .map((issues) => Issues.fromJson(jsonEncode(issues)))
          .toList();
      print("Despues del map");

      for (Issues issue in issues) {
        if (issue.issuesR != 0) {
          // Se verifica que bucketInspection Contentenga un valor en estado BAD
          if (issue.bucketInspectionR.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.bucketInspectionR.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.bucketInspectionR.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.bucketInspectionR
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded = DateTime.parse(
                    issue.bucketInspectionR.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                bucketInspectionR.add(newIssuesComments);
              }
            });
          }
          // ---------------------- CarBodyWork_r ----------------------------//
          if (issue.carBodyworkR.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.carBodyworkR.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.carBodyworkR.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.carBodyworkR
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded =
                    DateTime.parse(issue.carBodyworkR.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                carBodyWorkR.add(newIssuesComments);
              }
            });
          }
          // ---------------------- equipmentR ----------------------------//
          if (issue.equimentR.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.equimentR.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.equimentR.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.equimentR
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded =
                    DateTime.parse(issue.equimentR.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                equipmentR.add(newIssuesComments);
              }
            });
          }

          // ---------------------- extraR ----------------------------//
          if (issue.extraR.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.extraR.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.extraR.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.extraR
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded =
                    DateTime.parse(issue.extraR.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                extraR.add(newIssuesComments);
              }
            });
          }
          // ---------------------- fluidCheckR ----------------------------//
          if (issue.fluidCheckR.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.fluidCheckR.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.fluidCheckR.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.fluidCheckR
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded =
                    DateTime.parse(issue.fluidCheckR.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                fluidCheckR.add(newIssuesComments);
              }
            });
          }
          // ---------------------- lightsR ----------------------------//
          if (issue.lightsR.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.lightsR.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.lightsR.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.lightsR
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded =
                    DateTime.parse(issue.lightsR.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                lightsR.add(newIssuesComments);
              }
            });
          }
          // ---------------------- MeasureR ----------------------------//
          if (issue.measureR.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.measureR.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.measureR.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.measureR
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded =
                    DateTime.parse(issue.measureR.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                measureR.add(newIssuesComments);
              }
            });
          }
          // ---------------------- SecurityR ----------------------------//
          if (issue.securityR.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.securityR.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.securityR.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.securityR
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded =
                    DateTime.parse(issue.securityR.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                securityR.add(newIssuesComments);
              }
            });
          }
        }
        //------------------------- APARTADO DE LOS DELIVERED --------------------//
        if (issue.issuesD != 0) {
          // ---------------------- BucketInspectionD ----------------------------//
          if (issue.bucketInspectionD.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.bucketInspectionD.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.bucketInspectionD.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.bucketInspectionD
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded = DateTime.parse(
                    issue.bucketInspectionD.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                bucketInspectionD.add(newIssuesComments);
              }
            });
          }
          // ---------------------- CarBodyWork_d ----------------------------//
          if (issue.carBodyworkD.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.carBodyworkD.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.carBodyworkD.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.carBodyworkD
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded =
                    DateTime.parse(issue.carBodyworkD.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                carBodyWorkD.add(newIssuesComments);
              }
            });
          }
          // ---------------------- equipmentD ----------------------------//
          if (issue.equimentD.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.equimentD.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.equimentD.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.equimentD
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded =
                    DateTime.parse(issue.equimentD.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                equipmentD.add(newIssuesComments);
              }
            });
          }
          // ---------------------- extraD ----------------------------//
          if (issue.extraD.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.extraD.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.extraD.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.extraD
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded =
                    DateTime.parse(issue.extraD.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                extraD.add(newIssuesComments);
              }
            });
          }
          // ---------------------- MeasureD ----------------------------//
          if (issue.measureD.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.measureD.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.measureD.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.measureD
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded =
                    DateTime.parse(issue.measureD.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                measureD.add(newIssuesComments);
              }
            });
          }

          /////
          /// // ---------------------- fluidCheckD ----------------------------//
          if (issue.fluidCheckD.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.fluidCheckD.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.fluidCheckD.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.fluidCheckD
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded =
                    DateTime.parse(issue.fluidCheckD.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                fluidCheckD.add(newIssuesComments);
              }
            });
          }

          // ---------------------- lightsD ----------------------------//
          if (issue.lightsD.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.lightsD.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.lightsD.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.lightsD
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded =
                    DateTime.parse(issue.lightsD.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                lightsD.add(newIssuesComments);
              }
            });
          }
          // ---------------------- SecurityD ----------------------------//
          if (issue.securityD.toMap().containsValue("Bad")) {
            // AQUI RECORRE EL ISSUE.BUCKETINSPECTIONR Y MARCA ERROR
            //Error en getIssues - Expected a value of type 'List<String>', but got one of type 'String'
            issue.securityD.toMap().forEach((key, value) {
              if (value == 'Bad' && !(key.contains("_comments"))) {
                String nameIssue = key;
                String? comments =
                    issue.securityD.toMap()["${nameIssue}_comments"];
                List<String> listImage = issue.securityD
                    .toMap()["${nameIssue}_image"]
                    .toString()
                    .split('|');

                DateTime dateAdded =
                    DateTime.parse(issue.securityD.toMap()["date_added"]);
                IssuesComments newIssuesComments = IssuesComments(
                    nameIssue: nameIssue,
                    comments: comments,
                    listImages: listImage,
                    dateAdded: dateAdded);
                securityD.add(newIssuesComments);
              }
            });
          }
        }
      }
      // PRINT DE LA INFORMACIÓN
      print("-----------------------------------");
      print("BucketInspectionR: ${bucketInspectionR.length}");
      print("BucketInspectionD: ${bucketInspectionD.length}");
      print("CarBodyWorkR: ${carBodyWorkR.length}");
      print("carBodyWorkD: ${carBodyWorkD.length}");
      print("equipmentR: ${equipmentR.length}");
      print("equipmentD: ${equipmentD.length}");
      print("extraR: ${extraR.length}");
      print("extraD: ${extraD.length}");
      print("fluidCheckR: ${fluidCheckR.length}");
      print("fluidCheckD: ${fluidCheckD.length}");
      print("lightsR: ${lightsR.length}");
      print("lightsD: ${lightsD.length}");
      print("measureR: ${measureR.length}");
      print("measureD: ${measureD.length}");
      print("SecurityD: ${securityD.length}");
      print("SecurityR: ${securityR.length}");
      print("-----------------------------------");
    } catch (e) {
      print("Error en getIssues - $e");
    }
  }
  //---------------------------------------------

  void getIssuesxUsers(Vehicle vehicle) async {
    try {
      final res = await supabaseCtrlV
          .from('issues_x_users')
          .select()
          .match({'id_vehicle_fk': vehicle.idVehicle});
      issuesxUser = (res as List<dynamic>)
          .map((issuesxUser) => IssuesXUser.fromJson(jsonEncode(issuesxUser)))
          .toList();
    } catch (e) {
      print("Error en getIssuesxUsers - $e");
    }
    notifyListeners();
  }

//----------------------------------------------
  // EXCEL
  Future<bool> excelActivityReports() async {
    //Crear excel
    Excel excel = Excel.createExcel();
    Sheet? sheet = excel.sheets[excel.getDefaultSheet()];

    if (sheet == null) return false;
    //Agregar primera linea
    sheet.appendRow([
      'Título',
      'Vehicle Inventory',
      '',
      '',
      'Fecha',
      DateFormat("yyy - MMM - dd ").format(DateTime.now()),
    ]);
    //Agregar linea vacia
    sheet.appendRow(['']);

    //Agregar headers
    sheet.appendRow([
      'id_vehicle',
      'make',
      'model',
      'year',
      'vin',
      'license_plates',
      'motor',
      'color',
      'status',
      'company',
      'date_Added',
      'oil_change_due',
      'Last transmission fluid change:',
      'Last radiator fluid change:'
    ]);

    //Agregar datos
    for (Vehicle report in vehicles) {
      final List<dynamic> row = [
        report.idVehicle,
        report.make,
        report.model,
        report.year,
        report.vin,
        report.licesensePlates,
        report.motor,
        report.color,
        report.status.status,
        report.company.company,
        DateFormat("yyyy - MMM - dd").format(report.dateAdded),
        DateFormat("yyyy - MMM - dd").format(report.oilChangeDue),
        DateFormat("yyyy - MMM - dd").format(report.lastRadiatorFluidChange),
        DateFormat("yyyy - MMM - dd")
            .format(report.lastTransmissionFluidChange),
      ];
      sheet.appendRow(row);
    }

    //Descargar
    final List<int>? fileBytes = excel.save(fileName: "Vehicle_Inventory.xlsx");
    if (fileBytes == null) return false;

    return true;
  }
//----------------------------------------------

  void clearControllers() {
    brandController.clear();
    modelController.clear();
    vinController.clear();
    plateNumberController.clear();
    motorController.clear();
    colorController = 0xffffffff;
  }

  void clearImage() {
    webImage = null;
    imageName = null;
  }

  @override
  void dispose() {
    brandController.dispose();
    modelController.dispose();
    vinController.dispose();
    plateNumberController.dispose();
    motorController.dispose();
    // colorController.dispose();

    super.dispose();
  }
}
