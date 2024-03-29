import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/functions/date_format.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/company_api.dart';
import 'package:rta_crm_cv/models/issues_comments.dart';
import 'package:rta_crm_cv/models/issues_open_close.dart';
import 'package:rta_crm_cv/models/service_api.dart';
import 'package:rta_crm_cv/models/status_api.dart';
import 'package:rta_crm_cv/models/vehicle.dart';
import 'package:excel/excel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../helpers/constants.dart';
import '../../models/issues.dart';
import '../../models/issues_dashboards.dart' as issue_dashboard;
import '../../models/issues_x_user.dart';
import '../../models/ownership.dart';
import '../../models/problem.dart';
import '../../models/services.dart';
import '../../models/vehicle_dashboard.dart';

class InventoryProvider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  PlutoGridStateManager? stateManagerService;

  List<PlutoRow> rows = [];
  List<PlutoRow> rowsService = [];

  //------------------------------------------
  // Controllers para Alta Inventario
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController vinController = TextEditingController();
  TextEditingController plateNumberController = TextEditingController();
  TextEditingController versionMotorController = TextEditingController();
  int colorController = 0xffffffff;
  TextEditingController dateTimeControllerOil = TextEditingController();
  TextEditingController dateTimeControllerRFC = TextEditingController();
  TextEditingController dateTimeControllerLTFC = TextEditingController();
  TextEditingController serviceDateController = TextEditingController();
  TextEditingController serviceDateControllerAvailable =
      TextEditingController();
  TextEditingController? nextDateController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController mileageController = TextEditingController();
  TextEditingController dateTimeControllerLTireChange = TextEditingController();
  TextEditingController dateTimeControllerLBrakeChange =
      TextEditingController();

  // Controllers para exportar datos
  TextEditingController dateExportDataController = TextEditingController();
  TextEditingController dateExportVehicleDataFirstController =
      TextEditingController();
  TextEditingController dateExportVehicleDataLastController =
      TextEditingController();

  var cardMaskMileage =
      CurrencyTextInputFormatter(symbol: '', name: '', decimalDigits: 0);

  String companySel = "All";
  DateTime newDate = DateTime.now();
  String? vehicleSel;
  String? motorSel;
  List<String> plates = [];
  DateTime firstSel = DateTime.now();
  DateTime lastSel = DateTime.now();
  int confirmacion = 0;
  bool archivardesarchivar = true;
  List<issue_dashboard.IssuesDashboards> issuesDashboards = [];

  // Controllers para el Update Inventario
  TextEditingController makeControllerUpdate = TextEditingController();
  TextEditingController modelControllerUpdate = TextEditingController();
  TextEditingController vinControllerUpdate = TextEditingController();
  TextEditingController plateNumberControllerUpdate = TextEditingController();
  TextEditingController motorControllerUpadte = TextEditingController();
  TextEditingController versionControllerUpdate = TextEditingController();

  int colorControllerUpdate = 0xffffffff;
  TextEditingController dateTimeControllerOilUpdate = TextEditingController();
  TextEditingController dateTimeControllerRFCUpadte = TextEditingController();
  TextEditingController dateTimeControllerLTFCUpadte = TextEditingController();
  TextEditingController searchControllerUpadte = TextEditingController();
  TextEditingController yearControllerUpdate = TextEditingController();
  TextEditingController colorControllers = TextEditingController();
  TextEditingController mileageControllerUpdate = TextEditingController();
  TextEditingController problemControllerUpdate = TextEditingController();
  TextEditingController dateTimeControllerLTireChangeUpdate =
      TextEditingController();
  TextEditingController dateTimeControllerLBrakeChangeUpdate =
      TextEditingController();
  bool visibilty = false;
  //------------------------------------------
  //Función del updateState
  Future<void> updateState() async {
    rows.clear();
    await getInventory();
  }

  Future<void> updateStateNotActive() async {
    rows.clear();
    await updateStatusVehicle();
  }

  Future<void> updateStateService() async {
    ////print("Se hizo el updateStateService");
    rowsService.clear();
    await getServicesPage();
  }

  void clearControllerService() {
    serviceSelected = null;
    serviceDateController.clear();
  }

  void clearControllerExportData({bool notify = true}) {
    dateExportDataController.clear();
    companySel = "All";
    if (notify) notifyListeners();
  }

  // Variables Individuales
  String? imageName;
  String? imageUrl;
  String? imageUrlUpdate;
  Uint8List? webImage;
  Uint8List? webImageClear;
  String? placeHolderImage;
  int? idActualProblem;

  String? imagepicked;
  IssuesXUser? actualIssueXUser;
  IssuesComments? actualissuesComments;
  Vehicle? actualVehicle;
  int idvehicle = 16;
  Uuid uuid = const Uuid();
  String? colorString = "0xffffffff";
  int pageRowCount = 9;
  int page = 1;
  int pageRowCountService = 9;
  int pageService = 1;

// ------------ Variables de los Modelos ---------------

  List<String> dropdownMenuItems = [];
  StatusApi? statusSelected;
  CompanyApi? companySelected;
  Services? serviceSelected;
  StatusApi? statusSelectedUpdate;
  CompanyApi? companySelectedUpdate;
  IssuesComments? registroIssueComments;
  ServicesApi? servicesApi;
  Ownership? ownershipSelected;
  Ownership? ownershipSelectedUpdate;

//------------------------------------------

  // Lista de Modelos
  List<CompanyApi> company = [];
  List<StatusApi> status = [];
  List<Services> service = [];
  List<Vehicle> vehicles = [];
  List<Ownership> ownerships = [];
  List<ServicesApi> services = [];
  List<Issues> issues = [];
  List<Problem> problems = [];
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

  // Listas R Listas para tener color en excel
  List<IssuesComments> bucketInspectionR = [];
  List<IssueOpenclose> bucketInspectionRR = [];
  List<IssueOpenclose> carBodyWorkRR = [];
  List<IssueOpenclose> equipmentRR = [];
  List<IssueOpenclose> extraRR = [];
  List<IssueOpenclose> fluidCheckRR = [];
  List<IssueOpenclose> lightsRR = [];
  List<IssueOpenclose> measureRR = [];
  List<IssueOpenclose> securityRR = [];

  List<bool> indexSelected = [
    true, //General Information
    false, //Issues
    false, //Service
  ];
  List<bool> indexSelectedIssue = [
    true, //Fluids check
    false, //Car Bodywork
    false, //Equipment
    false, //Extra
    false, // Bucket Inspection
    false, // Lights
    false, // Measures
    false, // Security
  ];
  // Listas D listas para comparar y tener color en excel
  List<IssuesComments> bucketInspectionD = [];
  List<IssueOpenclose> bucketInspectionDD = [];
  List<IssueOpenclose> carBodyWorkDD = [];
  List<IssueOpenclose> equipmentDD = [];
  List<IssueOpenclose> extraDD = [];
  List<IssueOpenclose> fluidCheckDD = [];
  List<IssueOpenclose> lightsDD = [];
  List<IssueOpenclose> measureDD = [];
  List<IssueOpenclose> securityDD = [];

  List<IssueOpenclose> listaTotalIssues = [];

