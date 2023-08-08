import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

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

import '../../models/issues.dart';
import '../../models/issues_x_user.dart';
import '../../models/services.dart';
import '../../models/vehicle_dashboard.dart';

class InventoryProvider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];
  List<PlutoRow> rowsService = [];

  //------------------------------------------
  // Controllers para Alta Inventario
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

  // Controllers para exportar datos
  TextEditingController dateExportDataController = TextEditingController();
  String companySel = "All";
  DateTime newDate = DateTime.now();

  // Controllers para el Update Inventario
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
  //Función del updateState
  Future<void> updateState() async {
    rows.clear();
    await getInventory();
  }

  Future<void> updateStateService() async {
    print("Se hizo el updateStateService");
    rowsService.clear();
    await getServicesPage();
  }

  // Variables Individuales
  String? imageName;
  String? imageUrl;
  String? imageUrlUpdate;
  Uint8List? webImage;
  Uint8List? webImageClear;
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

  Issues? issue;

  bool? diaSelected;
  int issueR = 0;
  int issueD = 0;

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
    stateManager!.createFooter;
    notifyListeners();
  }

  void setPageService(String x) {
    switch (x) {
      case 'next':
        if (pageService < stateManager!.totalPage) pageService++;
        break;
      case 'previous':
        if (pageService > 1) pageService--;
        break;
      case 'start':
        pageService = 1;
        break;
      case 'end':
        pageService = stateManager!.totalPage;
        break;
      default:
        return;
    }
    stateManager!.setPage(page);
    notifyListeners();
  }

  void loadService() {
    stateManager!.setShowLoading(true);
  }

  void setIndexIssue(int index) async {
    for (var i = 0; i < indexSelectedIssue.length; i++) {
      indexSelectedIssue[i] = false;
    }
    indexSelectedIssue[index] = true;
    // switch (index) {
    //   case 0:
    //     await getVehicle(actualVehicle!);
    //     break;
    // }
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

  // // Inventory Provider
  // InventoryProvider() {
  //   getInventory();
  // }

  // Función para hacerle Update a los controladores
  void updateInventoryControllers(Vehicle vehicle) {
    makeControllerUpdate.text = vehicle.make;
    modelControllerUpdate.text = vehicle.model;
    vinControllerUpdate.text = vehicle.vin;
    plateNumberControllerUpdate.text = vehicle.licesensePlates;
    motorControllerUpadte.text = vehicle.motor;
    yearControllerUpdate.text = vehicle.year.toString();
    statusSelectedUpdate = statusSelected;
    imageUrlUpdate = vehicle.image!.replaceAll(
        "https://supa43.rtatel.com/storage/v1/object/public/assets/Vehicles/",
        "");

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
    mileageControllerUpdate.text = vehicle.mileage.toString();
  }

  // Función para hacerle update a la Imagen
  Future<void> updateImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) return;

    webImage = await pickedImage.readAsBytes();
    final res = await supabase.storage.from('assets/Vehicles').updateBinary(
          imageUrlUpdate!,
          webImage!,
        );
    // print(res);
  }

  // Función para seleccionar la imagen
  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    final String? placeHolderImage;

    if (pickedImage == null) return;

    webImage = await pickedImage.readAsBytes();
    print("-------------------------");

    print(imageUrl);
    print("-------------------------");
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
    print("Entro a getServices()");
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

  // Función para cuando actualizamos la compania en la actualización del vehiculo
  void selectCompanyUpdate(String companys) {
    companySelectedUpdate =
        company.firstWhere((elem) => elem.company == companys);
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
    colorController = int.parse(vehicle.color!);
    //colorString = "0xffffffff";
    colorString = colorController.toString();
    notifyListeners();
  }

  // Función para inicializar la imagen
  void inicializeImage(Vehicle vehicle) {
    final List<int> codeUnits = vehicle.image!.codeUnits;
    webImage = Uint8List.fromList(codeUnits);

    notifyListeners();
  }

  // Función para hacerle update al Vehiculo
  Future<bool> updateVehicle(Vehicle vehicle) async {
    final res = await supabase.storage.from('assets/Vehicles').updateBinary(
          imageUrlUpdate!,
          webImage!,
        );
    // print(res);
    try {
      await supabaseCtrlV.from('vehicle').update({
        'make': makeControllerUpdate.text,
        'model': modelControllerUpdate.text,
        'year': yearControllerUpdate.text,
        'vin': vinControllerUpdate.text,
        'license_plates': plateNumberControllerUpdate.text,
        'motor': motorControllerUpadte.text,
        'color': colorString ?? vehicle.color,
        'id_status_fk':
            statusSelectedUpdate?.statusId ?? vehicle.status.statusId,
        'id_company_fk':
            companySelectedUpdate?.companyId ?? vehicle.company.companyId,
        'date_added': DateTime.now().toIso8601String(),
        'oil_change_due': dateTimeControllerOilUpdate.text,
        'last_radiator_fluid_change': dateTimeControllerRFCUpadte.text,
        'last_transmission_fluid_change': dateTimeControllerLTFCUpadte.text,
        'mileage': mileageControllerUpdate.text,

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
      print("Error in createVehicleService() - $e");
      print(actualVehicle!.idVehicle);
      return false;
    }
  }

  // Función para traer la pagina de servicios
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
      // final serviceList = res as List<dynamic>;
      rowsService.clear();
      for (ServicesApi service in services) {
        print(service.servicex.service);
        print("-------------");
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
      // vehicle.oilChangeDue == null
      //   ? ""
      //   : DateFormat("MMM/dd/yyyy").format(vehicle.oilChangeDue!);

      print("Entro a getServicesPage()");
      return true;
    } catch (e) {
      print("Error in getServicesPage() - $e");
      print(actualVehicle!.idVehicle);
      return false;
    }
  }

  // Función para crear un vehiculo
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
          'image': imageUrl,
          'id_status_fk': statusSelected?.statusId,
          'id_company_fk': companySelected?.companyId,
          'date_added': DateTime.now().toIso8601String(),
          'oil_change_due': dateTimeControllerOil.text,
          'last_radiator_fluid_change': dateTimeControllerRFC.text,
          'last_transmission_fluid_change': dateTimeControllerLTFC.text,
          'mileage': mileageController.text,
          // 'rule_oil_change': {
          //   "value: 300000",
          //   "Registered: false",
          //   "Last Mileage Service: ${mileageController.text}"
          // },
          // 'rule_transmission_fluid_change': {
          //   "value: 100000",
          //   "Registered: false",
          //   "Last Mileage Service: ${mileageController.text}"
          // },
          // 'rule_radiator_fluid_change': {
          //   "value: 20000",
          //   "Registered: false",
          //   "Last Mileage Service: ${mileageController.text}"
          // },
        },
      );
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
      print("Error in GetVehicle() $e");
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
      print("Error in changeStatusInventory() - $e");
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
              "mileage": PlutoCell(value: vehicle.mileage.toString()),
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

  // Función para ver los vehiculos archivados
  Future<void> getArchiveVehicle() async {
    try {
      final res = await supabaseCtrlV
          .from('vehicle')
          .select()
          .match({'id_status_fk': 4.toString()});
      // print(res);

      // AQUI está el fallo
      vehicleArchive = (res as List<dynamic>)
          .map((vehicleArchive) =>
              VehicleDash.fromJson(jsonEncode(vehicleArchive)))
          .toList();
    } catch (e) {
      print("Error en getArchiveVehicle - $e");
    }
  }

  // EXCEL
  Future<bool> excelActivityReports(DateTime dateSelected, String comp
  ) async {
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
    sheet?.setColWidth(18,30);
    sheet?.setColWidth(20,30);
    sheet?.setColWidth(26,30);
    sheet?.setColWidth(28,30);

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
    
    if(comp != "All"){
      for(int x =0; x<vehicles.length; x++){
      if(vehicles[x].company.company == comp){
        selectedComp.add(vehicles[x]);
      }
    
    }
    }
    else{
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

     if(diaSelected == true){
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

      var cellCO = sheet.cell(CellIndex.indexByColumnRow(columnIndex: 23, rowIndex: i+2));
      var style = cellCO.cellStyle ?? CellStyle();
        style.rightBorder.borderStyle;
        cellCO.cellStyle = style;
    }

    

    //Descargar
    final List<int>? fileBytes = excel.save(fileName: "Vehicle_Inventory.xlsx");
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
    brandController.clear();
    modelController.clear();
    vinController.clear();
    plateNumberController.clear();
    motorController.clear();
    colorController = 0xffffffff;
    if (notify) notifyListeners();
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
    motorController.dispose();
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

    DateTime startDateSelected = DateTime(selected.year, selected.month, selected.day);

    DateTime endDateSelected = DateTime(selected.year, selected.month, selected.day, 23, 59, 59);

    String formatStartDate = format.format(startDateSelected);
    String formatEndDate = format.format(endDateSelected);

    try {
      final res = await supabaseCtrlV
          .from('issues_view')
          .select()
          .gt('date_added_r', formatStartDate)
          .lt('date_added_r', formatEndDate)
          .eq('id_vehicle', vehicle.idVehicle)
          .order('date_added_r',ascending: true)
          .limit(1);

      

      print("El res Es: $res");

      if (res != null) {

        final listData = res as List<dynamic>;
        issue = Issues.fromJson(jsonEncode(listData[0]));
        DateTime? date = issue?.dateAddedR;

        if(date?.day == selected.day && date?.month == selected.month && date?.year == selected.year){
          diaSelected = true;
          issueR = issue!.issuesR;
          if(issue!.issuesD != null){
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
        

        }else{
          diaSelected = false;
        }

        
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
  void getCompanyFilter(String comp){
    companySel = comp;
    notifyListeners();
  }
  void getDateFilter(DateTime date){
    newDate = date;
    notifyListeners();
  }
}
