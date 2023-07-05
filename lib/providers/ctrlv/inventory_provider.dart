import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:pluto_grid_export/pluto_grid_export.dart';
import 'package:rta_crm_cv/functions/date_format.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/company_api.dart';
import 'package:rta_crm_cv/models/issues_comments.dart';
import 'package:rta_crm_cv/models/issues_open_close.dart';
import 'package:rta_crm_cv/models/service_api.dart';
import 'package:rta_crm_cv/models/status_api.dart';
import 'package:rta_crm_cv/models/vehicle.dart';
import 'package:excel/excel.dart';

import '../../models/issues.dart';
import '../../models/issues_x_user.dart';
import '../../models/services.dart';
import '../../models/vehicle_dashboard.dart';

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
  TextEditingController serviceDateController = TextEditingController();
  TextEditingController? nextDateController = TextEditingController();

  TextEditingController searchController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController mileageController = TextEditingController();
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
  TextEditingController mileageControllerUpdate = TextEditingController();
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
  IssuesXUser? actualIssueXUser;
  IssuesComments? actualissuesComments;
  Vehicle? actualVehicle;
  int idvehicle = 16;
  String? colorString = "0xffffffff";
//------------------------------------------

  //List<RolApi> roles = [];
  List<String> dropdownMenuItems = [];
  StatusApi? statusSelected;
  CompanyApi? companySelected;
  Services? serviceSelected;
  StatusApi? statusSelectedUpdate;
  CompanyApi? companySelectedUpdate;
//------------------------------------------

  // Lista de Modelos
  List<CompanyApi> company = [];
  List<StatusApi> status = [];
  List<Services> service = [];
  List<Vehicle> vehicles = [];
  List<ServicesApi> services = [];
  List<Issues> issues = [];
  List<BucketInspection> issuePart1 = [];
  List<BucketInspection> issuePartD = [];
  List<CarBodywork> issueCarBodywR = [];
  List<CarBodywork> issueCarBodyWD = [];
  List<Equiment> issueEquipmentR = [];
  List<Equiment> issueEquipmentD = [];
  List<Extra> issueExtraR = [];
  List<Extra> issueExtradD = [];
  List<FluidCheck> issueFluidCheckR = [];
  List<FluidCheck> issueFluidCheckD = [];
  List<Lights> issueLightsR = [];
  List<Lights> issueLightsD = [];
  List<Security> issueSecurityR = [];
  List<Security> issueSecurityD = [];
  List<Measure> issueMeasureR = [];
  List<Measure> issueMeasureD = [];

  List<VehicleDash> vehicleArchive = [];
  List<IssuesXUser> issuesxUser = [];
//------------------------------------------

  // Listas R
  List<IssuesComments> bucketInspectionR = [];
  List<IssueOpenclose> bucketInspectionRR = [];
  List<IssueOpenclose> carBodyWorkRR = [];
  List<IssueOpenclose> equipmentRR = [];
  List<IssueOpenclose> extraRR = [];
  List<IssueOpenclose> fluidCheckRR = [];
  List<IssueOpenclose> lightsRR = [];
  List<IssueOpenclose> measureRR = [];
  List<IssueOpenclose> securityRR = [];

  List<IssuesComments> carBodyWorkR = [];
  List<IssuesComments> equipmentR = [];
  List<IssuesComments> extraR = [];
  List<IssuesComments> fluidCheckR = [];
  List<IssuesComments> lightsR = [];
  List<IssuesComments> measureR = [];
  List<IssuesComments> securityR = [];

  // Listas D
  List<IssuesComments> bucketInspectionD = [];
  List<IssueOpenclose> bucketInspectionDD = [];
  List<IssueOpenclose> carBodyWorkDD = [];
  List<IssueOpenclose> equipmentDD = [];
  List<IssueOpenclose> extraDD = [];
  List<IssueOpenclose> fluidCheckDD = [];
  List<IssueOpenclose> lightsDD = [];
  List<IssueOpenclose> measureDD = [];
  List<IssueOpenclose> securityDD = [];

  List<IssuesComments> carBodyWorkD = [];
  List<IssuesComments> equipmentD = [];
  List<IssuesComments> extraD = [];
  List<IssuesComments> fluidCheckD = [];
  List<IssuesComments> lightsD = [];
  List<IssuesComments> measureD = [];
  List<IssuesComments> securityD = [];

  List<IssueOpenclose> listaTotalIssues = [];

//------------------------------------------
  // TITULO LISTAS
  List<String> titulosIssue = [
    "Bucket Inspection",
    "Car BodyWork",
    "Equipment",
    "Extra",
    "Fluid Check",
    "Lights",
    "Measures",
    "Security"
  ];
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

  void selectVehicle(Vehicle vehicle) {
    actualVehicle = vehicle;
    notifyListeners();
  }

  // ------------------------------------------
  // List<IssuesComments> issuesComments = [];
  // void selectIssuesCommentsR(int index) {
  //   issuesComments = // menuIssuesReceived[index]!;
  //   //print("IssuesComments: ${issuesComments.length} ");
  //   notifyListeners();
  // }

  // //------------------------------------------
  // List<IssuesComments> issuesCommentsD = [];
  // void selectIssuesCommentsD(int index) {
  //   issuesCommentsD = // // // // menuIssuesReceivedD[index]!;
  //   notifyListeners();
  // }
  //------------------------------------------

  void selectIssuesXUser(int index) {
    actualIssueXUser = issuesxUser[index];
    notifyListeners();
  }

  //------------------------------------------
  List<IssueOpenclose> listaFiltrada = []; // Lista filtrada, inicialmente vacía
  void filtrarPorMes(int day) {
    print("provider.listaTotalISSUES: ${listaTotalIssues.length}");
    listaFiltrada = listaTotalIssues
        .where((elemento) => elemento.dateAddedOpen.day == day)
        .toList();
    print("Provider.listafiltrada: ${listaFiltrada.length}");
    notifyListeners();
  }
  //------------------------------------------

  void selectIssuesComments(IssuesComments issueComments) {
    actualissuesComments = issueComments;
    notifyListeners();
  }
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
    mileageControllerUpdate.text = vehicle.mileage.toString();
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
//---------------------------------------------

  Future<void> getServices({bool notify = true}) async {
    final res = await supabaseCtrlV
        .from('services')
        .select()
        .order('service', ascending: true);
    print("Entro a getServices()");
    service = (res as List<dynamic>)
        .map((service) => Services.fromJson(jsonEncode(service)))
        .toList();
    if (notify) notifyListeners();
  }
