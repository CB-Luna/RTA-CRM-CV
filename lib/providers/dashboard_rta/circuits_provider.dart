// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdfx/pdfx.dart' as pdfx;
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_%20generic_cat.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_cat_circuit_types.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_cat_vendor_model.dart';
import 'package:rta_crm_cv/models/dashboard_rta/circuits.dart';
import 'package:rta_crm_cv/models/dashboard_rta/comments.dart';
import 'package:rta_crm_cv/models/dashboard_rta/towers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pluto_grid_export/pluto_grid_export.dart' as pluto_grid_export;

class CircuitsProvider extends ChangeNotifier {
  int pageRowCount = 11;
  int page = 1;
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];
  // Individual
  Circuits? circuitSelected;
  String carrierSelectedValue = '';
  String circuitTypeSelectedValue = "";
  String handoffSelectedValue = "";
  String statusSelectedValue = "";
  String geMapSelectedValue = "";
  pdfx.PdfController? finalPdfController;
  Uint8List? documento;
  final date = DateTime.now();

  final borderStyle = const pw.BorderSide(width: 1);
  final columnWidths = {
    0: const pw.FlexColumnWidth(1), // Ancho flexible para la primera columna
    1: const pw.FlexColumnWidth(1), // Ancho flexible para la segunda columna
    2: const pw.FlexColumnWidth(1), // Ancho flexible para la tercera columna
  };
  // Listas
  List<Circuits> listCircuits = [];
  List<TowerRta> listTowers = [];
  List<Vendor> vendorsList = []; //Vendor(vendorName: 'ATT')
  List<CatCircuitTypes> circuitTypeList = []; //CatCircuitTypes(name: 'NNI')
  List<GenericCat> handoffList = [GenericCat(name: 'New')];
  List<String> statusList = [
    "Active",
    "Installing",
    "Disconnected ",
    "Deactivated"
  ];
  List<String> geMapList = ["Yes", "No"];
  List<CommentCircuit> comments = [];

  // Controladores
  final searchController = TextEditingController();
  final searchTowersController = TextEditingController();
  final dateExportDataController = TextEditingController();
  //  Circuits
  final pccidController = TextEditingController();
  final rtaCustomerController = TextEditingController();
  final cktStatusController = TextEditingController();
  final geMapController = TextEditingController();
  final carrierController = TextEditingController();
  final cktTypeController = TextEditingController();
  final cktUseController = TextEditingController();
  final cktIDController = TextEditingController();
  final evcController = TextEditingController();
  final caracctnumController = TextEditingController();
  final carcontIDController = TextEditingController();
  final contexpController = TextEditingController();
  final contLengthController = TextEditingController();

  // Info
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final cirController = TextEditingController();
  final portController = TextEditingController();
  final handoffController = TextEditingController();

  // APOP
  final apopStreetController = TextEditingController();
  final apopCityController = TextEditingController();
  final apopStateController = TextEditingController();
  final apopZipController = TextEditingController();
  final apopLatitudeController = TextEditingController();
  final apopLongitudeController = TextEditingController();

  // BPOP
  final bpopStreetController = TextEditingController();
  final bpopCityController = TextEditingController();
  final bpopStateController = TextEditingController();
  final bpopZipController = TextEditingController();
  final bpopLatitudeController = TextEditingController();
  final bpopLongitudeController = TextEditingController();
  final commentsController = TextEditingController();

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

  Future<void> updateState() async {
    // await setIndex(0);
    rows.clear();
    if (indexSelected[0]) {
      await getCircuits();
    } else if (indexSelected[1]) {
      await getTowers();
    }
  }

  List<bool> indexSelected = [
    true, // Circuits
    false, // Towers
    false, // Others
  ];

  Future setIndex(int index, {bool notify = true}) async {
    for (var i = 0; i < indexSelected.length; i++) {
      indexSelected[i] = false;
    }
    indexSelected[index] = true;

    switch (index) {
      case 0:
        await getCircuits(); // Circuits
        searchController.clear();
        break;
      case 1:
        await getTowers(); // Towers
        searchController.clear();

        break;
      case 2:
        await getCircuits(); // Others
        searchController.clear();

        break;
    }

    notifyListeners();
  }

  // Función para actualizar el carrier
  void selectCarrier(String selected) {
    carrierSelectedValue = selected;
    notifyListeners();
  }

  // Función para actualizar el type
  void selectedType(String selected) {
    circuitTypeSelectedValue = selected;
    notifyListeners();
  }

  // Función para actualizar el geMap
  void selectGeMap(String selected) {
    geMapSelectedValue = selected;
    notifyListeners();
  }

  // Función para actualizar el status
  void selectStatus(String selected) {
    statusSelectedValue = selected;
    notifyListeners();
  }

  // void selectLeadSource(String selected) {
  //   selectLeadSourceValue = selected;
  //   notifyListeners();
  // }

  // Agregar Comentario en la detailedCircuit
  Future<void> addComment() async {
    try {
      if (commentsController.text.isNotEmpty) {
        await supabaseDashboard.from('circuit_comments').insert(
          {
            "user_fk": currentUser!.id,
            "id_circuit": circuitSelected!.id,
            // "id_circuit": 15,
            "comment": commentsController.text,
            "sended": DateTime.now().toIso8601String(),
          },
        );
        print("Se envio a supabase;");
        comments.add(
          CommentCircuit(
            userFk: currentUser!.id,
            id: circuitSelected!.id,
            // id: 15,
            comment: commentsController.text,
            sended: DateTime.now(),
          ),
        );
        commentsController.clear();
        await getComments();
        notifyListeners();
      }
    } catch (e) {
      print("Error in addComment $e");
    }
  }

  // Agregar a la lista el comentario en Add Circuit
  Future<void> addCommentWait() async {
    try {
      comments.add(
        CommentCircuit(
          userFk: currentUser!.id,
          // id: circuitSelected!.id,
          // id: 15,
          comment: commentsController.text,
          sended: DateTime.now(),
        ),
      );
      commentsController.clear();
      notifyListeners();
    } catch (e) {
      print("Error in addCommentWait $e");
    }
  }

  // Enviar el comentario a supabase
  Future<void> sendComments(int id) async {
    try {
      for (var element in comments) {
        await supabaseDashboard.from('circuit_comments').insert(
          {
            "user_fk": currentUser!.id,
            "id_circuit": id,
            // "id_circuit": 15,
            "comment": element.comment,
            "sended": DateTime.now().toIso8601String(),
          },
        );
        print("Se envio a supabase;");
      }
      notifyListeners();
    } catch (e) {
      print("Error in sendComments $e");
    }
  }

  // Traer Los comentarios que tienen los circuitos
  Future<void> getComments() async {
    try {
      comments.clear();
      final res = await supabaseDashboard
          .from('comments_view')
          .select()
          .eq('id_circuit', circuitSelected!.id);
      // .eq('id_circuit', 15);

      comments = (res as List<dynamic>)
          .map((comment) => CommentCircuit.fromJson(jsonEncode(comment)))
          .toList();
    } catch (e) {
      print("Error in getComments $e");
    }
  }

  // Traer los circuitos
  Future<void> getCircuits() async {
    rows.clear();
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      final query = await supabase.rpc('search_circuits', params: {
        'busqueda': searchController.text,
      });
      final res = await query;
      listCircuits = (res as List<dynamic>)
          .map((vehicles) => Circuits.fromJson(jsonEncode(vehicles)))
          .toList();

      rows.clear();
      for (Circuits circuit in listCircuits) {
        rows.add(
          PlutoRow(
            cells: {
              "pccid_Column": PlutoCell(value: circuit.pccid),
              "rta_customers_Column": PlutoCell(value: circuit.rtaCustomer),
              "CKTSTATUS_Column": PlutoCell(value: circuit.cktstatus),
              "CktID_Column": PlutoCell(value: circuit.cktid),
              "street_Column": PlutoCell(value: circuit.street),
              "state_Column": PlutoCell(value: circuit.state),
              "CKTType_Column": PlutoCell(value: circuit.ckttype),
              "cktuse_Column": PlutoCell(value: circuit.cktuse),
              "actions": PlutoCell(value: circuit.id),
            },
          ),
        );
      }

      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getCircuits() - $e');
    }
    notifyListeners();
  }

  // Función para traer la información de la torre
  Future<void> getTowers() async {
    rows.clear();
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      // final query = await supabase.rpc('search_circuits', params: {
      //   'busqueda': searchController.text,
      // });
      final query = await supabase.rpc('search_towers', params: {
        'busqueda': searchTowersController.text,
      });
      final res = await query;
      // final res = await supabaseDashboard.from("rta_towers").select();
      listTowers = (res as List<dynamic>)
          .map((tower) => TowerRta.fromJson(jsonEncode(tower)))
          .toList();

      for (TowerRta towers in listTowers) {
        // rows.clear();
        rows.add(
          PlutoRow(
            cells: {
              "company_id_Column": PlutoCell(value: towers.companyId),
              "name_Column": PlutoCell(value: towers.name),
              "type_Column": PlutoCell(value: towers.type),
              "address_Column": PlutoCell(value: towers.address),
              "make_Column": PlutoCell(value: towers.make),
              "model_Column": PlutoCell(value: towers.model),
              "use_Column": PlutoCell(value: towers.use),
              "users_Column": PlutoCell(value: towers.numbCustomerServed),
              "actions": PlutoCell(value: towers.id),
            },
          ),
        );
      }

      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getTowers() - $e');
    }
    notifyListeners();
  }

  Future<void> selectCircuit(int id) async {
    try {
      final res =
          await supabaseDashboard.from("rta_circuits").select().eq('id', id);
      List<Circuits> circuitss = [];
      circuitss = (res as List<dynamic>)
          .map((circuit) => Circuits.fromJson(jsonEncode(circuit)))
          .toList();
      circuitSelected = circuitss.first;
      notifyListeners();
    } catch (e) {
      print("Error in selectCircuit - $e");
    }
  }

  // Función para eliminar un vehiculo
  Future<bool> deleteCircuit(int id) async {
    try {
      // Primero eliminamos el comentario
      await supabaseDashboard
          .from('circuit_comments')
          .delete()
          .match({'id_circuit': id});

      // Luego eliminamos el circuito
      await supabaseDashboard.from('rta_circuits').delete().match({'id': id});

      notifyListeners();
      return true;
    } catch (e) {
      log('Error in deleteCircuit() - $e');
      return false;
    }
  }

  // Update Circuit
  Future<bool> updateCircuit() async {
    try {
      print(
          "Valores en carrrier: $carrierSelectedValue  en type: $circuitTypeSelectedValue");
      await supabaseDashboard.from('rta_circuits').update({
        "pccid": pccidController.text,
        "rta_customer": rtaCustomerController.text,
        // 'cktstatus': cktStatusController.text,
        "cktstatus": statusSelectedValue,
        // "gemap": geMapController.text,
        "gemap": geMapSelectedValue,
        // "carrier": carrierController.text,
        "carrier": carrierSelectedValue,
        "ckttype": circuitTypeSelectedValue,
        "cktuse": cktUseController.text,
        "cktid": cktIDController.text,
        "evc": evcController.text,
        "caracctnum": caracctnumController.text,
        "carcontid": carcontIDController.text,
        "contlength": contLengthController.text,
        "street": streetController.text,
        "state": stateController.text,
        "city": cityController.text,
        "zip": zipController.text,
        "latitude": latitudeController.text,
        "longitude": longitudeController.text,
        "cir": cirController.text,
        "port": portController.text,
        "handoff": handoffController.text,
        "apopstreet": apopStreetController.text,
        "apopcity": apopCityController.text,
        "apopzip": apopZipController.text,
        "apopstate": apopStateController.text,
        "apoplat": apopLatitudeController.text,
        "apoplong": apopLongitudeController.text,
        "bpopstreet": bpopStreetController.text,
        "bpopcity": bpopCityController.text,
        "bpopstate": bpopStateController.text,
        "bpopzip": bpopZipController.text,
        "bpoplat": bpopLatitudeController.text,
        "bpoplong": bpopLongitudeController.text,
        "contexp": contexpController.text,
      }).eq("id", circuitSelected!.id);
      return true;
    } catch (e) {
      print("Error in updateCircuit - $e");
      return false;
    }
  }

  // Nos trae la información del circuito seleccionado
  Future<void> getInformationCircuit(int id) async {
    try {
      circuitSelected = listCircuits.firstWhere((element) => element.id == id);
      pccidController.text = circuitSelected?.pccid.toString() ?? "-";
      rtaCustomerController.text =
          circuitSelected?.rtaCustomer.toString() ?? "-";
      cktStatusController.text = circuitSelected?.cktstatus ?? "-";
      geMapController.text = circuitSelected?.gemap ?? "-";
      carrierController.text = circuitSelected?.carrier ?? "-";
      cktTypeController.text = circuitSelected?.ckttype ?? "-";
      cktUseController.text = circuitSelected?.cktuse ?? "-";
      cktIDController.text = circuitSelected?.cktid ?? "-";
      evcController.text = circuitSelected?.evc ?? "-";
      caracctnumController.text = circuitSelected?.caracctnum ?? "-";
      carcontIDController.text = circuitSelected?.carcontid?.toString() ?? "-";
      contexpController.text =
          DateFormat("MM/dd/yyyy").format(circuitSelected!.contexp!);
      contLengthController.text = circuitSelected?.contlength.toString() ?? "-";
      streetController.text = circuitSelected?.street ?? "-";
      cityController.text = circuitSelected?.city ?? "-";
      stateController.text = circuitSelected?.state ?? "-";
      zipController.text = circuitSelected?.zip?.toString() ?? "-";
      latitudeController.text = circuitSelected?.latitude ?? "-";
      longitudeController.text = circuitSelected?.longitude ?? "-";
      cirController.text = circuitSelected?.cir?.toString() ?? "-";
      portController.text = circuitSelected?.port?.toString() ?? "-";
      handoffController.text = circuitSelected?.handoff ?? "-";
      apopStreetController.text = circuitSelected?.apopstreet ?? "-";
      apopCityController.text = circuitSelected?.apopcity ?? "-";
      apopStateController.text = circuitSelected?.apopzip.toString() ?? "-";
      apopZipController.text = circuitSelected?.apopzip.toString() ?? "-";

      apopLatitudeController.text = circuitSelected?.apoplat ?? "-";
      apopLongitudeController.text = circuitSelected?.apoplong ?? "-";
      bpopStreetController.text = circuitSelected?.bpopstreet ?? "-";
      bpopCityController.text = circuitSelected?.bpopcity ?? "-";
      bpopStateController.text = circuitSelected?.bpopstate ?? "-";
      bpopZipController.text = circuitSelected?.bpopzip.toString() ?? "-";
      bpopLatitudeController.text = circuitSelected?.bpoplat ?? "-";
      bpopLongitudeController.text = circuitSelected?.bpoplong ?? "-";
      // commentsController.text = circuitSelected!.notes!;
      carrierSelectedValue = circuitSelected?.carrier ?? '';
      handoffSelectedValue = circuitSelected?.handoff ?? '';
      statusSelectedValue = circuitSelected?.cktstatus ?? '';
      geMapSelectedValue = circuitSelected?.gemap ?? "";
      circuitTypeSelectedValue = circuitSelected?.ckttype ?? "";
      notifyListeners();
    } catch (e) {
      print('Error en getInformationTraining() - $e');
    }
  }

  // Limpiar los Controladores
  void clearAll() {
    pccidController.clear();
    rtaCustomerController.clear();
    cktStatusController.clear();
    geMapController.clear();
    carrierController.clear();
    cktTypeController.clear();
    cktUseController.clear();
    cktIDController.clear();
    evcController.clear();
    caracctnumController.clear();
    carcontIDController.clear();

    contexpController.clear();
    contLengthController.clear();
    streetController.clear();
    cityController.clear();
    stateController.clear();
    zipController.clear();

    latitudeController.clear();
    longitudeController.clear();
    cirController.clear();
    portController.clear();
    handoffController.clear();
    apopStreetController.clear();
    apopCityController.clear();
    apopStateController.clear();
    apopZipController.clear();

    apopLatitudeController.clear();
    apopLongitudeController.clear();
    bpopStreetController.clear();
    bpopCityController.clear();
    bpopStateController.clear();
    bpopZipController.clear();
    bpopLatitudeController.clear();
    bpopLongitudeController.clear();
    comments.clear();
    setIndex(0);
  }

  // Función para crear un Circuito
  Future<bool> createCircuit() async {
    try {
      final id = await supabaseDashboard.from('rta_circuits').insert(
        {
          "pccid": pccidController.text,
          "rta_customer": rtaCustomerController.text,
          'cktstatus': cktStatusController.text,
          "gemap": geMapController.text,
          "carrier": carrierController.text,
          "ckttype": cktTypeController.text,
          "cktuse": cktUseController.text,
          "cktid": cktTypeController.text,
          "evc": evcController.text,
          "caracctnum": caracctnumController.text,
          "carcontid": carcontIDController.text,
          "contlength": contLengthController.text,
          "street": streetController.text,
          "state": stateController.text,
          "city": cityController.text,
          "zip": zipController.text,
          "latitude": latitudeController.text,
          "longitude": longitudeController.text,
          "cir": cirController.text,
          "port": portController.text,
          "handoff": handoffController.text,
          "apopstreet": apopStreetController.text,
          "apopcity": apopCityController.text,
          "apopzip": apopZipController.text,
          "apopstate": apopStateController.text,
          "apoplat": apopLatitudeController.text,
          "apoplong": apopLongitudeController.text,
          "bpopstreet": bpopStreetController.text,
          "bpopcity": bpopCityController.text,
          "bpopstate": bpopStateController.text,
          "bpopzip": bpopZipController.text,
          "bpoplat": bpopLatitudeController.text,
          "bpoplong": bpopLongitudeController.text,
          "contexp": contexpController.text,
        },
      ).select<PostgrestList>('id');

      sendComments(id.first["id"]);
      return true;
    } catch (e) {
      print('Error in createCircuit() - $e');
      return false;
    }
  }

  //  Vendor = Carrier
  Future<bool> getCatalog() async {
    try {
      // Carrier
      dynamic response =
          await supabaseCRM.from('cat_vendors').select().eq('visible', true);
      vendorsList.clear();
      vendorsList = (response as List<dynamic>)
          .map((index) => Vendor.fromJson(jsonEncode(index)))
          .toList();

      // carrierSelectedValue = vendorsList.first.vendorName!;
      // Use
      response = await supabaseCRM
          .from('cat_circuit_types')
          .select()
          .eq('visible', true);
      circuitTypeList.clear();
      circuitTypeList = (response as List<dynamic>)
          .map((index) => CatCircuitTypes.fromRawJson(jsonEncode(index)))
          .toList();
      // HandOfff
      response =
          await supabaseCRM.from('cat_handoffs').select().eq('visible', true);
      handoffList.clear();
      handoffList = (response as List<dynamic>)
          .map((index) => GenericCat.fromRawJson(jsonEncode(index)))
          .toList();

      // handoffSelectedValue = handoffList.first.name!;
      // Status
      notifyListeners();
      return true;
    } catch (e) {
      log("Error in getCatalog -$e");
      return false;
    }
  }

  // Excel de los reportes
  Future<bool> excelActivityReports() async {
    try {
      //Crear excel
      Excel excel = Excel.createExcel();
      Sheet? sheet = excel.sheets[excel.getDefaultSheet()];
      await getCircuits();
      List<Circuits> circuitList = [];
      //TITULO
      sheet?.merge(
          CellIndex.indexByString("B1"), CellIndex.indexByString("C1"));
      //Headers de la Tabla, aqui juntamos los dos renglones para una mejor vista.
      sheet?.merge(
          CellIndex.indexByString("A3"), CellIndex.indexByString("A4"));
      sheet?.merge(
          CellIndex.indexByString("B3"), CellIndex.indexByString("B4"));
      sheet?.merge(
          CellIndex.indexByString("C3"), CellIndex.indexByString("C4"));
      sheet?.merge(
          CellIndex.indexByString("D3"), CellIndex.indexByString("D4"));
      sheet?.merge(
          CellIndex.indexByString("E3"), CellIndex.indexByString("E4"));
      sheet?.merge(
          CellIndex.indexByString("F3"), CellIndex.indexByString("F4"));
      sheet?.merge(
          CellIndex.indexByString("G3"), CellIndex.indexByString("G4"));
      sheet?.merge(
          CellIndex.indexByString("H3"), CellIndex.indexByString("H4"));
      sheet?.merge(
          CellIndex.indexByString("I3"), CellIndex.indexByString("I4"));
      sheet?.merge(
          CellIndex.indexByString("J3"), CellIndex.indexByString("J4"));
      sheet?.merge(
          CellIndex.indexByString("K3"), CellIndex.indexByString("K4"));
      sheet?.merge(
          CellIndex.indexByString("L3"), CellIndex.indexByString("L4"));
      sheet?.merge(
          CellIndex.indexByString("M3"), CellIndex.indexByString("M4"));
      sheet?.merge(
          CellIndex.indexByString("N3"), CellIndex.indexByString("N4"));
      sheet?.merge(
          CellIndex.indexByString("O3"), CellIndex.indexByString("O4"));
      sheet?.merge(
          CellIndex.indexByString("P3"), CellIndex.indexByString("P4"));
      sheet?.merge(
          CellIndex.indexByString("Q3"), CellIndex.indexByString("Q4"));

      sheet?.merge(
          CellIndex.indexByString("R3"), CellIndex.indexByString("R4"));
      sheet?.merge(
          CellIndex.indexByString("S3"), CellIndex.indexByString("S4"));
      sheet?.merge(
          CellIndex.indexByString("T3"), CellIndex.indexByString("T4"));
      sheet?.merge(
          CellIndex.indexByString("U3"), CellIndex.indexByString("U4"));
      sheet?.merge(
          CellIndex.indexByString("V3"), CellIndex.indexByString("V4"));

      //Headers para secciones
      // Fusión Apops
      sheet?.merge(
          CellIndex.indexByString("W3"), CellIndex.indexByString("AB3"));
      // Fusión BPOPS
      sheet?.merge(
          CellIndex.indexByString("AC3"), CellIndex.indexByString("AH3"));

      // Aqui damos por ejemplo el primero es el numero de columna y el segundo el width de está
      sheet?.setColWidth(1, 25);
      sheet?.setColWidth(7, 25);
      sheet?.setColWidth(10, 25);
      sheet?.setColWidth(11, 25); // ContEXP
      sheet?.setColWidth(13, 25); // Street
      sheet?.setColWidth(22, 25); // APOPSTREET
      sheet?.setColWidth(28, 25); // BPOPSTREET

      // sheet?.setColWidth(5, 30);
      // sheet?.setColWidth(11, 50);
      // sheet?.setColWidth(12, 50);
      // sheet?.setColWidth(13, 50);
      // sheet?.setColWidth(14, 25);
      // sheet?.setColWidth(15, 30);
      // sheet?.setColWidth(18, 30);
      // sheet?.setColWidth(20, 30);
      // sheet?.setColWidth(26, 30);
      // sheet?.setColWidth(28, 30);

      if (sheet == null) return false;
      CellStyle titulo = CellStyle(
        fontFamily: getFontFamily(FontFamily.Calibri),
        fontSize: 16,
        bold: true,
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
      );

      // Son los princiaples
      var cellT = sheet.cell(CellIndex.indexByString("A1"));
      cellT.value = "Title";
      cellT.cellStyle = titulo;

      var cellT2 = sheet.cell(CellIndex.indexByString("B1"));
      cellT2.value = "RTA Circuits";
      cellT2.cellStyle = titulo;

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
      cell.value = "pccid";
      cell.cellStyle = cellStyle;

      var cell2 = sheet.cell(CellIndex.indexByString("B3"));
      cell2.value = "rta_customer";
      cell2.cellStyle = cellStyle;

      var cell3 = sheet.cell(CellIndex.indexByString("C3"));
      cell3.value = "cktstatus";
      cell3.cellStyle = cellStyle;

      var cell4 = sheet.cell(CellIndex.indexByString("D3"));
      cell4.value = "gemap";
      cell4.cellStyle = cellStyle;

      var cell5 = sheet.cell(CellIndex.indexByString("E3"));
      cell5.value = "carrier";
      cell5.cellStyle = cellStyle;

      var cell6 = sheet.cell(CellIndex.indexByString("F3"));
      cell6.value = "ckttype";
      cell6.cellStyle = cellStyle;

      var cell7 = sheet.cell(CellIndex.indexByString("G3"));
      cell7.value = "cktuse";
      cell7.cellStyle = cellStyle;

      var cell8 = sheet.cell(CellIndex.indexByString("H3"));
      cell8.value = "cktid";
      cell8.cellStyle = cellStyle;

      var cell9 = sheet.cell(CellIndex.indexByString("I3"));
      cell9.value = "evc";
      cell9.cellStyle = cellStyle;

      var cell10 = sheet.cell(CellIndex.indexByString("J3"));
      cell10.value = "caracctnum";
      cell10.cellStyle = cellStyle;

      var cell11 = sheet.cell(CellIndex.indexByString("K3"));
      cell11.value = "carcontid";
      cell11.cellStyle = cellStyle;

      var cell12 = sheet.cell(CellIndex.indexByString("L3"));
      cell12.value = "contexp";
      cell12.cellStyle = cellStyle;

      var cell13 = sheet.cell(CellIndex.indexByString("M3"));
      cell13.value = "contlength";
      cell13.cellStyle = cellStyle;

      var cell14 = sheet.cell(CellIndex.indexByString("N3"));
      cell14.value = "street";
      cell14.cellStyle = cellStyle;

      var cell15 = sheet.cell(CellIndex.indexByString("O3"));
      cell15.value = "city";
      cell15.cellStyle = cellStyle;

      var cell16 = sheet.cell(CellIndex.indexByString("P3"));
      cell16.value = "state";
      cell16.cellStyle = cellStyle;

      var cell17 = sheet.cell(CellIndex.indexByString("Q3"));
      cell17.value = "Zip";
      cell17.cellStyle = cellStyle;
      var cell19 = sheet.cell(CellIndex.indexByString("R3"));
      cell19.value = "latitude";
      cell19.cellStyle = cellStyle;
      var cell20 = sheet.cell(CellIndex.indexByString("S3"));
      cell20.value = "longitude";
      cell20.cellStyle = cellStyle;
      var cell21 = sheet.cell(CellIndex.indexByString("T3"));
      cell21.value = "cir";
      cell21.cellStyle = cellStyle;
      var cell22 = sheet.cell(CellIndex.indexByString("U3"));
      cell22.value = "port";
      cell22.cellStyle = cellStyle;
      var cell23 = sheet.cell(CellIndex.indexByString("V3"));
      cell23.value = "handoff";
      cell23.cellStyle = cellStyle;

      //Sección Apops
      // Titulo de los apops
      var cell37 = sheet.cell(CellIndex.indexByString("W3"));
      cell37.value = "APOPS";
      cell37.cellStyle = cellStyle;

      var cell24 = sheet.cell(CellIndex.indexByString("W4"));
      cell24.value = "apopstreet";
      cell24.cellStyle = cellStyle;
      var cell25 = sheet.cell(CellIndex.indexByString("X4"));
      cell25.value = "apopcity";
      cell25.cellStyle = cellStyle;
      var cell26 = sheet.cell(CellIndex.indexByString("Y4"));
      cell26.value = "apopstate";
      cell26.cellStyle = cellStyle;
      var cell27 = sheet.cell(CellIndex.indexByString("Z4"));
      cell27.value = "apopzip";
      cell27.cellStyle = cellStyle;
      var cell28 = sheet.cell(CellIndex.indexByString("AA4"));
      cell28.value = "apoplat";
      cell28.cellStyle = cellStyle;
      var cell29 = sheet.cell(CellIndex.indexByString("AB4"));
      cell29.value = "apoplong";
      cell29.cellStyle = cellStyle;

      //Seccion  BPOPS
      var cell38 = sheet.cell(CellIndex.indexByString("AC3"));
      cell38.value = "BPOPS";
      cell38.cellStyle = cellStyle;

      var cell30 = sheet.cell(CellIndex.indexByString("AC4"));
      cell30.value = "bpopstreet";
      cell30.cellStyle = cellStyle;
      var cell31 = sheet.cell(CellIndex.indexByString("AD4"));
      cell31.value = "bpopcity";
      cell31.cellStyle = cellStyle;
      var cell32 = sheet.cell(CellIndex.indexByString("AE4"));
      cell32.value = "bpopstate";
      cell32.cellStyle = cellStyle;
      var cell33 = sheet.cell(CellIndex.indexByString("AF4"));
      cell33.value = "bpopzip";
      cell33.cellStyle = cellStyle;
      var cell34 = sheet.cell(CellIndex.indexByString("AG4"));
      cell34.value = "bpoplat";
      cell34.cellStyle = cellStyle;
      var cell35 = sheet.cell(CellIndex.indexByString("AH4"));
      cell35.value = "bpoplong";
      cell35.cellStyle = cellStyle;
      var cell36 = sheet.cell(CellIndex.indexByString("AI4"));
      cell36.value = "notes";
      cell36.cellStyle = cellStyle;

      //sortear por su Id
      // listCircuits.sort((a, b) => a.pccid!.compareTo(b.pccid!));

      for (int x = 0; x < listCircuits.length; x++) {
        // print("listCircuits: ${listCircuits[x].id}");
        circuitList.add(listCircuits[x]);
      }

      //Agregar datos
      for (int i = 0; i < circuitList.length; i++) {
        // await getCircuits();
        Circuits report = circuitList[i];

        final List<dynamic> row = [
          report.pccid,
          report.rtaCustomer,
          report.cktstatus,
          report.gemap,
          report.carrier,
          report.ckttype,
          report.cktuse,
          report.cktid,
          report.evc,
          report.caracctnum,
          report.carcontid,
          report.contexp,
          report.contlength,
          report.street,
          report.city,
          report.state,
          report.zip,
          report.latitude,
          report.longitude,
          report.cir,
          report.port,
          report.handoff,
          report.apopstreet,
          report.apopcity,
          report.apopstate,
          report.apopzip,
          report.apoplat,
          report.apoplong,
          report.bpopstreet,
          report.bpopcity,
          report.bpopstate,
          report.bpopzip,
          report.bpoplat,
          report.bpoplong,
          report.notes,
        ];
        sheet.appendRow(row);
      }

      //Descargar
      final List<int>? fileBytes = excel.save(fileName: "RTA_Circuits.xlsx");
      //Limpiar controladores y variables
      dateExportDataController.text = "";

      if (fileBytes == null) return false;
      print("Se acabo el proceso");

      return true;
    } catch (e) {
      print("Error in excelActivityReport -$e");
      return false;
    }
  }

  // Excel de los reportes
  Future<bool> excelActivityReportsTowers() async {
    try {
      // Crear excel
      Excel excel = Excel.createExcel();
      Sheet? sheet = excel.sheets[excel.getDefaultSheet()];

      // Verificar si el sheet es null
      if (sheet == null) return false;

      // TITULO
      sheet.merge(CellIndex.indexByString("B1"), CellIndex.indexByString("C1"));

      // Headers de la Tabla
      const headers = [
        "Company",
        "Name",
        "Height",
        "Type",
        "Address",
        "City",
        "Longitude",
        "Latitude",
        "Leased_Owned",
        "Lessor",
        "Licensed",
        "Use",
        "Make",
        "Model",
        "numb_customer_served",
        "Frequency"
      ];
      const headerCells = [
        "A3",
        "B3",
        "C3",
        "D3",
        "E3",
        "F3",
        "G3",
        "H3",
        "I3",
        "J3",
        "K3",
        "L3",
        "M3",
        "N3",
        "O3",
        "P3"
      ];

      for (int i = 0; i < headers.length; i++) {
        sheet.merge(CellIndex.indexByString(headerCells[i]),
            CellIndex.indexByString(headerCells[i][0] + '4'));
        var cell = sheet.cell(CellIndex.indexByString(headerCells[i]));
        cell.value = headers[i];
        cell.cellStyle = CellStyle(
          backgroundColorHex: "#1E90FF",
          fontColorHex: Colors.white.value.toRadixString(16),
          fontFamily: getFontFamily(FontFamily.Calibri),
          fontSize: 16,
          bold: true,
          horizontalAlign: HorizontalAlign.Center,
          verticalAlign: VerticalAlign.Center,
        );
      }

      // Ajustar anchura de algunas columnas
      const colWidths = {
        1: 25,
        4: 25,
        8: 25,
        9: 35,
        12: 25,
        13: 25
      }; // Posición - width
      colWidths.forEach((col, width) {
        sheet.setColWidth(col, width.toDouble());
      });

      // Estilo del título
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
      cellT2.value = "RTA Towers";
      cellT2.cellStyle = titulo;

      // Agregar línea vacía
      sheet.appendRow(['']);
      String getCompanyName(int? companyId) {
        switch (companyId) {
          case 1:
            return 'CRY';
          case 2:
            return 'ODE';
          case 3:
            return 'SMI';
          default:
            return '';
        }
      }

      // Agregar datos
      for (int i = 0; i < listTowers.length; i++) {
        TowerRta report = listTowers[i];
        final List<dynamic> row = [
          // report.companyId,
          getCompanyName(report.companyId),
          report.name,
          report.height,
          report.type,
          report.address,
          report.city,
          report.long,
          report.lat,
          report.leasedOwned,
          report.lessor,
          report.licensed,
          report.use,
          report.make,
          report.model,
          report.numbCustomerServed,
          report.frequency,
        ];
        sheet.appendRow(row);
      }

      // Descargar
      final List<int>? fileBytes = excel.save(fileName: "RTA_Towers.xlsx");

      // Limpiar controladores y variables
      dateExportDataController.text = "";

      if (fileBytes == null) return false;
      print("Se acabo el proceso");

      return true;
    } catch (e) {
      print("Error in excelActivityReport - $e");
      return false;
    }
  }
  // Future<bool> excelActivityReportsTowers() async {
  //   try {
  //     //Crear excel
  //     Excel excel = Excel.createExcel();
  //     Sheet? sheet = excel.sheets[excel.getDefaultSheet()];
  //     print("Length towers: ${listTowers.length}");
  //     // List<TowerRta> towerList = [];
  //     //TITULO
  //     sheet?.merge(
  //         CellIndex.indexByString("B1"), CellIndex.indexByString("C1"));
  //     //Headers de la Tabla, aqui juntamos los dos renglones para una mejor vista.
  //     sheet?.merge(CellIndex.indexByString("A3"),
  //         CellIndex.indexByString("A4")); // Company
  //     sheet?.merge(
  //         CellIndex.indexByString("B3"), CellIndex.indexByString("B4")); // name
  //     sheet?.merge(CellIndex.indexByString("C3"),
  //         CellIndex.indexByString("C4")); // Height
  //     sheet?.merge(
  //         CellIndex.indexByString("D3"), CellIndex.indexByString("D4")); // type
  //     sheet?.merge(CellIndex.indexByString("E3"),
  //         CellIndex.indexByString("E4")); // Address
  //     sheet?.merge(
  //         CellIndex.indexByString("F3"), CellIndex.indexByString("F4")); // city
  //     sheet?.merge(
  //         CellIndex.indexByString("G3"), CellIndex.indexByString("G4")); // Long
  //     sheet?.merge(
  //         CellIndex.indexByString("H3"), CellIndex.indexByString("H4")); // Lat
  //     sheet?.merge(CellIndex.indexByString("I3"),
  //         CellIndex.indexByString("I4")); // Leased_owned
  //     sheet?.merge(CellIndex.indexByString("J3"),
  //         CellIndex.indexByString("J4")); // Lessor
  //     sheet?.merge(CellIndex.indexByString("K3"),
  //         CellIndex.indexByString("K4")); // Licensed
  //     sheet?.merge(
  //         CellIndex.indexByString("L3"), CellIndex.indexByString("L4")); // Use
  //     sheet?.merge(
  //         CellIndex.indexByString("M3"), CellIndex.indexByString("M4")); // Make
  //     sheet?.merge(CellIndex.indexByString("N3"),
  //         CellIndex.indexByString("N4")); // Model
  //     sheet?.merge(CellIndex.indexByString("O3"),
  //         CellIndex.indexByString("O4")); // numb_customer_served
  //     sheet?.merge(CellIndex.indexByString("P3"),
  //         CellIndex.indexByString("P4")); // Frequency
  //     // sheet?.merge(
  //     //     CellIndex.indexByString("Q3"), CellIndex.indexByString("Q4"));

  //     // sheet?.merge(
  //     //     CellIndex.indexByString("R3"), CellIndex.indexByString("R4"));
  //     // sheet?.merge(
  //     //     CellIndex.indexByString("S3"), CellIndex.indexByString("S4"));
  //     // sheet?.merge(
  //     //     CellIndex.indexByString("T3"), CellIndex.indexByString("T4"));
  //     // sheet?.merge(
  //     //     CellIndex.indexByString("U3"), CellIndex.indexByString("U4"));
  //     // sheet?.merge(
  //     //     CellIndex.indexByString("V3"), CellIndex.indexByString("V4"));

  //     // //Headers para secciones
  //     // // Fusión Apops
  //     // sheet?.merge(
  //     //     CellIndex.indexByString("W3"), CellIndex.indexByString("AB3"));
  //     // // Fusión BPOPS
  //     // sheet?.merge(
  //     //     CellIndex.indexByString("AC3"), CellIndex.indexByString("AH3"));

  //     // Aqui damos por ejemplo el primero es el numero de columna y el segundo el width de está
  //     sheet?.setColWidth(1, 25);
  //     sheet?.setColWidth(7, 25);
  //     sheet?.setColWidth(10, 25);
  //     // sheet?.setColWidth(11, 25); // ContEXP
  //     // sheet?.setColWidth(13, 25); // Street
  //     // sheet?.setColWidth(22, 25); // APOPSTREET
  //     // sheet?.setColWidth(28, 25); // BPOPSTREET

  //     // sheet?.setColWidth(5, 30);
  //     // sheet?.setColWidth(11, 50);
  //     // sheet?.setColWidth(12, 50);
  //     // sheet?.setColWidth(13, 50);
  //     // sheet?.setColWidth(14, 25);
  //     // sheet?.setColWidth(15, 30);
  //     // sheet?.setColWidth(18, 30);
  //     // sheet?.setColWidth(20, 30);
  //     // sheet?.setColWidth(26, 30);
  //     // sheet?.setColWidth(28, 30);

  //     if (sheet == null) return false;
  //     CellStyle titulo = CellStyle(
  //       fontFamily: getFontFamily(FontFamily.Calibri),
  //       fontSize: 16,
  //       bold: true,
  //       horizontalAlign: HorizontalAlign.Center,
  //       verticalAlign: VerticalAlign.Center,
  //     );

  //     // Son los princiaples
  //     var cellT = sheet.cell(CellIndex.indexByString("A1"));
  //     cellT.value = "Title";
  //     cellT.cellStyle = titulo;

  //     var cellT2 = sheet.cell(CellIndex.indexByString("B1"));
  //     cellT2.value = "RTA Towers";
  //     cellT2.cellStyle = titulo;

  //     //Agregar primera linea
  //     sheet.appendRow(['']);
  //     //Agregar linea vacia

  //     //blanco, bold y mas grande
  //     CellStyle cellStyle = CellStyle(
  //       backgroundColorHex: "#1E90FF",
  //       fontColorHex: Colors.white.value.toRadixString(16),
  //       fontFamily: getFontFamily(FontFamily.Calibri),
  //       fontSize: 16,
  //       bold: true,
  //       horizontalAlign: HorizontalAlign.Center,
  //       verticalAlign: VerticalAlign.Center,
  //     );
  //     var cell = sheet.cell(CellIndex.indexByString("A3"));
  //     cell.value = "Company";
  //     cell.cellStyle = cellStyle;

  //     var cell2 = sheet.cell(CellIndex.indexByString("B3"));
  //     cell2.value = "Name";
  //     cell2.cellStyle = cellStyle;

  //     var cell3 = sheet.cell(CellIndex.indexByString("C3"));
  //     cell3.value = "Height";
  //     cell3.cellStyle = cellStyle;

  //     var cell4 = sheet.cell(CellIndex.indexByString("D3"));
  //     cell4.value = "Type";
  //     cell4.cellStyle = cellStyle;

  //     var cell5 = sheet.cell(CellIndex.indexByString("E3"));
  //     cell5.value = "Address";
  //     cell5.cellStyle = cellStyle;

  //     var cell6 = sheet.cell(CellIndex.indexByString("F3"));
  //     cell6.value = "City";
  //     cell6.cellStyle = cellStyle;

  //     var cell7 = sheet.cell(CellIndex.indexByString("G3"));
  //     cell7.value = "Longitude";
  //     cell7.cellStyle = cellStyle;

  //     var cell8 = sheet.cell(CellIndex.indexByString("H3"));
  //     cell8.value = "Latitude";
  //     cell8.cellStyle = cellStyle;

  //     var cell9 = sheet.cell(CellIndex.indexByString("I3"));
  //     cell9.value = "Leased_Owned";
  //     cell9.cellStyle = cellStyle;

  //     var cell10 = sheet.cell(CellIndex.indexByString("J3"));
  //     cell10.value = "Lessor";
  //     cell10.cellStyle = cellStyle;

  //     var cell11 = sheet.cell(CellIndex.indexByString("K3"));
  //     cell11.value = "Licensed";
  //     cell11.cellStyle = cellStyle;

  //     var cell12 = sheet.cell(CellIndex.indexByString("L3"));
  //     cell12.value = "Use";
  //     cell12.cellStyle = cellStyle;

  //     var cell13 = sheet.cell(CellIndex.indexByString("M3"));
  //     cell13.value = "Make";
  //     cell13.cellStyle = cellStyle;

  //     var cell14 = sheet.cell(CellIndex.indexByString("N3"));
  //     cell14.value = "Model";
  //     cell14.cellStyle = cellStyle;

  //     var cell15 = sheet.cell(CellIndex.indexByString("O3"));
  //     cell15.value = "numb_customer_served";
  //     cell15.cellStyle = cellStyle;
  //     var cell16 = sheet.cell(CellIndex.indexByString("P3"));
  //     cell15.value = "Frequency";
  //     cell15.cellStyle = cellStyle;

  //     //sortear por su Id
  //     // listCircuits.sort((a, b) => a.pccid!.compareTo(b.pccid!));

  //     for (int x = 0; x < listTowers.length; x++) {
  //       // print("listCircuits: ${towerList[x].id}");
  //       listTowers.add(listTowers[x]);
  //     }

  //     //Agregar datos
  //     for (int i = 0; i < listTowers.length; i++) {
  //       // await getCircuits();
  //       TowerRta report = listTowers[i];

  //       final List<dynamic> row = [
  //         report.companyId,
  //         // companyName,
  //         report.name,
  //         report.height,
  //         report.type,
  //         report.address,
  //         report.city,
  //         report.long,
  //         report.lat,
  //         report.leasedOwned,
  //         report.lessor,
  //         report.licensed,
  //         report.use,
  //         report.make,
  //         report.model,
  //         report.numbCustomerServed,
  //         report.frequency,
  //       ];
  //       sheet.appendRow(row);
  //     }

  //     //Descargar
  //     final List<int>? fileBytes = excel.save(fileName: "RTA_Towers.xlsx");
  //     //Limpiar controladores y variables
  //     dateExportDataController.text = "";

  //     if (fileBytes == null) return false;
  //     print("Se acabo el proceso");

  //     return true;
  //   } catch (e) {
  //     print("Error in excelActivityReport -$e");
  //     return false;
  //   }
  // }
}