//--------------------------------------------
  //Variables para banderas de de excel
  bool bucketInspectR = true;
  bool? bucketInspectD;
  bool carBodyInspectR = true;
  bool? carBodyInspectD;
  bool equipmentInspectR = true;
  bool? equipmentInspectD;
  bool extraInspectR = true;
  bool? extraInspectD;
  bool fluidCheckInspectR = true;
  bool? fluidCheckInspectD;
  bool ligthsInspectR = true;
  bool? ligthsInspectD;
  bool measureInspectR = true;
  bool? measureInspectD;
  bool securityInspectR = true;
  bool? securityInspectD;

  Issues? issue;

  bool? diaSelected;
  int issueR = 0;
  int issueD = 0;

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
  // Funcion para el cambio de vista  de Issues
  bool vistaIssues = true;
  void cambioVistaIssues() {
    vistaIssues = !vistaIssues;
    notifyListeners();
  }

//------------------------------------------
  // Variables para el Control de cambio de vista de photos and comments
  bool vistaPhotosComments = true;
  void cambiosVistaPhotosComments() {
    vistaPhotosComments = !vistaPhotosComments;
    notifyListeners();
  }

//------------------------------------------
  // Función para seleccionar el vehiculo y no tener que heredar
  void selectVehicle(Vehicle vehicle, {bool notify = true}) {
    actualVehicle = vehicle;
    if (notify) notifyListeners();
  }

  // Función para seleccionar el IssueXUser
  void selectIssuesXUser(int index) {
    actualIssueXUser = issuesxUser[index];
    notifyListeners();
  }

  void setIndex(int index) {
    for (var i = 0; i < indexSelected.length; i++) {
      indexSelected[i] = false;
    }
    indexSelected[index] = true;
    // switch (index) {
    //   case 0:
    //     await getVehicle(actualVehicle!);
    //     break;
    // }
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
  // ------------------------ service ---------------------------------

  void setPageSizeService(String x) {
    switch (x) {
      case 'more':
        if (pageRowCountService < rowsService.length) pageRowCountService++;
        break;
      case 'less':
        if (pageRowCountService > 1) pageRowCountService--;
        break;
      default:
        return;
    }
    stateManagerService!.createFooter;
    notifyListeners();
  }

  void setPageService(String x) {
    switch (x) {
      case 'next':
        if (pageService < stateManagerService!.totalPage) pageService++;
        break;
      case 'previous':
        if (pageService > 1) pageService--;
        break;
      case 'start':
        pageService = 1;
        break;
      case 'end':
        pageService = stateManagerService!.totalPage;
        break;
      default:
        return;
    }
    stateManagerService!.setPage(page);
    notifyListeners();
  }

  void loadService() {
    stateManagerService!.setShowLoading(true);
  }

  void setIndexIssue(int index) async {
    for (var i = 0; i < indexSelectedIssue.length; i++) {
      indexSelectedIssue[i] = false;
    }
    indexSelectedIssue[index] = true;

    notifyListeners();
  }

  void getProblemVehicle(Vehicle vehicle) async {
    try {
      final res = await supabaseCtrlV
          .from('problems')
          .select()
          .eq("resolved", false)
          .eq("id_vehicle_fk", vehicle.idVehicle);
      // print(res);
      problems = (res as List<dynamic>)
          .map((prob) => Problem.fromJson(jsonEncode(prob)))
          .toList();

      if (problems.isNotEmpty) {
        print(problems.last.problem);
        idActualProblem = problems.last.idProblem;
        print("El idActualproblem es $idActualProblem");
        print(
            "El ID del  vehiculo con problemas es: ${problems.last.idVehicleFk}");
      } else {
        print("The list of problems are EMPTY");
      }
      notifyListeners();
    } catch (e) {
      print("Error in getProblemVehicle $e");
    }
  }

  // Función para hacerle Update a los controladores
  void updateInventoryControllers(Vehicle vehicle) {
    makeControllerUpdate.text = vehicle.make;
    modelControllerUpdate.text = vehicle.model;
    vinControllerUpdate.text = vehicle.vin;
    plateNumberControllerUpdate.text = vehicle.licesensePlates;

    final splitvehicle = vehicle.motor.split(" ");
    motorControllerUpadte.text = splitvehicle[0];
    versionControllerUpdate.text =
        splitvehicle.length == 1 ? '' : splitvehicle[1];
    yearControllerUpdate.text = vehicle.year.toString();
    statusSelectedUpdate = statusSelected;
    imageUrlUpdate = vehicle.image == null
        ? "$supabaseUrl/storage/v1/object/public/assets/Vehicles/"
        : vehicle.image!.replaceAll(
            "$supabaseUrl/storage/v1/object/public/assets/Vehicles/", "");

    colorControllerUpdate = colorController;
    colorControllers.text = colorController.toString();
    companySelectedUpdate = companySelected;
    dateTimeControllerOilUpdate.text = vehicle.oilChangeDue == null
        ? ""
        : DateFormat("MMM/dd/yyyy").format(vehicle.oilChangeDue!);
    dateTimeControllerRFCUpadte.text = vehicle.lastRadiatorFluidChange == null
        ? ""
        : DateFormat("MMM/dd/yyyy").format(vehicle.lastRadiatorFluidChange!);
    dateTimeControllerLTFCUpadte.text =
        vehicle.lastTransmissionFluidChange == null
            ? ""
            : DateFormat("MMM/dd/yyyy")
                .format(vehicle.lastTransmissionFluidChange!);
    mileageControllerUpdate.text =
        NumberFormat('#,###').format(vehicle.mileage);
    // vehicle.mileage.toString();
  }

  // Función para hacerle update a la Imagen
  Future<bool> updateImage() async {
    // Enviar la segunda
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    webImage = await pickedImage?.readAsBytes();

    if (pickedImage != null) {
      if (await pickedImage.length() <= 1000000) {
        final String? placeHolderImage;
        notifyListeners();
        placeHolderImage = "${uuid.v4()}${pickedImage.name}";

        final storageResponse =
            await supabase.storage.from('assets/Vehicles').uploadBinary(
                  placeHolderImage,
                  webImage!,
                  fileOptions: const FileOptions(
                    cacheControl: '3600',
                    upsert: false,
                  ),
                );

        if (storageResponse.isNotEmpty) {
          imageUrl = supabase.storage.from('assets/Vehicles').getPublicUrl(
                placeHolderImage,
              );
        }
        return true;
      } else {
        return false;
      }
    }
    return false;
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
        notifyListeners();
        placeHolderImage = "${uuid.v4()}${pickedImage.name}";

        // final storageResponse =
        //     await supabase.storage.from('assets/Vehicles').uploadBinary(
        //           placeHolderImage,
        //           webImage!,
        //           fileOptions: const FileOptions(
        //             cacheControl: '3600',
        //             upsert: false,
        //           ),
        //         );

        // if (storageResponse.isNotEmpty) {
        //   imageUrl = supabase.storage.from('assets/Vehicles').getPublicUrl(
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

  Future<void> uploadImage() async {
    try {
      final storageResponse =
          await supabase.storage.from('assets/Vehicles').uploadBinary(
                placeHolderImage!,
                webImage!,
                fileOptions: const FileOptions(
                  cacheControl: '3600',
                  upsert: false,
                ),
              );

      if (storageResponse.isNotEmpty) {
        imageUrl = supabase.storage.from('assets/Vehicles').getPublicUrl(
              placeHolderImage!,
            );
      }

      // return imageName;
    } catch (e) {
      log('Error in uploadImage() - $e');
      // return null;
    }
  }

  Future<void> deleteImage() async {
    // Eliminar la imagen Anterior
    try {
      if (imageUrlUpdate != null) {
        final List<FileObject> oldImage = await supabase.storage
            .from('assets')
            .remove(['Vehicles/${imageUrlUpdate!}']);
        if (oldImage.isEmpty) return;
      }
    } catch (e) {
      //print("Error in deleteImage $e");
    }
  }

  // Función para obtener las companias de la base de datos
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

  // Función para obtener los servicios de la base de datos
  Future<void> getServices({bool notify = true}) async {
    final res = await supabaseCtrlV
        .from('services')
        .select()
        .order('service', ascending: true);
    //print("Entro a getServices()");
    service = (res as List<dynamic>)
        .map((service) => Services.fromJson(jsonEncode(service)))
        .toList();
    if (notify) notifyListeners();
  }

  // Función para obtener el status de la base de datos
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

  // Función para obtener los ownership
  Future<void> getOwnerShip({bool notify = true}) async {
    final res = await supabaseCtrlV.from('ownership').select().order(
          'ownership',
          ascending: true,
        );
    ownerships = (res as List<dynamic>)
        .map((owner) => Ownership.fromJson(jsonEncode(owner)))
        .toList();

    if (notify) notifyListeners();
  }

//---------------------------------------------
  // Función para cuando seleciconamos la compania en la alta de vehiculos
  void selectCompany(String companys) {
    companySelected = company.firstWhere((elem) => elem.company == companys);
    notifyListeners();
  }

  // Función para cuando seleccionamos el estatus en la alta de vehiculos
  void selectStatu(String statu) {
    statusSelected = status.firstWhere((elem) => elem.status == statu);
    notifyListeners();
  }

  void selectOwner(String owner) {
    ownershipSelected =
        ownerships.firstWhere((elem) => elem.ownership == owner);
    notifyListeners();
  }

  void selectMotor(String motor) {
    motorSel = motor;
    notifyListeners();
  }

  // Función para cuando actualizamos la compania en la actualización del vehiculo
  void selectCompanyUpdate(String companys) {
    companySelectedUpdate =
        company.firstWhere((elem) => elem.company == companys);
    notifyListeners();
  }

  // Función para cuando actualizamos el ownership en la actualización del vehiculo
  void selectOwnershipUpdate(String ownershipval) {
    ownershipSelectedUpdate =
        ownerships.firstWhere((elem) => elem.ownership == ownershipval);
    notifyListeners();
  }

  // Función para cuando actualizamos el estatus en la actualización del vehiculo
  void selectStatUpdate(String statu) {
    statusSelectedUpdate = status.firstWhere((elem) => elem.status == statu);
    notifyListeners();
  }

  // Función cuando seleccionamos el servicio en la alta de servicios
  void selectService(String servicesvar) {
    serviceSelected = service.firstWhere((elem) => elem.service == servicesvar);
    notifyListeners();
  }

  // Función par actualizar el color
  void updateColor(int colors, String colorStrings) {
    colorController = colors;
    colorControllerUpdate = colors;

    //colorString = "0xffffffff";
    colorString = colorStrings;
    notifyListeners();
  }

  // Función para inicializar el color
  void inicializeColor(Vehicle vehicle) {
    colorController = int.parse(vehicle.color);
    //colorString = "0xffffffff";
    colorString = colorController.toString();
    notifyListeners();
  }

  // Función para inicializar la imagen
  void inicializeImage(Vehicle vehicle) {
    webImage = null;
    notifyListeners();
  }

  // Función para hacerle update al Vehiculo
  Future<bool> updateVehicle(Vehicle vehicle) async {
    try {
      final motorVer = motorSel ?? motorControllerUpadte.text;
      await supabaseCtrlV.from('vehicle').update({
        'make': makeControllerUpdate.text,
        'model': modelControllerUpdate.text,
        'year': yearControllerUpdate.text,
        'vin': vinControllerUpdate.text,
        'license_plates': plateNumberControllerUpdate.text,
        'motor': '$motorVer ${versionControllerUpdate.text}',
        'color': colorString ?? vehicle.color,
        'id_status_fk':
            statusSelectedUpdate?.statusId ?? vehicle.status.statusId,
        'id_company_fk':
            companySelectedUpdate?.companyId ?? vehicle.company.companyId,
        'id_ownership_fk': ownershipSelectedUpdate?.idOwnership ??
            vehicle.ownership.idOwnership,
        'image': imageUrl ?? vehicle.image,
        'date_added': DateTime.now().toIso8601String(),
        'oil_change_due': dateTimeControllerOilUpdate.text == ""
            ? null
            : dateTimeControllerOilUpdate.text,
        'last_radiator_fluid_change': dateTimeControllerRFCUpadte.text == ""
            ? null
            : dateTimeControllerRFCUpadte.text,
        'last_transmission_fluid_change':
            dateTimeControllerLTFCUpadte.text == ""
                ? null
                : dateTimeControllerLTFCUpadte.text,
        'last_tire_change': dateTimeControllerLTireChangeUpdate.text == ""
            ? null
            : dateTimeControllerLTireChangeUpdate.text,
        'last_brake_change': dateTimeControllerLBrakeChangeUpdate.text == ""
            ? null
            : dateTimeControllerLBrakeChangeUpdate.text,
        'mileage': int.parse(mileageControllerUpdate.text.replaceAll(",", "")),
        //(registroIssueComments!.nameIssue)
      }).eq("id_vehicle", vehicle.idVehicle);
      return true;
    } catch (e) {
      print('Error in updatevehicle() - $e');
      return false;
    }
  }

  // Función para eliminar un vehiculo
  Future<bool> deleteVehicle(Vehicle vehicle) async {
    try {
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

  // Función para crear el servicio del vehiculo
  Future<bool> createVehicleService() async {
    try {
      await supabaseCtrlV.from('vehicle_services').insert({
        'created_at': DateTime.now().toIso8601String(),
        'id_vehicle_fk': actualVehicle!.idVehicle,
        'id_service_fk': serviceSelected?.idService,
        'service_date': serviceDateController.text,
      });
      notifyListeners();

      return true;
    } catch (e) {
      //print("Error in createVehicleService() - $e");
      //print(actualVehicle!.idVehicle);
      return false;
    }
  }

  // Función para crear el problema
  Future<bool> createVehicleProblem(Vehicle vehicle) async {
    try {
      if (statusSelectedUpdate!.statusId == 2 ||
          statusSelectedUpdate!.statusId == 4) {
        await supabaseCtrlV.from('problems').insert({
          'created_at': DateTime.now().toIso8601String(),
          'problem': problemControllerUpdate.text,
          'vehicle_status': statusSelectedUpdate!.status,
          'resolved': false,
          'id_vehicle_fk': vehicle.idVehicle,
        });
      } else if (statusSelectedUpdate!.statusId == 3) {
        await supabaseCtrlV.from('problems').insert({
          'created_at': DateTime.now().toIso8601String(),
          'problem': problemControllerUpdate.text,
          'vehicle_status': statusSelectedUpdate!.status,
          'resolved': true,
          'id_vehicle_fk': vehicle.idVehicle,
          'resolved_date': serviceDateControllerAvailable.text
        });
        await supabaseCtrlV.from('problems').update({
          'resolved': true,
        }).eq('id_problem', idActualProblem);
      }
      notifyListeners();

      return true;
    } catch (e) {
      print("Error in createVehicleProblem() - $e");
      //print(actualVehicle!.idVehicle);
      return false;
    }
  }

  // Función para traer la pagina de servicios
  Future<void> getServicesPage() async {
    try {
      final res = await supabaseCtrlV
          .from('service_view')
          .select()
          .match({"id_vehicle_fk": actualVehicle!.idVehicle});
      services = (res as List<dynamic>)
          .map((services) => ServicesApi.fromJson(jsonEncode(services)))
          .toList();
      // final serviceList = res as List<dynamic>;
      rowsService.clear();
      for (ServicesApi service in services) {
        rowsService.add(
          PlutoRow(
            cells: {
              "service": PlutoCell(value: service.servicex.service.toString()),
              "serviceDate": PlutoCell(
                  value: service.serviceDate == null
                      ? " No Date "
                      : DateFormat("MMM/dd/yyyy")
                          .format(service.serviceDate!)
                          .toString()),
              "completed": PlutoCell(value: service.completed),
            },
          ),
        );
      }
      //print("Entro a getServicesPage()");
    } catch (e) {
      //print("Error in getServicesPage() - $e");
    }
    notifyListeners();
  }

  // Función para crear un vehiculo
  Future<bool> createVehicleInventory() async {
    try {
      Map<String, dynamic> lastMileageService = {
        "Value": "300000",
        "Registered": "False",
        "Last Mileage Service": mileageController.text.replaceAll(",", ""),
      };
      Map<String, dynamic> ruleTransmissionService = {
        "Value": "100000",
        "Registered": "False",
        "Last Mileage Service": mileageController.text.replaceAll(",", ""),
      };
      Map<String, dynamic> ruleRadiatorService = {
        "Value": "20000",
        "Registered": "False",
        "Last Mileage Service": mileageController.text.replaceAll(",", ""),
      };
      Map<String, dynamic> ruletirechangeService = {
        "Value": "50000",
        "Registered": "False",
        "Last Mileage Service": mileageController.text.replaceAll(",", ""),
      };
      Map<String, dynamic> rulebrakechangeService = {
        "Value": "20000",
        "Registered": "False",
        "Last Mileage Service": mileageController.text.replaceAll(",", ""),
      };
      final id = await supabaseCtrlV.from('vehicle').insert(
        {
          'make': brandController.text,
          'model': modelController.text,
          'year': yearController.text,
          'vin': vinController.text,
          'license_plates': plateNumberController.text,
          'motor': '$motorSel ${versionMotorController.text}',
          'color': colorString,
          'image': imageUrl,
          'id_status_fk': statusSelected?.statusId,
          'id_company_fk': companySelected?.companyId,
          'id_ownership_fk': ownershipSelected?.idOwnership,
          'date_added': DateTime.now().toIso8601String(),
          'oil_change_due': dateTimeControllerOil.text == ""
              ? null
              : dateTimeControllerOil.text,
          'last_radiator_fluid_change': dateTimeControllerRFC.text == ""
              ? null
              : dateTimeControllerRFC.text,
          'last_transmission_fluid_change': dateTimeControllerLTFC.text == ""
              ? null
              : dateTimeControllerLTFC.text,
          'last_tire_change': dateTimeControllerLTireChange.text == ""
              ? null
              : dateTimeControllerLTireChange.text,
          'last_brake_change': dateTimeControllerLBrakeChange.text == ""
              ? null
              : dateTimeControllerLBrakeChange.text,
          'mileage': mileageController.text.replaceAll(",", ""),
          'rule_oil_change': lastMileageService,
          'rule_transmission_fluid_change': ruleTransmissionService,
          'rule_radiator_fluid_change': ruleRadiatorService,
          'rule_tire_change': ruletirechangeService,
          'rule_brake_change': rulebrakechangeService
        },
      ).select<PostgrestList>('id_vehicle');

      // Aqui estamos comprobando si el status del vehiculo que se va a crear es en Repair o en NotFuncional, para poder enviar el problema
      if (statusSelected?.statusId == 2 || statusSelected?.statusId == 4) {
        await supabaseCtrlV.from('problems').insert({
          'created_at': DateTime.now().toIso8601String(),
          'problem': problemControllerUpdate.text,
          'vehicle_status': statusSelected!.status,
          'resolved': false,
          'id_vehicle_fk': id.first["id_vehicle"],
        });
      }
      return true;
    } catch (e) {
      print('Error in createVehicleInventory() - $e');
      return false;
    }
  }

  Future<void> getVehicle(Vehicle vehicle) async {
    try {
      await supabaseCtrlV
          .from("vehicle")
          .select()
          .eq('id_vehicle', vehicle.idVehicle);
    } catch (e) {
      //print("Error in GetVehicle() $e");
    }
  }

  bool bandera1 = true;
  // Función para cambiar el estatus del vehiculo
  Future<void> changeStatusInventory(Vehicle vehicle) async {
    try {
      final res = await supabaseCtrlV
          .from("vehicle")
          .update({'id_status_fk': 4}).eq('id_vehicle', vehicle.idVehicle);

      vehicles = (res as List<dynamic>)
          .map((vehicles) => Vehicle.fromJson(jsonEncode(vehicles)))
          .toList();
    } catch (e) {
      //print("Error in changeStatusInventory() - $e");
    }
    notifyListeners();
  }

  Future<void> changeStatusInventoryBackToActive(Vehicle vehicle) async {
    try {
      final res = await supabaseCtrlV
          .from("vehicle")
          .update({'id_status_fk': 3}).eq('id_vehicle', vehicle.idVehicle);

      vehicles = (res as List<dynamic>)
          .map((vehicles) => Vehicle.fromJson(jsonEncode(vehicles)))
          .toList();
    } catch (e) {
      //print("Error in changeStatusInventoryBackToActive() - $e");
    }
    notifyListeners();
  }

  // Función para traernos los vehiculos
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
          .not('status->>id_status', 'eq', 4)
          // .not('status', 'eq', 'Not Functional')
          .order('license_plates', ascending: true);

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
      rows.clear();

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
              "make": PlutoCell(value: vehicle.make),
              "model": PlutoCell(value: vehicle.model),
              "year": PlutoCell(value: vehicle.year),
              "vin": PlutoCell(value: vehicle.vin),
              "license_plates": PlutoCell(value: vehicle.licesensePlates),
              "motor": PlutoCell(value: vehicle.motor),
              "status": PlutoCell(value: vehicle.status.status),
              "company": PlutoCell(value: vehicle.company.company),
              "mileage": PlutoCell(
                  value: cardMaskMileage.format(vehicle.mileage.toString())),
              "actions": PlutoCell(value: vehicle),
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

  // Función para mostrar los vehiculos con estatus NO ACTIVO
  Future<void> updateStatusVehicle() async {
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
          .eq('status->>id_status', 4);
      // .eq('statusname', 'Not Functional');

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
              "make": PlutoCell(value: vehicle.make),
              "model": PlutoCell(value: vehicle.model),
              "year": PlutoCell(value: vehicle.year),
              "vin": PlutoCell(value: vehicle.vin),
              "license_plates": PlutoCell(value: vehicle.licesensePlates),
              "motor": PlutoCell(value: vehicle.motor),
              "status": PlutoCell(value: vehicle.status.status),
              "company": PlutoCell(value: vehicle.company.company),
              "mileage": PlutoCell(
                  value: NumberFormat('#,###').format(vehicle.mileage)),
              "actions": PlutoCell(value: vehicle),
            },
          ),
        );
      }

      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getInventoryNotActive() - $e');
    }
    notifyListeners();
  }

  // Función para ver los vehiculos archivados
  Future<void> getArchiveVehicle() async {
    try {
      final res = await supabaseCtrlV
          .from('vehicle')
          .select()
          .match({'id_status_fk': 4.toString()});
      // //print(res);

      // AQUI está el fallo
      vehicleArchive = (res as List<dynamic>)
          .map((vehicleArchive) =>
              VehicleDash.fromJson(jsonEncode(vehicleArchive)))
          .toList();
    } catch (e) {
      //print("Error en getArchiveVehicle - $e");
    }
  }

  // EXCEL
  Future<bool> excelActivityReports(DateTime dateSelected, String comp) async {
    //Crear excel
    Excel excel = Excel.createExcel();
    Sheet? sheet = excel.sheets[excel.getDefaultSheet()];
    List<Vehicle> selectedComp = [];

    //TITULO
    sheet?.merge(CellIndex.indexByString("B1"), CellIndex.indexByString("C1"));
    //Headers de la Tabla
    sheet?.merge(CellIndex.indexByString("A3"), CellIndex.indexByString("A4"));
    sheet?.merge(CellIndex.indexByString("B3"), CellIndex.indexByString("B4"));
    sheet?.merge(CellIndex.indexByString("C3"), CellIndex.indexByString("C4"));
    sheet?.merge(CellIndex.indexByString("D3"), CellIndex.indexByString("D4"));
    sheet?.merge(CellIndex.indexByString("E3"), CellIndex.indexByString("E4"));
    sheet?.merge(CellIndex.indexByString("F3"), CellIndex.indexByString("F4"));
    sheet?.merge(CellIndex.indexByString("G3"), CellIndex.indexByString("G4"));
    sheet?.merge(CellIndex.indexByString("H3"), CellIndex.indexByString("H4"));
    sheet?.merge(CellIndex.indexByString("I3"), CellIndex.indexByString("I4"));
    sheet?.merge(CellIndex.indexByString("J3"), CellIndex.indexByString("J4"));
    sheet?.merge(CellIndex.indexByString("K3"), CellIndex.indexByString("K4"));
    sheet?.merge(CellIndex.indexByString("L3"), CellIndex.indexByString("L4"));
    sheet?.merge(CellIndex.indexByString("M3"), CellIndex.indexByString("M4"));
    sheet?.merge(CellIndex.indexByString("N3"), CellIndex.indexByString("N4"));
    sheet?.merge(CellIndex.indexByString("O3"), CellIndex.indexByString("O4"));
    sheet?.merge(CellIndex.indexByString("P3"), CellIndex.indexByString("P4"));
    //Headers para secciones
    sheet?.merge(CellIndex.indexByString("Q3"), CellIndex.indexByString("X3"));
    sheet?.merge(CellIndex.indexByString("Y3"), CellIndex.indexByString("AF3"));

    sheet?.setColWidth(4, 25);
    sheet?.setColWidth(5, 30);
    sheet?.setColWidth(11, 50);
    sheet?.setColWidth(12, 50);
    sheet?.setColWidth(13, 50);
    sheet?.setColWidth(14, 25);
    sheet?.setColWidth(15, 30);
    sheet?.setColWidth(18, 30);
    sheet?.setColWidth(20, 30);
    sheet?.setColWidth(26, 30);
    sheet?.setColWidth(28, 30);

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
    cellD2.value = dateFormat(dateSelected);
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
    cell15.value = "Issues Check Out";
    cell15.cellStyle = cellStyle;

    var cell16 = sheet.cell(CellIndex.indexByString("P3"));
    cell16.value = "Issues Check In";
    cell16.cellStyle = cellStyle;

    //Seccion Titulos
    var cell17 = sheet.cell(CellIndex.indexByString("Q3"));
    cell17.value = "Check Out";
    cell17.cellStyle = cellStyle;

    var cell19 = sheet.cell(CellIndex.indexByString("Y3"));
    cell19.value = "Check In";
    cell19.cellStyle = cellStyle;

    //Secciones Check Out
    var cell20 = sheet.cell(CellIndex.indexByString("Q4"));
    cell20.value = "Measures";
    cell20.cellStyle = cellStyle;
    var cell21 = sheet.cell(CellIndex.indexByString("R4"));
    cell21.value = "Lights";
    cell21.cellStyle = cellStyle;
    var cell22 = sheet.cell(CellIndex.indexByString("S4"));
    cell22.value = "Car Bodywork";
    cell22.cellStyle = cellStyle;
    var cell23 = sheet.cell(CellIndex.indexByString("T4"));
    cell23.value = "Fluid Check";
    cell23.cellStyle = cellStyle;
    var cell24 = sheet.cell(CellIndex.indexByString("U4"));
    cell24.value = "Bucket Inspection";
    cell24.cellStyle = cellStyle;
    var cell25 = sheet.cell(CellIndex.indexByString("V4"));
    cell25.value = "Security";
    cell25.cellStyle = cellStyle;
    var cell26 = sheet.cell(CellIndex.indexByString("W4"));
    cell26.value = "Extra";
    cell26.cellStyle = cellStyle;
    var cell27 = sheet.cell(CellIndex.indexByString("x4"));
    cell27.value = "Equipment";

    //Secciones Check In
    cell27.cellStyle = cellStyle;
    var cell28 = sheet.cell(CellIndex.indexByString("Y4"));
    cell28.value = "Measures";
    cell28.cellStyle = cellStyle;
    var cell29 = sheet.cell(CellIndex.indexByString("Z4"));
    cell29.value = "Lights";
    cell29.cellStyle = cellStyle;
    var cell30 = sheet.cell(CellIndex.indexByString("AA4"));
    cell30.value = "Car Bodywork";
    cell30.cellStyle = cellStyle;
    var cell31 = sheet.cell(CellIndex.indexByString("AB4"));
    cell31.value = "Fluid Check";
    cell31.cellStyle = cellStyle;
    var cell32 = sheet.cell(CellIndex.indexByString("AC4"));
    cell32.value = "Bucket Inspection";
    cell32.cellStyle = cellStyle;
    var cell33 = sheet.cell(CellIndex.indexByString("AD4"));
    cell33.value = "Security";
    cell33.cellStyle = cellStyle;
    var cell34 = sheet.cell(CellIndex.indexByString("AE4"));
    cell34.value = "Extra";
    cell34.cellStyle = cellStyle;
    var cell35 = sheet.cell(CellIndex.indexByString("AF4"));
    cell35.value = "Equipment";
    cell35.cellStyle = cellStyle;

    //sortear por su Id
    vehicles.sort((a, b) => a.idVehicle.compareTo(b.idVehicle));

    if (comp != "All") {
      for (int x = 0; x < vehicles.length; x++) {
        if (vehicles[x].company.company == comp) {
          selectedComp.add(vehicles[x]);
        }
      }
    } else {
      selectedComp = vehicles;
    }
    //Agregar datos
    for (int i = 0; i < selectedComp.length; i++) {
      issueR = 0;
      issueD = 0;
      String measureCheckOut = "";
      String lightsCheckOut = "";
      String bodyWorkCheckOut = "";
      String fluidCheckOut = "";
      String bucketCheckOut = "";
      String securityCheckOut = "";
      String extraCheckOut = "";
      String equipmentCheckOut = "";

      String measureCheckIn = "";
      String lightsCheckIn = "";
      String bodyWorkCheckIn = "";
      String fluidCheckIn = "";
      String bucketCheckIn = "";
      String securityCheckIn = "";
      String extraCheckIn = "";
      String equipmentCheckIn = "";

      //Sortear por Compania

      Vehicle report = selectedComp[i];

      await getIssues(report, dateSelected);

      if (diaSelected == true) {
        //Secciones Check Out
        if (measureInspectR == true) {
          measureCheckOut = "✅";
        } else {
          measureCheckOut = "❌";
        }
        if (ligthsInspectR == true) {
          lightsCheckOut = "✅";
        } else {
          lightsCheckOut = "❌";
        }
        if (carBodyInspectR == true) {
          bodyWorkCheckOut = "✅";
        } else {
          bodyWorkCheckOut = "❌";
        }
        if (fluidCheckInspectR == true) {
          fluidCheckOut = "✅";
        } else {
          fluidCheckOut = "❌";
        }

        if (bucketInspectR == true) {
          bucketCheckOut = "✅";
        } else {
          bucketCheckOut = "❌";
        }
        if (securityInspectR == true) {
          securityCheckOut = "✅";
        } else {
          securityCheckOut = "❌";
        }
        if (extraInspectR == true) {
          extraCheckOut = "✅";
        } else {
          extraCheckOut = "❌";
        }
        if (equipmentInspectR == true) {
          equipmentCheckOut = "✅";
        } else {
          equipmentCheckOut = "❌";
        }

        //Secciones Check In
        if (measureInspectD == true) {
          measureCheckIn = "✅";
        } else {
          measureCheckIn = "❌";
        }
        if (ligthsInspectD == true) {
          lightsCheckIn = "✅";
        } else {
          lightsCheckIn = "❌";
        }
        if (carBodyInspectD == true) {
          bodyWorkCheckIn = "✅";
        } else {
          bodyWorkCheckIn = "❌";
        }
        if (fluidCheckInspectD == true) {
          fluidCheckIn = "✅";
        } else {
          fluidCheckIn = "❌";
        }

        if (bucketInspectD == true) {
          bucketCheckIn = "✅";
        } else {
          bucketCheckIn = "❌";
        }
        if (securityInspectD == true) {
          securityCheckIn = "✅";
        } else {
          securityCheckIn = "❌";
        }
        if (extraInspectD == true) {
          extraCheckIn = "✅";
        } else {
          extraCheckIn = "❌";
        }
        if (equipmentInspectD == true) {
          equipmentCheckIn = "✅";
        } else {
          equipmentCheckIn = "❌";
        }
      }

      final List<dynamic> row = [
        report.idVehicle,
        report.make,
        report.model,
        report.year,
        report.vin,
        report.licesensePlates,
        report.motor,
        '', //Color
        report.status.status,
        report.company.company,
        DateFormat("MMM/dd/yyyy").format(report.dateAdded),
        report.oilChangeDue == null
            ? null
            : DateFormat("MMM/dd/yyyy").format(report.oilChangeDue!),
        report.lastRadiatorFluidChange == null
            ? null
            : DateFormat("MMM/dd/yyyy").format(report.lastRadiatorFluidChange!),
        report.lastTransmissionFluidChange == null
            ? null
            : DateFormat("MMM/dd/yyyy")
                .format(report.lastTransmissionFluidChange!),
        issueR,
        issueD,
        //Secciones
        measureCheckOut,
        lightsCheckOut,
        bodyWorkCheckOut,
        fluidCheckOut,
        bucketCheckOut,
        securityCheckOut,
        extraCheckOut,
        equipmentCheckOut,
        measureCheckIn,
        lightsCheckIn,
        bodyWorkCheckIn,
        fluidCheckIn,
        bucketCheckIn,
        securityCheckIn,
        extraCheckIn,
        equipmentCheckIn,
      ];
      sheet.appendRow(row);

      String colorFinal = parseColorValue(report.color);

      var cell = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 3));
      cell.cellStyle = CellStyle(
        backgroundColorHex: colorFinal, // Cambia el color aquí
      );

      var cellCO = sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 23, rowIndex: i + 2));
      var style = cellCO.cellStyle ?? CellStyle();
      style.rightBorder.borderStyle;
      cellCO.cellStyle = style;
    }

    //Descargar
    final List<int>? fileBytes = excel.save(fileName: "Vehicle_Inventory.xlsx");
    //Limpiar controladores y variables
    dateExportDataController.text = "";
    companySel = "All";
    newDate = DateTime.now();

    if (fileBytes == null) return false;

    return true;
  }

  String parseColorValue(String colorValue) {
    String colorMenor = colorValue.substring(4);
    colorMenor.toUpperCase();
    String hexColor = '#$colorMenor'; // Convertir a formato de cadena '#RRGGBB'
    return hexColor;
  }
