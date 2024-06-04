import 'dart:convert';
import 'dart:developer';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/dashboard_rta/circuits.dart';
import 'package:rta_crm_cv/models/dashboard_rta/comments.dart';
import 'package:rta_crm_cv/public/colors.dart';

class CircuitsProvider extends ChangeNotifier {
  int pageRowCount = 11;
  int page = 1;
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];

  // Individual
  Circuits? circuitSelected;
  // Listas
  List<Circuits> listCircuits = [];

  // Controladores
  final searchController = TextEditingController();
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
    rows.clear();
    await getCircuits();
  }

  // final commentController = TextEditingController();
  List<CommentCircuit> comments = [];

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

  Future<void> getCircuits() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      // SUPBASECTRlV es el control vehicular

      final query = supabaseDashboard
          .from('circuits_view')
          .select()
          // .or(
          //     'rta_customer.ilike.%${searchController.text}%,pccid.ilike.%${searchController.text}%,ckttype.ilike.%${searchController.text}%,carrier.ilike.%${searchController.text}%)');

          .like('rta_customer | pccid', '%${searchController.text}%');

      final res = await query;
      // final res = await supabaseDashboard.from('circuits_view').select();

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

  // Nos trae la información de los trainings por usuarios
  Future<void> getInformationCircuit(int id) async {
    try {
      circuitSelected = listCircuits.firstWhere((element) => element.id == id);
      pccidController.text = circuitSelected!.pccid.toString();
      rtaCustomerController.text = circuitSelected!.rtaCustomer.toString();
      cktStatusController.text = circuitSelected!.cktstatus!;
      geMapController.text = circuitSelected!.gemap!;
      carrierController.text = circuitSelected!.carrier!;
      cktTypeController.text = circuitSelected!.cktid!;
      cktUseController.text = circuitSelected!.cktuse!;
      cktIDController.text = circuitSelected!.cktid!;
      evcController.text = circuitSelected!.evc!;
      caracctnumController.text = circuitSelected!.caracctnum!;
      carcontIDController.text = circuitSelected!.carcontid!.toString();
      contexpController.text =
          DateFormat("MM/dd/yyyy").format(circuitSelected!.contexp!);
      contLengthController.text = circuitSelected!.contlength!.toString();
      streetController.text = circuitSelected!.street!;
      cityController.text = circuitSelected!.city!;
      stateController.text = circuitSelected!.state!;
      zipController.text = circuitSelected!.zip!.toString();
      latitudeController.text = circuitSelected!.latitude!;
      longitudeController.text = circuitSelected!.longitude!;
      cirController.text = circuitSelected!.cir!.toString();
      portController.text = circuitSelected!.port!.toString();
      handoffController.text = circuitSelected!.handoff!;
      apopStreetController.text = circuitSelected!.apopstreet!;
      apopCityController.text = circuitSelected!.apopcity!;
      apopStateController.text = circuitSelected!.apopzip.toString();
      apopZipController.text = circuitSelected!.apopzip.toString();
      apopLatitudeController.text = circuitSelected!.apoplat!;
      apopLongitudeController.text = circuitSelected!.apoplong!;
      bpopStreetController.text = circuitSelected!.bpopstreet!;
      bpopCityController.text = circuitSelected!.bpopcity!;
      bpopStateController.text = circuitSelected!.bpopstate!;
      bpopZipController.text = circuitSelected!.bpopzip.toString();
      bpopLatitudeController.text = circuitSelected!.bpoplat!;
      bpopLongitudeController.text = circuitSelected!.bpoplong!;
      // commentsController.text = circuitSelected!.notes!;
    } catch (e) {
      print('Error en getInformationTraining() - $e');
    }
  }

  Future<bool> excelActivityReports() async {
    try {
      //Crear excel
      Excel excel = Excel.createExcel();
      Sheet? sheet = excel.sheets[excel.getDefaultSheet()];
      await getCircuits();
      List<Circuits> circuitList = [];
      print("Circuits length :${listCircuits.length}");

      print("Boton excelActivityReports presionado");
      //TITULO
      sheet?.merge(
          CellIndex.indexByString("B1"), CellIndex.indexByString("C1"));
      //Headers de la Tabla

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
      //Headers para secciones
      sheet?.merge(
          CellIndex.indexByString("Q3"), CellIndex.indexByString("X3"));
      sheet?.merge(
          CellIndex.indexByString("Y3"), CellIndex.indexByString("AF3"));

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

      var cell17 = sheet.cell(CellIndex.indexByString("Q4"));
      cell17.value = "Zip";
      cell17.cellStyle = cellStyle;
      var cell19 = sheet.cell(CellIndex.indexByString("R4"));
      cell19.value = "latitude";
      cell19.cellStyle = cellStyle;
      var cell20 = sheet.cell(CellIndex.indexByString("S4"));
      cell20.value = "longitude";
      cell20.cellStyle = cellStyle;
      var cell21 = sheet.cell(CellIndex.indexByString("T4"));
      cell21.value = "cir";
      cell21.cellStyle = cellStyle;
      var cell22 = sheet.cell(CellIndex.indexByString("U4"));
      cell22.value = "port";
      cell22.cellStyle = cellStyle;
      var cell23 = sheet.cell(CellIndex.indexByString("V4"));
      cell23.value = "handoff";
      cell23.cellStyle = cellStyle;

      //Sección Apops
      // Titulo de los apops
      var cell37 = sheet.cell(CellIndex.indexByString("Q3"));
      cell37.value = "APOPS";
      cell37.cellStyle = cellStyle;

      var cell24 = sheet.cell(CellIndex.indexByString("W4"));
      cell24.value = "apopstreet";
      cell24.cellStyle = cellStyle;

      var cell25 = sheet.cell(CellIndex.indexByString("Y4"));
      cell25.value = "apopcity";
      cell25.cellStyle = cellStyle;
      var cell26 = sheet.cell(CellIndex.indexByString("Z4"));
      cell26.value = "apopstate";
      cell26.cellStyle = cellStyle;
      var cell27 = sheet.cell(CellIndex.indexByString("AA4"));
      cell27.value = "apopzip";
      cell27.cellStyle = cellStyle;
      var cell28 = sheet.cell(CellIndex.indexByString("AB4"));
      cell28.value = "apoplat";
      cell28.cellStyle = cellStyle;
      var cell29 = sheet.cell(CellIndex.indexByString("AC4"));
      cell29.value = "apoplong";
      cell29.cellStyle = cellStyle;
      var cell30 = sheet.cell(CellIndex.indexByString("AD4"));

      //Seccion  BPOPS
      var cell38 = sheet.cell(CellIndex.indexByString("AB3"));
      cell38.value = "BPOPS";
      cell38.cellStyle = cellStyle;

      cell30.value = "bpopstreet";
      cell30.cellStyle = cellStyle;
      var cell31 = sheet.cell(CellIndex.indexByString("AE4"));
      cell31.value = "bpopcity";
      cell31.cellStyle = cellStyle;
      var cell32 = sheet.cell(CellIndex.indexByString("AF4"));
      cell32.value = "bpopstate";
      cell32.cellStyle = cellStyle;
      var cell33 = sheet.cell(CellIndex.indexByString("AG4"));
      cell33.value = "bpopzip";
      cell33.cellStyle = cellStyle;
      var cell34 = sheet.cell(CellIndex.indexByString("AH4"));
      cell34.value = "bpoplat";
      cell34.cellStyle = cellStyle;
      var cell35 = sheet.cell(CellIndex.indexByString("AI4"));
      cell35.value = "bpoplong";
      cell35.cellStyle = cellStyle;
      var cell36 = sheet.cell(CellIndex.indexByString("AJ4"));
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
      //   var cell = sheet
      //       .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 3));
      //   cell.cellStyle = CellStyle(
      //     backgroundColorHex: colorFinal, // Cambia el color aquí
      //   );

      //   var cellCO = sheet
      //       .cell(CellIndex.indexByColumnRow(columnIndex: 23, rowIndex: i + 2));
      //   var style = cellCO.cellStyle ?? CellStyle();
      //   style.rightBorder.borderStyle;
      //   cellCO.cellStyle = style;
      // }

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
}