//---------------------------------------------

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
  int issuesView = 0;
  void setIssueViewActual(int value) {
    issuesView = value;
    notifyListeners();
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

  void selectService(String servicesvar) {
    serviceSelected = service.firstWhere((elem) => elem.service == servicesvar);
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
        'last_transmission_fluid_change': dateTimeControllerLTFCUpadte.text,
        'mileage': mileageControllerUpdate.text
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
  Future<bool> createVehicleService() async {
    try {
      await supabaseCtrlV.from('vehicle_services').insert({
        'created_at': DateTime.now().toIso8601String(),
        'id_vehicle_fk': actualVehicle!.idVehicle,
        'id_service_fk': serviceSelected?.idService,
        'service_date': serviceDateController.text,
        // 'next_date':
        //     nextDateController?.text == null ? null : nextDateController?.text,
      });
      return true;
    } catch (e) {
      print("Error in createVehicleService() - $e");
      print(actualVehicle!.idVehicle);
      return false;
    }
  }

  //---------------------------------------------
  Future<bool> getServicesPage() async {
    try {
      final res = await supabaseCtrlV
          .from('service_view')
          .select()
          .match({"id_vehicle_fk": actualVehicle!.idVehicle});
      print(res);

      services = (res as List<dynamic>)
          .map((services) => ServicesApi.fromJson(jsonEncode(services)))
          .toList();
      return true;
    } catch (e) {
      print("Error in getServicesPage() - $e");
      print(actualVehicle!.idVehicle);
      return false;
    }
  }

//---------------------------------------------
  Future<bool> createVehicleInventory() async {
    try {
      await supabaseCtrlV.from('vehicle').insert(
        {
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
          'last_transmission_fluid_change': dateTimeControllerLTFC.text,
          'mileage': mileageController.text
        },
      );
      return true;
    } catch (e) {
      print('Error in createVehicleInventory() - $e');
      return false;
    }
  }

  bool bandera1 = true;
  //---------------------------------------------
  Future<void> changeStatusInventory(Vehicle vehicle) async {
    try {
      await supabaseCtrlV
          .from("vehicle")
          .update({'id_status_fk': 4}).eq('id_vehicle', vehicle.idVehicle);
    } catch (e) {
      print("Error in changeStatusInventory() - $e");
    }
    notifyListeners();
  }

  //---------------------------------------------
  Future<void> getInventory() async {
    bandera1 = true;

    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      // SUPBASECTRlV es el control vehicular
      final res = await supabaseCtrlV
          .from('inventory_view')
          .select()
          .not('namestatus', 'eq', 'Not Active');
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
              "model": PlutoCell(value: vehicle.fullName),
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
              "mileage": PlutoCell(value: vehicle.mileage.toString()),
              //"details": PlutoCell(value: vehicle),
              "actions": PlutoCell(value: vehicle),
              //"issues": PlutoCell(value: vehicle)
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
  Future<void> UpdateStatusVehicle() async {
    bandera1 = false;
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      // SUPBASECTRlV es el control vehicular
      final res = await supabaseCtrlV
          .from('inventory_view')
          .select()
          .eq('namestatus', 'Not Active');
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
              "model": PlutoCell(value: vehicle.fullName),
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
              "mileage": PlutoCell(value: vehicle.mileage.toString()),
              //"details": PlutoCell(value: vehicle),
              "actions": PlutoCell(value: vehicle),
              //"issues": PlutoCell(value: vehicle)
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

  Future<void> getArchiveVehicle() async {
    try {
      final res = await supabaseCtrlV
          .from('vehicle')
          .select()
          .match({'id_status_fk': 4.toString()});
      print(res);

      // AQUI está el fallo
      vehicleArchive = (res as List<dynamic>)
          .map((vehicleArchive) =>
              VehicleDash.fromJson(jsonEncode(vehicleArchive)))
          .toList();
    } catch (e) {
      print("Error en getArchiveVehicle - $e");
    }
  }

  // --------------------------------------------
  Future<void> getIssuesBasics(IssuesXUser issuesXUser) async {
    // clearListgetIssues();

    try {
      final res = await supabaseCtrlV
          .from('issues_view')
          .select(
              'id_vehicle, bucket_inspection_r ->id_bucket_inspection, bucket_inspection_r ->holes_drilled,bucket_inspection_r ->insulated, bucket_inspection_r ->bucket_liner, bucket_inspection_r ->date_added')
          // Si pongo   'bucket_inspection_r ->holes_drilled ->"Bad" me marca Bad y no holes_drilled
          // .select(
          // ' id_vehicle,id_control_form, issues_r,issues_d, id_bucket_inspection_r_fk , car_bodywork_r->, equiment_r,user_profile,extra_r,fluid_check_r,lights_r,measure_r,security_r,bucket_inspection_r ->holes_drilled,bucket_inspection_r ->insulated, bucket_inspection_r ->bucket_liner')
          //.eq('bucket_inspection_r ->holes_drilled', 'Bad')
          // .match({
          //   'bucket_inspection_r ->holes_drilled': 'bad',
          //   'bucket_inspection_r ->insulated': 'bad',
          //   'bucket_inspection_r ->bucket_liner': 'bad',
          // })
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      final resD = await supabaseCtrlV
          .from('issues_view')
          .select(
              'bucket_inspection_d ->id_bucket_inspection, bucket_inspection_d ->holes_drilled,bucket_inspection_d ->insulated, bucket_inspection_d ->bucket_liner, bucket_inspection_d ->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      issuePart1 = (res as List<dynamic>)
          .map(
              (issuePart1) => BucketInspection.fromJson(jsonEncode(issuePart1)))
          .toList();
      issuePartD = (resD as List<dynamic>)
          .map(
              (issuePartD) => BucketInspection.fromJson(jsonEncode(issuePartD)))
          .toList();

      // BucketInspectionR
      for (BucketInspection issue in issuePart1) {
        if (issue.holesDrilled == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Holes Drilled",
              dateAddedOpen: issue.dateAdded!);
          bucketInspectionRR.add(newIssueComments);
        }
        if (issue.bucketLiner == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Bucket Liner",
              dateAddedOpen: issue.dateAdded!);
          bucketInspectionRR.add(newIssueComments);
        }
        if (issue.insulated == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Insulated",
              dateAddedOpen: issue.dateAdded!);
          bucketInspectionRR.add(newIssueComments);
        }
      }

      // BucketInspectionD
      for (BucketInspection issue in issuePartD) {
        if (issue.holesDrilled == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Holes Drilled",
              dateAddedOpen: issue.dateAdded!);
          bucketInspectionDD.add(newIssueComments);
        }
        if (issue.bucketLiner == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Bucket Liner",
              dateAddedOpen: issue.dateAdded!);
          bucketInspectionDD.add(newIssueComments);
        }
        if (issue.insulated == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Insulated",
              dateAddedOpen: issue.dateAdded!);
          bucketInspectionRR.add(newIssueComments);
        }
      }
      print("BucketInspectionRR: ${bucketInspectionRR.length}");

      print("Entro a getIssuesBasics");
    } catch (e) {
      print("Error in getIssuesBasics() - $e");
    }
    notifyListeners();
  }

  // --------------------------------------------
  Future<void> getIssuesCarBodywork(IssuesXUser issuesXUser) async {
    try {
      // CardBodyWork_R
      final res = await supabaseCtrlV
          .from('issues_view')
          .select(
              'car_bodywork_r ->id_car_bodywork, car_bodywork_r ->wiper_blades_front,car_bodywork_r ->wiper_blades_back, car_bodywork_r ->windshield_wiper_front,car_bodywork_r->windshield_wiper_back,car_bodywork_r ->general_body,car_bodywork_r ->decaling,car_bodywork_r ->tires,car_bodywork_r->glass,car_bodywork_r ->mirrors,car_bodywork_r-> parking,car_bodywork_r->brakes,car_bodywork_r ->emg_brakes,car_bodywork_r->horn ,car_bodywork_r ->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      // CardBodyWork_D
      final resD = await supabaseCtrlV
          .from('issues_view')
          .select(
              'car_bodywork_d ->id_car_bodywork, car_bodywork_d ->wiper_blades_front,car_bodywork_d ->wiper_blades_back, car_bodywork_d ->windshield_wiper_front,car_bodywork_d->windshield_wiper_back,car_bodywork_d ->general_body,car_bodywork_d ->decaling,car_bodywork_d ->tires,car_bodywork_d->glass,car_bodywork_d ->mirrors,car_bodywork_d-> parking,car_bodywork_d->brakes,car_bodywork_d ->emg_brakes,car_bodywork_d->horn ,car_bodywork_d ->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      issueCarBodywR = (res as List<dynamic>)
          .map((issueCarBodywR) =>
              CarBodywork.fromJson(jsonEncode(issueCarBodywR)))
          .toList();
      issueCarBodyWD = (resD as List<dynamic>)
          .map((issueCarBodyWD) =>
              CarBodywork.fromJson(jsonEncode(issueCarBodyWD)))
          .toList();

      // BucketInspectionR
      for (CarBodywork issue in issueCarBodywR) {
        if (issue.wiperBladesFront == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Wuper Blades Front",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkRR.add(newIssueComments);
        }
        if (issue.wiperBladesBack == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Wiper Blades Back",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkRR.add(newIssueComments);
        }
        if (issue.windshieldWiperFront == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "WindShield Wiper Front",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkRR.add(newIssueComments);
        }
        if (issue.windshieldWiperBack == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "WindShield Wiper Back",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkRR.add(newIssueComments);
        }
        if (issue.generalBody == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "General Body",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkRR.add(newIssueComments);
        }
        if (issue.decaling == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Decaling",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkRR.add(newIssueComments);
        }
        if (issue.tires == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Tires",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkRR.add(newIssueComments);
        }
        if (issue.glass == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Glass",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkRR.add(newIssueComments);
        }
        if (issue.mirrors == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Mirrors",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkRR.add(newIssueComments);
        }
        if (issue.parking == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Parking",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkRR.add(newIssueComments);
        }
        if (issue.brakes == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Brakes",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkRR.add(newIssueComments);
        }
        if (issue.emgBrakes == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Emg Brakes",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkRR.add(newIssueComments);
        }
        if (issue.horn == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Horn",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkRR.add(newIssueComments);
        }
      }

      // BucketInspectionD
      for (CarBodywork issue in issueCarBodyWD) {
        if (issue.wiperBladesFront == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Wuper Blades Front",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkDD.add(newIssueComments);
        }
        if (issue.wiperBladesBack == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Wiper Blades Back",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkDD.add(newIssueComments);
        }
        if (issue.windshieldWiperFront == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "WindShield Wiper Front",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkDD.add(newIssueComments);
        }
        if (issue.windshieldWiperBack == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "WindShield Wiper Back",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkDD.add(newIssueComments);
        }
        if (issue.generalBody == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "General Body",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkDD.add(newIssueComments);
        }
        if (issue.decaling == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Decaling",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkDD.add(newIssueComments);
        }
        if (issue.tires == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Tires",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkDD.add(newIssueComments);
        }
        if (issue.glass == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Glass",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkDD.add(newIssueComments);
        }
        if (issue.mirrors == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Mirrors",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkDD.add(newIssueComments);
        }
        if (issue.parking == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Parking",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkDD.add(newIssueComments);
        }
        if (issue.brakes == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Brakes",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkDD.add(newIssueComments);
        }
        if (issue.emgBrakes == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Emg Brakes",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkDD.add(newIssueComments);
        }
        if (issue.horn == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Horn",
              dateAddedOpen: issue.dateAdded!);
          carBodyWorkDD.add(newIssueComments);
        }
      }
      //print("BucketInspectionRR: ${bucketInspectionRR.length}");

      print("Entro a getIssuesCarBodywork");
    } catch (e) {
      print("Error in getIssuesCarBodywork() - $e");
    }
    notifyListeners();
  }

  Future<void> getIssuesEquipment(IssuesXUser issuesXUser) async {
    try {
      // getIssuesEquipment_r
      final res = await supabaseCtrlV
          .from('issues_view')
          .select(
              'equiment_r ->id_equiment_r, equiment_r ->ignition_key,equiment_r ->bins_box_key, equiment_r ->vehicle_registration_copy,equiment_r->vehicle_insurance_copy,equiment_r ->bucket_lift_operator_manual,equiment_r ->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      // getIssuesEquipment_d
      final resD = await supabaseCtrlV
          .from('issues_view')
          .select(
              'equiment_d ->id_equiment_d, equiment_d ->ignition_key,equiment_d ->bins_box_key, equiment_d ->vehicle_registration_copy,equiment_d->vehicle_insurance_copy,equiment_d ->bucket_lift_operator_manual,equiment_d ->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      print(resD);

      issueEquipmentR = (res as List<dynamic>)
          .map((issueEquipmentR) =>
              Equiment.fromJson(jsonEncode(issueEquipmentR)))
          .toList();
      issueEquipmentD = (resD as List<dynamic>)
          .map((issueEquipmentD) =>
              Equiment.fromJson(jsonEncode(issueEquipmentD)))
          .toList();

      // BucketInspectionR
      for (Equiment issue in issueEquipmentR) {
        if (issue.ignitionKey == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "ignition key",
              dateAddedOpen: issue.dateAdded!);
          equipmentRR.add(newIssueComments);
        }
        if (issue.binsBoxKey == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Bins Box Key",
              dateAddedOpen: issue.dateAdded!);
          equipmentRR.add(newIssueComments);
        }
        if (issue.vehicleRegistrationCopy == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Vehicle Registration Copy",
              dateAddedOpen: issue.dateAdded!);
          equipmentRR.add(newIssueComments);
        }
        if (issue.vehicleInsuranceCopy == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Vehicle Insurance Copy",
              dateAddedOpen: issue.dateAdded!);
          equipmentRR.add(newIssueComments);
        }
        if (issue.bucketLiftOperatorManual == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Bucket Lift Operator Manual",
              dateAddedOpen: issue.dateAdded!);
          equipmentRR.add(newIssueComments);
        }
      }
      // BucketInspectionD

      for (Equiment issue in issueEquipmentD) {
        if (issue.ignitionKey == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "ignition key",
              dateAddedOpen: issue.dateAdded!);
          equipmentDD.add(newIssueComments);
        }
        if (issue.binsBoxKey == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Bins Box Key",
              dateAddedOpen: issue.dateAdded!);
          equipmentDD.add(newIssueComments);
        }
        if (issue.vehicleRegistrationCopy == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Vehicle Registration Copy",
              dateAddedOpen: issue.dateAdded!);
          equipmentDD.add(newIssueComments);
        }
        if (issue.vehicleInsuranceCopy == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Vehicle Insurance Copy",
              dateAddedOpen: issue.dateAdded!);
          equipmentDD.add(newIssueComments);
        }
        if (issue.bucketLiftOperatorManual == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Bucket Lift Operator Manual",
              dateAddedOpen: issue.dateAdded!);
          equipmentDD.add(newIssueComments);
        }
      }
      //print("BucketInspectionRR: ${bucketInspectionRR.length}");

      print("Entro a getIssuesEquipment");
    } catch (e) {
      print("Error in getIssuesEquipment() - $e");
    }
    //clearListgetIssues();

    notifyListeners();
  }

  // --------------------------------------------
  Future<void> getIssuesExtra(IssuesXUser issuesXUser) async {
    try {
      // getIssuesEquipment_r
      final res = await supabaseCtrlV
          .from('issues_view')
          .select(
              'extra_r ->id_extra, extra_r ->ladder,extra_r ->step_ladder, extra_r ->ladder_straps,extra_r->hydraulic_fluid_for_bucket,extra_r ->fiber_reel_rack,extra_r ->bins_locked_and_secure,extra_r ->safety_harness,extra_r ->lanyard_safety_harness, extra_r ->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      // getIssuesEquipment_d
      final resD = await supabaseCtrlV
          .from('issues_view')
          .select(
              'extra_d ->id_extra, extra_d ->ladder,extra_d ->step_ladder, extra_d ->ladder_straps,extra_d->hydraulic_fluid_for_bucket,extra_d ->fiber_reel_rack,extra_d ->bins_locked_and_secure,extra_d ->safety_harness,extra_d ->lanyard_safety_harness, extra_d ->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      //print(res);

      issueExtraR = (res as List<dynamic>)
          .map((issueExtraR) => Extra.fromJson(jsonEncode(issueExtraR)))
          .toList();
      issueExtradD = (resD as List<dynamic>)
          .map((issueExtradD) => Extra.fromJson(jsonEncode(issueExtradD)))
          .toList();

      // ExtraR
      for (Extra issue in issueExtraR) {
        if (issue.ladder == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Ladder",
              dateAddedOpen: issue.dateAdded!);
          extraRR.add(newIssueComments);
        }
        if (issue.stepLadder == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Step Ladder",
              dateAddedOpen: issue.dateAdded!);
          extraRR.add(newIssueComments);
        }
        if (issue.ladderStraps == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Ladder Straps",
              dateAddedOpen: issue.dateAdded!);
          extraRR.add(newIssueComments);
        }
        if (issue.hydraulicFluidForBucket == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Hydraulic Fluid for Bucket",
              dateAddedOpen: issue.dateAdded!);
          extraRR.add(newIssueComments);
        }
        if (issue.fiberReelRack == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Fiber Reel Rack",
              dateAddedOpen: issue.dateAdded!);
          extraRR.add(newIssueComments);
        }
        if (issue.binsLockedAndSecure == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Bins Locked and Secure",
              dateAddedOpen: issue.dateAdded!);
          extraRR.add(newIssueComments);
        }
        if (issue.safetyHarness == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Safety Harness",
              dateAddedOpen: issue.dateAdded!);
          extraRR.add(newIssueComments);
        }
        if (issue.lanyardSafetyHarness == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Lanyard Safety Harness",
              dateAddedOpen: issue.dateAdded!);
          extraRR.add(newIssueComments);
        }
      }
      // ExtraR
      for (Extra issue in issueExtraR) {
        if (issue.ladder == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Ladder",
              dateAddedOpen: issue.dateAdded!);
          extraDD.add(newIssueComments);
        }
        if (issue.stepLadder == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Step Ladder",
              dateAddedOpen: issue.dateAdded!);
          extraDD.add(newIssueComments);
        }
        if (issue.ladderStraps == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Ladder Straps",
              dateAddedOpen: issue.dateAdded!);
          extraDD.add(newIssueComments);
        }
        if (issue.hydraulicFluidForBucket == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Hydraulic Fluid for Bucket",
              dateAddedOpen: issue.dateAdded!);
          extraDD.add(newIssueComments);
        }
        if (issue.fiberReelRack == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Fiber Reel Rack",
              dateAddedOpen: issue.dateAdded!);
          extraDD.add(newIssueComments);
        }
        if (issue.binsLockedAndSecure == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Bins Locked and Secure",
              dateAddedOpen: issue.dateAdded!);
          extraDD.add(newIssueComments);
        }
        if (issue.safetyHarness == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Safety Harness",
              dateAddedOpen: issue.dateAdded!);
          extraDD.add(newIssueComments);
        }
        if (issue.lanyardSafetyHarness == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Lanyard Safety Harness",
              dateAddedOpen: issue.dateAdded!);
          extraDD.add(newIssueComments);
        }
      }
      //print("BucketInspectionRR: ${bucketInspectionRR.length}");

      print("Entro a getIssuesExtra");
      print("ExtraRR: ${extraRR.length}");
      print("ExtraDD: ${extraDD.length}");
    } catch (e) {
      print("Error in getIssuesExtra() - $e");
    }
    //clearListgetIssues();

    notifyListeners();
  }

  // --------------------------------------------
  Future<void> getIssuesFluidCheck(IssuesXUser issuesXUser) async {
    try {
      // getIssuesFluidCheckR
      final res = await supabaseCtrlV
          .from('issues_view')
          .select(
              'fluid_check_r ->id_fluids_check, fluid_check_r ->engine_oil,fluid_check_r ->transmission, fluid_check_r ->coolant,fluid_check_r->power_steering,fluid_check_r ->diesel_exhaust_fluid,fluid_check_r ->windshield_washer_fluid, fluid_check_r ->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      // getIssuesFluidCheckD
      final resD = await supabaseCtrlV
          .from('issues_view')
          .select(
              'fluid_check_d ->id_fluids_check, fluid_check_d ->engine_oil,fluid_check_d ->transmission, fluid_check_d ->coolant,fluid_check_d->power_steering,fluid_check_d ->diesel_exhaust_fluid,fluid_check_d ->windshield_washer_fluid, fluid_check_d ->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      print(res);

      issueFluidCheckR = (res as List<dynamic>)
          .map((issueFluidCheckR) =>
              FluidCheck.fromJson(jsonEncode(issueFluidCheckR)))
          .toList();
      issueFluidCheckD = (resD as List<dynamic>)
          .map((issueFluidCheckD) =>
              FluidCheck.fromJson(jsonEncode(issueFluidCheckD)))
          .toList();

      // FluidCheckR
      for (FluidCheck issue in issueFluidCheckR) {
        if (issue.engineOil == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Engine Oil",
              dateAddedOpen: issue.dateAdded!);
          fluidCheckRR.add(newIssueComments);
        }
        if (issue.transmission == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Transmission",
              dateAddedOpen: issue.dateAdded!);
          fluidCheckRR.add(newIssueComments);
        }
        if (issue.coolant == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Coolant",
              dateAddedOpen: issue.dateAdded!);
          fluidCheckRR.add(newIssueComments);
        }
        if (issue.powerSteering == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Power Steering",
              dateAddedOpen: issue.dateAdded!);
          fluidCheckRR.add(newIssueComments);
        }
        if (issue.dieselExhaustFluid == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Diesel Exhaust Fluid",
              dateAddedOpen: issue.dateAdded!);
          fluidCheckRR.add(newIssueComments);
        }
        if (issue.windshieldWasherFluid == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Windshield Washer Fluid ",
              dateAddedOpen: issue.dateAdded!);
          fluidCheckRR.add(newIssueComments);
        }
      }
      // FluidCheckD
      for (FluidCheck issue in issueFluidCheckD) {
        if (issue.engineOil == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Engine Oil",
              dateAddedOpen: issue.dateAdded!);
          fluidCheckDD.add(newIssueComments);
        }
        if (issue.transmission == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Transmission",
              dateAddedOpen: issue.dateAdded!);
          fluidCheckDD.add(newIssueComments);
        }
        if (issue.coolant == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Coolant",
              dateAddedOpen: issue.dateAdded!);
          fluidCheckDD.add(newIssueComments);
        }
        if (issue.powerSteering == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Power Steering",
              dateAddedOpen: issue.dateAdded!);
          fluidCheckDD.add(newIssueComments);
        }
        if (issue.dieselExhaustFluid == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Diesel Exhaust Fluid",
              dateAddedOpen: issue.dateAdded!);
          fluidCheckDD.add(newIssueComments);
        }
        if (issue.windshieldWasherFluid == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Windshield Washer Fluid ",
              dateAddedOpen: issue.dateAdded!);
          fluidCheckDD.add(newIssueComments);
        }
      }

      print("Entro a getIssuesFluidCheck");
    } catch (e) {
      print("Error in getIssuesFluidCheck() - $e");
    }

    notifyListeners();
  }