//----------------------------------------------

  //Funcion para la impresion de issues

  // Limpiar los controller
  void clearControllers({bool notify = true}) {
    companySelected = null;
    brandController.clear();
    modelController.clear();
    yearController.clear();
    vinController.clear();
    plateNumberController.clear();
    versionMotorController.clear();
    statusSelected = null;
    motorSel = null;
    colorController = 0xffffffff;
    dateTimeControllerOil.clear();
    dateTimeControllerRFC.clear();
    dateTimeControllerLTFC.clear();
    mileageController.clear();
    webImage = null;
    dateTimeControllerLBrakeChange.clear();
    dateTimeControllerLTireChange.clear();
    problemControllerUpdate.clear();
    ownershipSelected = null;
    if (notify) notifyListeners();
  }

  // Función para limpiar controladores de ExportVehicleData
  void clearControllersExportVehicleData({bool notify = true}) {
    vehicleSel = null;
    companySel = "All";
    dateExportVehicleDataFirstController.clear();
    dateExportVehicleDataLastController.clear();
  }

  // Limpiar la imagen
  void clearImage() {
    webImage = null;
    imageName = null;
  }

  // Dispose
  @override
  void dispose() {
    brandController.dispose();
    modelController.dispose();
    vinController.dispose();
    plateNumberController.dispose();
    versionMotorController.dispose();
    // colorController.dispose();

    super.dispose();
  }

  Future<bool> getIssues(Vehicle vehicle, DateTime selected) async {
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
    diaSelected = false;

    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");

    DateTime startDateSelected =
        DateTime(selected.year, selected.month, selected.day);

    DateTime endDateSelected =
        DateTime(selected.year, selected.month, selected.day, 23, 59, 59);

    String formatStartDate = format.format(startDateSelected);
    String formatEndDate = format.format(endDateSelected);

    try {
      final res = await supabaseCtrlV
          .from('issues_view')
          .select()
          .gt('date_added_r', formatStartDate)
          .lt('date_added_r', formatEndDate)
          .eq('id_vehicle', vehicle.idVehicle)
          .order('date_added_r', ascending: true)
          .limit(1);

      //print("El res Es: $res");

      if (res != null) {
        final listData = res as List<dynamic>;
        issue = Issues.fromJson(jsonEncode(listData[0]));
        DateTime? date = issue?.dateAddedR;

        if (date?.day == selected.day &&
            date?.month == selected.month &&
            date?.year == selected.year) {
          diaSelected = true;
          issueR = issue!.issuesR;
          if (issue!.issuesD != null) {
            issueD = issue!.issuesD!;
          }
          //Repetir esto con todas las listas
          issue!.bucketInspectionR.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              bucketInspectR = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   bucketInspectR = true;
            // }
          });
          //Bucket delivered llamada a su lista
          issue!.bucketInspectionD.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              bucketInspectD = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   bucketInspectD = true;
            // }
          });

          //Car BodyWork R
          issue!.carBodyworkR.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              carBodyInspectR = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   carBodyInspectR = true;
            // }
          });

          //Car BodyWork D
          issue!.carBodyworkD.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              carBodyInspectD = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   carBodyInspectD = true;
            // }
          });

          // Equipment R
          issue!.equimentR.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              equipmentInspectR = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   equipmentInspectR = true;
            // }
          });

          //Equipment R
          issue!.equimentD.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              equipmentInspectD = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   equipmentInspectD = true;
            // }
          });

          //Extra R
          issue!.extraR.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              extraInspectR = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   extraInspectR = true;
            // }
          });

          //Extra D
          issue!.extraD.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              extraInspectD = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   extraInspectD = true;
            // }
          });

          //Fluid Check R
          issue!.fluidCheckR.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              fluidCheckInspectR = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   fluidCheckInspectR = true;
            // }
          });

          //Fluid Check D
          issue!.fluidCheckD.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              fluidCheckInspectD = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   fluidCheckInspectD = true;
            // }
          });

          //Lights R
          issue!.lightsR.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              ligthsInspectR = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   ligthsInspectR = true;
            // }
          });

          //Lights D
          issue!.lightsD.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              ligthsInspectD = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   ligthsInspectD = true;
            // }
          });

          //Measure R
          issue!.measureR.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              measureInspectR = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   measureInspectR = true;
            // }
          });

          //Measure D
          issue!.measureD.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              measureInspectD = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   measureInspectD = true;
            // }
          });

          //Security R
          issue!.securityR.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              securityInspectR = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   securityInspectR = true;
            // }
          });

          //Security D
          issue!.securityD.toMap().forEach((key, value) {
            if (value == 'Bad' && !(key.contains("_comments"))) {
              securityInspectD = false;
            }
            // if (value == 'Good' && !(key.contains("_comments"))) {
            //   securityInspectD = true;
            // }
          });
        } else {
          diaSelected = false;
        }

        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      //print("error ${e}");
      return false;
    }
  }

  void getCompanyFilter(String comp, {bool notify = true}) {
    companySel = comp;
    if (notify) notifyListeners();
  }

  void getDateFilter(DateTime date) {
    newDate = date;
    notifyListeners();
  }

  void getVehicleExport(String plate) {
    confirmacion++;
    vehicleSel = plate;
    notifyListeners();
  }

  void getLicenses({bool notify = true}) {
    plates.clear();

    switch (companySel) {
      case "All":
        for (int i = 0; i < vehicles.length; i++) {
          String license = vehicles[i].licesensePlates;
          plates.add(license);
          plates.sort();
        }
        break;
      case "ODE":
        for (int i = 0; i < vehicles.length; i++) {
          if (vehicles[i].company.company == "ODE") {
            String license = vehicles[i].licesensePlates;
            plates.add(license);
            plates.sort();
          }
        }
        break;
      case "SMI":
        for (int i = 0; i < vehicles.length; i++) {
          if (vehicles[i].company.company == "SMI") {
            String license = vehicles[i].licesensePlates;
            plates.add(license);
            plates.sort();
          }
        }
        break;
      case "CRY":
        for (int i = 0; i < vehicles.length; i++) {
          if (vehicles[i].company.company == "CRY") {
            String license = vehicles[i].licesensePlates;
            plates.add(license);
            plates.sort();
          }
        }
        break;
    }
    if (notify) notifyListeners();
  }

  void getFirstDate(DateTime selection) {
    confirmacion++;
    firstSel = selection;
    notifyListeners();
  }

  void getLastDate(DateTime select) {
    confirmacion++;
    lastSel = select;
    notifyListeners();
  }

  Future<bool> exportVehicleData(
      DateTime initial, DateTime finish, String? plate) async {
    Excel excel = Excel.createExcel();
    Sheet? sheet = excel.sheets[excel.getDefaultSheet()];

    //TITULO
    sheet?.merge(CellIndex.indexByString("B1"), CellIndex.indexByString("C1"));
    //Headers de la Tabla
    sheet?.merge(CellIndex.indexByString("A3"), CellIndex.indexByString("A4"));
    sheet?.merge(CellIndex.indexByString("B3"), CellIndex.indexByString("B4"));
    sheet?.merge(CellIndex.indexByString("C3"), CellIndex.indexByString("C4"));
    sheet?.merge(CellIndex.indexByString("D3"), CellIndex.indexByString("D4"));
    sheet?.merge(CellIndex.indexByString("E3"), CellIndex.indexByString("E4"));
    sheet?.merge(CellIndex.indexByString("F3"), CellIndex.indexByString("F4"));
    //Headers para secciones
    sheet?.merge(CellIndex.indexByString("G3"), CellIndex.indexByString("M3"));
    sheet?.merge(CellIndex.indexByString("N3"), CellIndex.indexByString("T3"));

    sheet?.setColWidth(0, 25);
    sheet?.setColWidth(2, 25);
    sheet?.setColWidth(3, 25);
    sheet?.setColWidth(4, 25);
    sheet?.setColWidth(5, 25);
    sheet?.setColWidth(7, 25);
    sheet?.setColWidth(9, 25);
    sheet?.setColWidth(14, 25);
    sheet?.setColWidth(16, 25);

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
    cellT2.value = "Vehicle History";
    cellT2.cellStyle = titulo;

    var cellD = sheet.cell(CellIndex.indexByString("D1"));
    cellD.value = "Vehicle";
    cellD.cellStyle = titulo;

    var cellD2 = sheet.cell(CellIndex.indexByString("E1"));
    cellD2.value = plate;
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
    cell.value = "License Plates";
    cell.cellStyle = cellStyle;

    var cell2 = sheet.cell(CellIndex.indexByString("B3"));
    cell2.value = "Employee";
    cell2.cellStyle = cellStyle;

    var cell3 = sheet.cell(CellIndex.indexByString("C3"));
    cell3.value = "Date Check Out";
    cell3.cellStyle = cellStyle;

    var cell4 = sheet.cell(CellIndex.indexByString("D3"));
    cell4.value = "Date Check In";
    cell4.cellStyle = cellStyle;

    var cell5 = sheet.cell(CellIndex.indexByString("E3"));
    cell5.value = "Issues Check Out";
    cell5.cellStyle = cellStyle;

    var cell6 = sheet.cell(CellIndex.indexByString("F3"));
    cell6.value = "Issues Check In";
    cell6.cellStyle = cellStyle;

    //Seccion Titulos
    var cell7 = sheet.cell(CellIndex.indexByString("G3"));
    cell7.value = "Check Out";
    cell7.cellStyle = cellStyle;

    var cell14 = sheet.cell(CellIndex.indexByString("N3"));
    cell14.value = "Check In";
    cell14.cellStyle = cellStyle;

    //Secciones Check Out
    var cell15 = sheet.cell(CellIndex.indexByString("G4"));
    cell15.value = "Lights";
    cell15.cellStyle = cellStyle;
    var cell16 = sheet.cell(CellIndex.indexByString("H4"));
    cell16.value = "Car Bodywork";
    cell16.cellStyle = cellStyle;
    var cell17 = sheet.cell(CellIndex.indexByString("I4"));
    cell17.value = "Fluid Check";
    cell17.cellStyle = cellStyle;
    var cell18 = sheet.cell(CellIndex.indexByString("J4"));
    cell18.value = "Bucket Inspection";
    cell18.cellStyle = cellStyle;
    var cell19 = sheet.cell(CellIndex.indexByString("K4"));
    cell19.value = "Security";
    cell19.cellStyle = cellStyle;
    var cell20 = sheet.cell(CellIndex.indexByString("L4"));
    cell20.value = "Extra";
    cell20.cellStyle = cellStyle;
    var cell21 = sheet.cell(CellIndex.indexByString("M4"));
    cell21.value = "Equipment";
    cell21.cellStyle = cellStyle;

    //Secciones Check In
    var cell22 = sheet.cell(CellIndex.indexByString("N4"));
    cell22.value = "Lights";
    cell22.cellStyle = cellStyle;
    var cell23 = sheet.cell(CellIndex.indexByString("O4"));
    cell23.value = "Car Bodywork";
    cell23.cellStyle = cellStyle;
    var cell24 = sheet.cell(CellIndex.indexByString("P4"));
    cell24.value = "Fluid Check";
    cell24.cellStyle = cellStyle;
    var cell25 = sheet.cell(CellIndex.indexByString("Q4"));
    cell25.value = "Bucket Inspection";
    cell25.cellStyle = cellStyle;
    var cell26 = sheet.cell(CellIndex.indexByString("R4"));
    cell26.value = "Security";
    cell26.cellStyle = cellStyle;
    var cell27 = sheet.cell(CellIndex.indexByString("S4"));
    cell27.value = "Extra";
    cell27.cellStyle = cellStyle;
    var cell28 = sheet.cell(CellIndex.indexByString("T4"));
    cell28.value = "Equipment";
    cell28.cellStyle = cellStyle;

    // Consultar la base de datos para obtener el historial del vehículo entre las fechas
    // Aquí asumiré que tienes una función para obtener los datos desde tu base de datos.
    DateTime date = initial;

    if (date.day <= finish.day &&
        date.month <= finish.month &&
        date.year <= finish.year) {
      // dynamic resCTRLV;
      final resCTRLV = await supabaseCtrlV
          .from('dashboards_cv_view')
          .select()
          .gt('date_added_r', firstSel)
          .lt('date_added_r', lastSel)
          .eq('license_plates', vehicleSel)
          .order('date_added_r', ascending: true);

      if (resCTRLV == null) {
        log('Error en getIssuesByRange()');
      } else {
        issuesDashboards = (resCTRLV as List<dynamic>)
            .map((issue) =>
                issue_dashboard.IssuesDashboards.fromJson(jsonEncode(issue)))
            .toList();

        for (issue_dashboard.IssuesDashboards issue in issuesDashboards) {
          bucketInspectR = true;
          bucketInspectD = null;
          carBodyInspectR = true;
          carBodyInspectD = null;
          equipmentInspectR = true;
          equipmentInspectD = null;
          extraInspectR = true;
          extraInspectD = null;
          fluidCheckInspectR = true;
          fluidCheckInspectD = null;
          ligthsInspectR = true;
          ligthsInspectD = null;
          securityInspectR = true;
          securityInspectD = null;
          // Bucket Inspection
          issue.bucketInspectionR.toMap().forEach((key, value) {
            if (key != "date_added") {
              if (value == false) {
                bucketInspectR = false;
              }
            }
          });
          // Car Bodywork
          issue.carBodyworkR.toMap().forEach((key, value) {
            if (key != "date_added") {
              if (value == false) {
                carBodyInspectR = false;
              }
            }
          });
          // Equipment
          issue.equipmentR.toMap().forEach((key, value) {
            if (key != "date_added") {
              if (value == false) {
                equipmentInspectR = false;
              }
            }
          });
          // Extra
          issue.extraR.toMap().forEach((key, value) {
            if (key != "date_added") {
              if (value == false) {
                extraInspectR = false;
              }
            }
          });
          // Fluid Check
          issue.fluidCheckR.toMap().forEach((key, value) {
            if (key != "date_added") {
              if (value == false) {
                fluidCheckInspectR = false;
              }
            }
          });
          // Lights
          issue.lightsR.toMap().forEach((key, value) {
            if (key != "date_added") {
              if (value == false) {
                ligthsInspectR = false;
              }
            }
          });
          // Security
          issue.securityR.toMap().forEach((key, value) {
            if (key != "date_added") {
              if (value == false) {
                securityInspectR = false;
              }
            }
          });
          if (issue.issuesD != null) {
            bucketInspectD = true;
            carBodyInspectD = true;
            equipmentInspectD = true;
            extraInspectD = true;
            fluidCheckInspectD = true;
            ligthsInspectD = true;
            securityInspectD = true;

            // Bucket Inspection
            issue.bucketInspectionD.toMap().forEach((key, value) {
              if (key != "date_added") {
                if (value == false) {
                  bucketInspectD = false;
                }
              }
            });
            // Car Bodywork
            issue.carBodyworkD.toMap().forEach((key, value) {
              if (key != "date_added") {
                if (value == false) {
                  carBodyInspectD = false;
                }
              }
            });
            // Equipment
            issue.equipmentD.toMap().forEach((key, value) {
              if (key != "date_added") {
                if (value == false) {
                  equipmentInspectD = false;
                }
              }
            });
            // Extra
            issue.extraD.toMap().forEach((key, value) {
              if (key != "date_added") {
                if (value == false) {
                  extraInspectD = false;
                }
              }
            });
            // Fluid Check
            issue.fluidCheckD.toMap().forEach((key, value) {
              if (key != "date_added") {
                if (value == false) {
                  fluidCheckInspectD = false;
                }
              }
            });
            // Lights
            issue.lightsD.toMap().forEach((key, value) {
              if (key != "date_added") {
                if (value == false) {
                  ligthsInspectD = false;
                }
              }
            });
            // Security
            issue.securityD.toMap().forEach((key, value) {
              if (key != "date_added") {
                if (value == false) {
                  securityInspectD = false;
                }
              }
            });
          }
          List<dynamic> row = [
            issue.licensePlates,
            "${issue.userProfile.name} ${issue.userProfile.lastName}",
            DateFormat('dd/MMM/yyy hh:mm:ss').format(issue.dateAddedR),
            issue.dateAddedD == null
                ? null
                : DateFormat('dd/MMM/yyy hh:mm:ss').format(issue.dateAddedR),
            issue.issuesR,
            issue.issuesD,
            ligthsInspectR ? "✅" : "❌",
            carBodyInspectR ? "✅" : "❌",
            fluidCheckInspectR ? "✅" : "❌",
            bucketInspectR ? "✅" : "❌",
            securityInspectR ? "✅" : "❌",
            extraInspectR ? "✅" : "❌",
            equipmentInspectR ? "✅" : "❌",
            ligthsInspectD == null
                ? null
                : ligthsInspectD == true
                    ? "✅"
                    : "❌",
            carBodyInspectD == null
                ? null
                : carBodyInspectD == true
                    ? "✅"
                    : "❌",
            fluidCheckInspectD == null
                ? null
                : fluidCheckInspectD == true
                    ? "✅"
                    : "❌",
            bucketInspectD == null
                ? null
                : bucketInspectD == true
                    ? "✅"
                    : "❌",
            securityInspectD == null
                ? null
                : securityInspectD == true
                    ? "✅"
                    : "❌",
            extraInspectD == null
                ? null
                : extraInspectD == true
                    ? "✅"
                    : "❌",
            equipmentInspectD == null
                ? null
                : equipmentInspectD == true
                    ? "✅"
                    : "❌",
          ];
          sheet.appendRow(row);
        }
      }
    }

    // Guardar el archivo Excel en la ubicación deseada

    final List<int>? fileBytes = excel.save(fileName: "Vehicle_Inventory.xlsx");
    // Limpiar controladores
    dateExportVehicleDataFirstController = TextEditingController();
    dateExportVehicleDataLastController = TextEditingController();
    plates = [];
    firstSel = DateTime.now();
    lastSel = DateTime.now();
    if (fileBytes == null) return false;
    return true;
  }

  bool enableButton() {
    if (confirmacion == 3) {
      return true;
    } else {
      return false;
    }
  }

  // Future<void> getIssuesByRange(Sheet? sheet) async {
  //   try {
  //     if (sheet != null) {

  //     }
  //   } catch (e) {
  //     log('Error en getIssues() - $e');
  //   }
  // }
}