// --------------------------------------------
  Future<void> getIssuesLights(IssuesXUser issuesXUser) async {
    try {
      // getIssuesLightsR
      final res = await supabaseCtrlV
          .from('issues_view')
          .select(
              'lights_r ->id_lights, lights_r ->headlights,lights_r ->brake_lights, lights_r ->reverse_lights,lights_r->warning_lights,lights_r ->turn_lights,lights_r ->4_way_flashers,lights_r ->dash_lights,lights_r ->strobe_lights,lights_r ->clearance_lights,lights_r ->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      // getIssuesLightsD
      final resD = await supabaseCtrlV
          .from('issues_view')
          .select(
              'lights_d ->id_lights, lights_d ->headlights,lights_d ->brake_lights, lights_d ->reverse_lights,lights_d->warning_lights,lights_d ->turn_lights,lights_d ->4_way_flashers,lights_d ->dash_lights,lights_d ->strobe_lights,lights_d ->clearance_lights,lights_d ->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      print(res);

      issueLightsR = (res as List<dynamic>)
          .map((issueLightsR) => Lights.fromJson(jsonEncode(issueLightsR)))
          .toList();
      issueLightsD = (resD as List<dynamic>)
          .map((issueLightsD) => Lights.fromJson(jsonEncode(issueLightsD)))
          .toList();

      // LightsR
      for (Lights issue in issueLightsR) {
        if (issue.headlights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Headlights",
              dateAddedOpen: issue.dateAdded!);
          lightsRR.add(newIssueComments);
        }
        if (issue.brakeLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Brake Lights",
              dateAddedOpen: issue.dateAdded!);
          lightsRR.add(newIssueComments);
        }
        if (issue.reverseLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Reverse Lights",
              dateAddedOpen: issue.dateAdded!);
          lightsRR.add(newIssueComments);
        }
        if (issue.warningLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Warning Lights",
              dateAddedOpen: issue.dateAdded!);
          lightsRR.add(newIssueComments);
        }
        if (issue.turnSignals == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Turn Signals",
              dateAddedOpen: issue.dateAdded!);
          lightsRR.add(newIssueComments);
        }
        if (issue.the4WayFlashers == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "4 way Flashers ",
              dateAddedOpen: issue.dateAdded!);
          lightsRR.add(newIssueComments);
        }
        if (issue.dashLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Dash Lights ",
              dateAddedOpen: issue.dateAdded!);
          lightsRR.add(newIssueComments);
        }
        if (issue.strobeLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Strobe Lights ",
              dateAddedOpen: issue.dateAdded!);
          lightsRR.add(newIssueComments);
        }
        if (issue.cabRoofLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Cab Roof Lights ",
              dateAddedOpen: issue.dateAdded!);
          lightsRR.add(newIssueComments);
        }
        if (issue.clearanceLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Clearance Lights ",
              dateAddedOpen: issue.dateAdded!);
          lightsRR.add(newIssueComments);
        }
      }
      // LightsD
      for (Lights issue in issueLightsD) {
        if (issue.headlights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Headlights",
              dateAddedOpen: issue.dateAdded!);
          lightsDD.add(newIssueComments);
        }
        if (issue.brakeLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Brake Lights",
              dateAddedOpen: issue.dateAdded!);
          lightsDD.add(newIssueComments);
        }
        if (issue.reverseLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Reverse Lights",
              dateAddedOpen: issue.dateAdded!);
          lightsDD.add(newIssueComments);
        }
        if (issue.warningLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Warning Lights",
              dateAddedOpen: issue.dateAdded!);
          lightsDD.add(newIssueComments);
        }
        if (issue.turnSignals == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Turn Signals",
              dateAddedOpen: issue.dateAdded!);
          lightsDD.add(newIssueComments);
        }
        if (issue.the4WayFlashers == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "4 way Flashers ",
              dateAddedOpen: issue.dateAdded!);
          lightsDD.add(newIssueComments);
        }
        if (issue.dashLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Dash Lights ",
              dateAddedOpen: issue.dateAdded!);
          lightsDD.add(newIssueComments);
        }
        if (issue.strobeLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Strobe Lights ",
              dateAddedOpen: issue.dateAdded!);
          lightsDD.add(newIssueComments);
        }
        if (issue.cabRoofLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Cab Roof Lights ",
              dateAddedOpen: issue.dateAdded!);
          lightsDD.add(newIssueComments);
        }
        if (issue.clearanceLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Clearance Lights ",
              dateAddedOpen: issue.dateAdded!);
          lightsDD.add(newIssueComments);
        }
      }

      print("Entro a getIssuesLights");
    } catch (e) {
      print("Error in getIssuesLights() - $e");
    }

    notifyListeners();
  }

  // --------------------------------------------
  Future<void> getIssuesMeasure(IssuesXUser issuesXUser) async {
    try {
      // getIssuesLightsR
      final res = await supabaseCtrlV
          .from('issues_view')
          .select(
              'measure_r ->id_measure, measure_r ->gas,measure_r ->mileage, measure_r->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      // getIssuesLightsD
      final resD = await supabaseCtrlV
          .from('issues_view')
          .select(
              'measure_d ->id_measure, measure_d ->gas,measure_d ->mileage, measure_d->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      print(res);

      issueMeasureR = (res as List<dynamic>)
          .map((issueMeasureR) => Measure.fromJson(jsonEncode(issueMeasureR)))
          .toList();
      issueMeasureD = (resD as List<dynamic>)
          .map((issueMeasureD) => Measure.fromJson(jsonEncode(issueMeasureD)))
          .toList();

      // MeasureR
      for (Measure issue in issueMeasureR) {
        if (issue.gas != "") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idMeasure!,
              nameIssue: "Gas",
              percentage: issue.gas,
              dateAddedOpen: issue.dateAdded!);
          measureRR.add(newIssueComments);
        }

        IssueOpenclose newIssueComments = IssueOpenclose(
            idIssue: issue.idMeasure!,
            nameIssue: "Mileage",
            percentage: issue.mileage.toString(),
            dateAddedOpen: issue.dateAdded!);
        measureRR.add(newIssueComments);
      }
      // MeasureD
      for (Measure issue in issueMeasureD) {
        if (issue.gas != "") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idMeasure!,
              nameIssue: "Gas",
              percentage: issue.gas,
              dateAddedOpen: issue.dateAdded!);
          measureDD.add(newIssueComments);
        }

        IssueOpenclose newIssueComments = IssueOpenclose(
            idIssue: issue.idMeasure!,
            nameIssue: "Mileage",
            percentage: issue.mileage.toString(),
            dateAddedOpen: issue.dateAdded!);
        measureDD.add(newIssueComments);
      }

      print("Entro a getIssueMeasure");
    } catch (e) {
      print("Error in getIssueMeasure() - $e");
    }

    notifyListeners();
  }

  // --------------------------------------------
  Future<void> getIssueSecurity(IssuesXUser issuesXUser) async {
    try {
      // getIssuesLightsR
      final res = await supabaseCtrlV
          .from('issues_view')
          .select(
              'security_r ->id_security, security_r ->rta_magnet,security_r ->triangle_reflectors, security_r ->wheel_chocks,security_r->fire_extinguisher,security_r ->firts_aid_kit_safety_vest,security_r ->back_up_alarm,security_r ->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      // getIssuesLightsD
      final resD = await supabaseCtrlV
          .from('issues_view')
          .select(
              'security_d ->id_security, security_d ->rta_magnet,security_d ->triangle_reflectors, security_d ->wheel_chocks,security_d->fire_extinguisher,security_d ->firts_aid_kit_safety_vest,security_d ->back_up_alarm,security_d ->date_added')
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      print(res);

      issueSecurityR = (res as List<dynamic>)
          .map(
              (issueSecurityR) => Security.fromJson(jsonEncode(issueSecurityR)))
          .toList();
      issueSecurityD = (resD as List<dynamic>)
          .map(
              (issueSecurityD) => Security.fromJson(jsonEncode(issueSecurityD)))
          .toList();

      // SecurityR
      for (Security issue in issueSecurityR) {
        if (issue.rtaMagnet == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "RTA Magnet",
              dateAddedOpen: issue.dateAdded!);
          securityRR.add(newIssueComments);
        }
        if (issue.triangleReflectors == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Triangle Reflectors",
              dateAddedOpen: issue.dateAdded!);
          securityRR.add(newIssueComments);
        }
        if (issue.wheelChocks == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Wheel Chocks",
              dateAddedOpen: issue.dateAdded!);
          securityRR.add(newIssueComments);
        }
        if (issue.fireExtinguisher == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Fire Extinguisher",
              dateAddedOpen: issue.dateAdded!);
          securityRR.add(newIssueComments);
        }
        if (issue.firstAidKitSafetyVest == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "First Aid Kit Safety Vest",
              dateAddedOpen: issue.dateAdded!);
          securityRR.add(newIssueComments);
        }
        if (issue.backUpAlarm == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Back Up Alarm",
              dateAddedOpen: issue.dateAdded!);
          securityRR.add(newIssueComments);
        }
      }

      // SecurityR
      for (Security issue in issueSecurityD) {
        if (issue.rtaMagnet == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "RTA Magnet",
              dateAddedOpen: issue.dateAdded!);
          securityDD.add(newIssueComments);
        }
        if (issue.triangleReflectors == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Triangle Reflectors",
              dateAddedOpen: issue.dateAdded!);
          securityDD.add(newIssueComments);
        }
        if (issue.wheelChocks == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Wheel Chocks",
              dateAddedOpen: issue.dateAdded!);
          securityDD.add(newIssueComments);
        }
        if (issue.fireExtinguisher == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Fire Extinguisher",
              dateAddedOpen: issue.dateAdded!);
          securityDD.add(newIssueComments);
        }
        if (issue.firstAidKitSafetyVest == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "First Aid Kit Safety Vest",
              dateAddedOpen: issue.dateAdded!);
          securityDD.add(newIssueComments);
        }
        if (issue.backUpAlarm == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Back Up Alarm",
              dateAddedOpen: issue.dateAdded!);
          securityDD.add(newIssueComments);
        }
      }

      print("Entro a getIssuesSecuurity");
    } catch (e) {
      print("Error in getIssuesSecuurity() - $e");
    }

    notifyListeners();
  }

  bool cambiovistaMeasures = true;
  // --------------------------------------------
  void clearListgetIssues() {
    bucketInspectionRR.clear();
    bucketInspectionDD.clear();
    carBodyWorkRR.clear();
    carBodyWorkDD.clear();
    equipmentRR.clear();
    equipmentDD.clear();
    extraRR.clear();
    extraDD.clear();
    lightsRR.clear();
    lightsDD.clear();
    fluidCheckRR.clear();
    fluidCheckDD.clear();
    lightsRR.clear();
    lightsDD.clear();
    measureRR.clear();
    measureDD.clear();
    securityRR.clear();
    securityDD.clear();
  }

  //---------------------------------------------
  Future<void> getIssues(IssuesXUser issuesXUser) async {
    // Limpiar listas
    clearListgetIssues();
    print("ENTRO EN GET ISSUES");
    //
    try {
      final res = await supabaseCtrlV
          .from('issues_view')
          .select()
          .eq('id_vehicle', issuesXUser.idVehicleFk)
          .eq('id_user_fk', issuesXUser.userProfileId)
          .or('issues_r.neq.0,issues_d.neq.0');

      issues = (res as List<dynamic>)
          .map((issues) => Issues.fromJson(jsonEncode(issues)))
          .toList();

      for (Issues issue in issues) {
        if (issue.issuesR != 0) {
          // Se verifica que bucketInspection Contentenga un valor en estado BAD
          if (issue.bucketInspectionR.toMap().containsValue("Bad")) {
            // ---------------------- bucketInspection_r ----------------------------//
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
          // menuIssuesReceived.update(0, (value) => bucketInspectionR);

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
          // menuIssuesReceived.update(1, (value) => carBodyWorkR);

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
          // menuIssuesReceived.update(2, (value) => equipmentR);

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
          // menuIssuesReceived.update(3, (value) => extraR);

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
          // menuIssuesReceived.update(4, (value) => fluidCheckR);

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
          // menuIssuesReceived.update(5, (value) => lightsR);

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
          // menuIssuesReceived.update(6, (value) => measureR);

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
        // menuIssuesReceived.update(7, (value) => securityR);

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
          // // // // menuIssuesReceivedD.update(0, (value) => bucketInspectionD);

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
          // // // // menuIssuesReceivedD.update(1, (value) => carBodyWorkD);

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
          // // // // menuIssuesReceivedD.update(2, (value) => equipmentD);

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
          // // // // menuIssuesReceivedD.update(3, (value) => extraD);

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
          // // // // menuIssuesReceivedD.update(4, (value) => measureD);

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
          // // // // menuIssuesReceivedD.update(5, (value) => fluidCheckD);

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
          // // // // menuIssuesReceivedD.update(6, (value) => lightsD);

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
      // // // // menuIssuesReceivedD.update(7, (value) => securityD);

      print("-----------------------------------");
      notifyListeners();
    } catch (e) {
      print("Error en getIssues - $e");
    }
  }

  //---------------------------------------------

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
      // print("Se entro a GETISSUESXUSERS");

      // print("Cuantos valores hay en issuesxUser: ${issuesxUser.length}");
      // print("Vehicle id: ${vehicle.idVehicle}");
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
    cellT2.value = "Inventory Reports";
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
    cell.value = "Id Vehicle";
    cell.cellStyle = cellStyle;

    var cell2 = sheet.cell(CellIndex.indexByString("B3"));
    cell2.value = "Make";
    cell2.cellStyle = cellStyle;

    var cell3 = sheet.cell(CellIndex.indexByString("C3"));
    cell3.value = "Model";
    cell3.cellStyle = cellStyle;

    var cell4 = sheet.cell(CellIndex.indexByString("D3"));
    cell4.value = "Year";
    cell4.cellStyle = cellStyle;

    var cell5 = sheet.cell(CellIndex.indexByString("E3"));
    cell5.value = "VIN";
    cell5.cellStyle = cellStyle;

    var cell6 = sheet.cell(CellIndex.indexByString("F3"));
    cell6.value = "License Plates";
    cell6.cellStyle = cellStyle;

    var cell7 = sheet.cell(CellIndex.indexByString("G3"));
    cell7.value = "Motor";
    cell7.cellStyle = cellStyle;

    var cell8 = sheet.cell(CellIndex.indexByString("H3"));
    cell8.value = "Color";
    cell8.cellStyle = cellStyle;

    var cell9 = sheet.cell(CellIndex.indexByString("I3"));
    cell9.value = "Status";
    cell9.cellStyle = cellStyle;

    var cell10 = sheet.cell(CellIndex.indexByString("J3"));
    cell10.value = "Company";
    cell10.cellStyle = cellStyle;

    var cell11 = sheet.cell(CellIndex.indexByString("K3"));
    cell11.value = "Date Added";
    cell11.cellStyle = cellStyle;

    var cell12 = sheet.cell(CellIndex.indexByString("L3"));
    cell12.value = "Oil Change Due";
    cell12.cellStyle = cellStyle;

    var cell13 = sheet.cell(CellIndex.indexByString("M3"));
    cell13.value = "Last Transmission Fluid Change";
    cell13.cellStyle = cellStyle;

    var cell14 = sheet.cell(CellIndex.indexByString("N3"));
    cell14.value = "Last Radiator Fluid Change";
    cell14.cellStyle = cellStyle;

    var cell15 = sheet.cell(CellIndex.indexByString("O3"));
    cell15.value = "Issues Received";
    cell15.cellStyle = cellStyle;

    var cell16 = sheet.cell(CellIndex.indexByString("P3"));
    cell16.value = "Issues Delivered";
    cell16.cellStyle = cellStyle;
    //Agregar headers
    // sheet.appendRow([
    //   'status',
    //   'company',
    //   'date_Added',
    //   'oil_change_due',
    //   'Last transmission fluid change:',
    //   'Last radiator fluid change:'
    // ]);

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
        DateFormat("MMM/dd/yyyy").format(report.dateAdded),
        DateFormat("MMM/dd/yyyy").format(report.oilChangeDue),
        DateFormat("MMM/dd/yyyy").format(report.lastRadiatorFluidChange),
        DateFormat("MMM/dd/yyyy").format(report.lastTransmissionFluidChange),
        report.issuesR,
        report.issuesD
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
