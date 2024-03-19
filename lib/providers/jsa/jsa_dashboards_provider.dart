import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdfx/pdfx.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/jsa/jsa.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import '../../models/jsa/jsa_document_list.dart';

class JSADashboardProvider extends ChangeNotifier {
  bool istaped = false;
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  int pageRowCount = 10;
  int page = 1;
  List<JsaDocumentList> jsaDocuments = [];
  List<Jsa> listJSA = [];
  int jsaDraft = 0;
  int jsaSigned = 0;
  int jsaPending = 0;
  PdfController? pdfController;
  DateTimeRange dateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 28)),
      end: DateTime.now());

  bool loadingGrid = false;
  late Uint8List documento;

  ///////////// Signed /////////////
  double actualMonthEndSigned = 0;
  double oneMonthAgoEndSigned = 0;
  double twoMonthsAgoEndSigned = 0;
  double threeMonthsAgoEndSigned = 0;
  double fourMonthsAgoEndSigned = 0;
  double fiveMonthsAgoEndSigned = 0;
  double sixMonthsAgoEndSigned = 0;
  double sevenMonthsAgoEndSigned = 0;
  double eightMonthsAgoEndSigned = 0;
  double nineMonthsAgoEndSigned = 0;
  double tenMonthsAgoEndSigned = 0;
  double elevenMonthsAgoEndSigned = 0;

  ///////////// Pending /////////////
  double actualMonthEndPending = 0;
  double oneMonthAgoEndPending = 0;
  double twoMonthsAgoEndPending = 0;
  double threeMonthsAgoEndPending = 0;
  double fourMonthsAgoEndPending = 0;
  double fiveMonthsAgoEndPending = 0;
  double sixMonthsAgoEndPending = 0;
  double sevenMonthsAgoEndPending = 0;
  double eightMonthsAgoEndPending = 0;
  double nineMonthsAgoEndPending = 0;
  double tenMonthsAgoEndPending = 0;
  double elevenMonthsAgoEndPending = 0;
  ///////////// Draft /////////////
  double actualMonthEndDraft = 0;
  double oneMonthAgoEndDraft = 0;
  double twoMonthsAgoEndDraft = 0;
  double threeMonthsAgoEndDraft = 0;
  double fourMonthsAgoEndDraft = 0;
  double fiveMonthsAgoEndDraft = 0;
  double sixMonthsAgoEndDraft = 0;
  double sevenMonthsAgoEndDraft = 0;
  double eightMonthsAgoEndDraft = 0;
  double nineMonthsAgoEndDraft = 0;
  double tenMonthsAgoEndDraft = 0;
  double elevenMonthsAgoEndDraft = 0;

  Future<void> updateState() async {
    loadingGrid = false;
    await getDashboards();
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

  Future<void> getDashboards() async {
    jsaDraft = 0;
    jsaPending = 0;
    jsaSigned = 0;
    listJSA = [];
    actualMonthEndSigned = 0;
    oneMonthAgoEndSigned = 0;
    twoMonthsAgoEndSigned = 0;
    threeMonthsAgoEndSigned = 0;
    fiveMonthsAgoEndSigned = 0;
    sixMonthsAgoEndSigned = 0;
    sevenMonthsAgoEndSigned = 0;
    eightMonthsAgoEndSigned = 0;
    nineMonthsAgoEndSigned = 0;
    tenMonthsAgoEndSigned = 0;
    elevenMonthsAgoEndSigned = 0;

    ///////////// Pending /////////////
    actualMonthEndPending = 0;
    oneMonthAgoEndPending = 0;
    twoMonthsAgoEndPending = 0;
    threeMonthsAgoEndPending = 0;
    fourMonthsAgoEndPending = 0;
    fiveMonthsAgoEndPending = 0;
    sixMonthsAgoEndPending = 0;
    sevenMonthsAgoEndPending = 0;
    eightMonthsAgoEndPending = 0;
    nineMonthsAgoEndPending = 0;
    tenMonthsAgoEndPending = 0;
    elevenMonthsAgoEndPending = 0;
    ///////////// Draft /////////////
    actualMonthEndDraft = 0;
    oneMonthAgoEndDraft = 0;
    twoMonthsAgoEndDraft = 0;
    threeMonthsAgoEndDraft = 0;
    fourMonthsAgoEndDraft = 0;
    fiveMonthsAgoEndDraft = 0;
    sixMonthsAgoEndDraft = 0;
    sevenMonthsAgoEndDraft = 0;
    eightMonthsAgoEndDraft = 0;
    nineMonthsAgoEndDraft = 0;
    tenMonthsAgoEndDraft = 0;
    elevenMonthsAgoEndDraft = 0;

    try {
      if (currentUser!.isAdminJSA) {
        final res = await supabaseJsa.from('jsa_view').select();
        if (res == null) {
          print('Error en getDocumentList()');
          return;
        }
        // print(res);
        listJSA = (res as List<dynamic>)
            .map((jSA) => Jsa.fromJson(jsonEncode(jSA)))
            .toList();
      } else {
        final res = await supabaseJsa
            .from('jsa_view')
            .select()
            .eq('company_fk', currentUser!.company_fk);
        if (res == null) {
          print('Error en getDocumentList()');
          return;
        }
        // print(res);
        listJSA = (res as List<dynamic>)
            .map((jSA) => Jsa.fromJson(jsonEncode(jSA)))
            .toList();
      }
      // final res = await supabaseJsa.from('jsa_view').select();
      // if (res == null) {
      //   print('Error en getDocumentList()');
      //   return;
      // }
      // // print(res);
      // listJSA = (res as List<dynamic>)
      //     .map((jSA) => Jsa.fromJson(jsonEncode(jSA)))
      //     .toList();

      // print("ListJSA.length = ${listJSA.length}");

      // final res = await supabaseJsa.from('jsa_view').select();

      // // if (res == null) {
      // //   print('Error en getDashboards()');
      // //   return;
      // // }
      // listJSA = (res as List<dynamic>)
      //     .map((jSA) => Jsa.fromJson(jsonEncode(jSA)))
      //     .toList();
      print("La lista de los jsa son: ${listJSA.length}");
      rows.clear();
      for (Jsa jsa in listJSA) {
        // print("-------- Los id son: ${jsa.id}");
        DateTime dateAdded = DateTime.parse(jsa.toMap()["created_at"]);
        if (jsa.idStatus == 1) {
          jsaDraft++;
          if (dateAdded.month == dateRange.end.month) actualMonthEndDraft++;
          if (dateAdded.month == (dateRange.end.month - 1) &&
              dateAdded.isAfter(dateRange.start)) oneMonthAgoEndDraft++;
          if (dateAdded.month == (dateRange.end.month - 2) &&
              dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndDraft++;
          if (dateAdded.month == (dateRange.end.month - 3) &&
              dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndDraft++;
          if (dateAdded.month == (dateRange.end.month - 4) &&
              dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndDraft++;
          if (dateAdded.month == (dateRange.end.month - 5) &&
              dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndDraft++;
          if (dateAdded.month == (dateRange.end.month - 6) &&
              dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndDraft++;
          if (dateAdded.month == (dateRange.end.month - 7) &&
              dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndDraft++;
          if (dateAdded.month == (dateRange.end.month - 8) &&
              dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndDraft++;
          if (dateAdded.month == (dateRange.end.month - 9) &&
              dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndDraft++;
          if (dateAdded.month == (dateRange.end.month - 10) &&
              dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndDraft++;
          if (dateAdded.month == (dateRange.end.month - 11) &&
              dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndDraft++;
        }
        if (jsa.idStatus == 2) {
          jsaPending++;
          // print("jsaPending $jsaPending");
          if (dateAdded.month == dateRange.end.month) actualMonthEndPending++;
          if (dateAdded.month == (dateRange.end.month - 1) &&
              dateAdded.isAfter(dateRange.start)) oneMonthAgoEndPending++;
          if (dateAdded.month == (dateRange.end.month - 2) &&
              dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndPending++;
          if (dateAdded.month == (dateRange.end.month - 3) &&
              dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndPending++;
          if (dateAdded.month == (dateRange.end.month - 4) &&
              dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndPending++;
          if (dateAdded.month == (dateRange.end.month - 5) &&
              dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndPending++;
          if (dateAdded.month == (dateRange.end.month - 6) &&
              dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndPending++;
          if (dateAdded.month == (dateRange.end.month - 7) &&
              dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndPending++;
          if (dateAdded.month == (dateRange.end.month - 8) &&
              dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndPending++;
          if (dateAdded.month == (dateRange.end.month - 9) &&
              dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndPending++;
          if (dateAdded.month == (dateRange.end.month - 10) &&
              dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndPending++;
          if (dateAdded.month == (dateRange.end.month - 11) &&
              dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndPending++;
        }
        if (jsa.idStatus == 3) {
          jsaSigned++;
          // print("jsaSigned $jsaSigned");
          if (dateAdded.month == dateRange.end.month) actualMonthEndSigned++;
          if (dateAdded.month == (dateRange.end.month - 1) &&
              dateAdded.isAfter(dateRange.start)) oneMonthAgoEndSigned++;
          if (dateAdded.month == (dateRange.end.month - 2) &&
              dateAdded.isAfter(dateRange.start)) twoMonthsAgoEndSigned++;
          if (dateAdded.month == (dateRange.end.month - 3) &&
              dateAdded.isAfter(dateRange.start)) threeMonthsAgoEndSigned++;
          if (dateAdded.month == (dateRange.end.month - 4) &&
              dateAdded.isAfter(dateRange.start)) fourMonthsAgoEndSigned++;
          if (dateAdded.month == (dateRange.end.month - 5) &&
              dateAdded.isAfter(dateRange.start)) fiveMonthsAgoEndSigned++;
          if (dateAdded.month == (dateRange.end.month - 6) &&
              dateAdded.isAfter(dateRange.start)) sixMonthsAgoEndSigned++;
          if (dateAdded.month == (dateRange.end.month - 7) &&
              dateAdded.isAfter(dateRange.start)) sevenMonthsAgoEndSigned++;
          if (dateAdded.month == (dateRange.end.month - 8) &&
              dateAdded.isAfter(dateRange.start)) eightMonthsAgoEndSigned++;
          if (dateAdded.month == (dateRange.end.month - 9) &&
              dateAdded.isAfter(dateRange.start)) nineMonthsAgoEndSigned++;
          if (dateAdded.month == (dateRange.end.month - 10) &&
              dateAdded.isAfter(dateRange.start)) tenMonthsAgoEndSigned++;
          if (dateAdded.month == (dateRange.end.month - 11) &&
              dateAdded.isAfter(dateRange.start)) elevenMonthsAgoEndSigned++;
        }
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: jsa.id),
              'CREATED_Column': PlutoCell(value: jsa.employee!.name),
              'TITLE_Column': PlutoCell(value: jsa.title),
              'NUM_EMPL_Column': PlutoCell(value: jsa.usersjsa.length),
              'CREATION_Column': PlutoCell(
                  value: DateFormat("MMM/dd/yyyy").format(jsa.createdAt!)),
              'SEND_Column': PlutoCell(
                  value: DateFormat("MMM/dd/yyyy").format(jsa.createdAt!)),
              'STATUS_Column': PlutoCell(value: jsa.status),
              'PREVIEW_Column': PlutoCell(value: jsa.docName),
            },
          ),
        );
      }
      // print("jsaDraft: $jsaDraft");

      // print("actualMonthEndDraft: $actualMonthEndDraft");
      // print("oneMonthAgoEndDraft: $oneMonthAgoEndDraft");
      // print("twoMonthsAgoEndDraft: $twoMonthsAgoEndDraft");
      // print("threeMonthsAgoEndDraft: $threeMonthsAgoEndDraft");
      // print("fourMonthsAgoEndDraft: $fourMonthsAgoEndDraft");
      // print("fiveMonthsAgoEndDraft: $fiveMonthsAgoEndDraft");
      // print("sixMonthsAgoEndDraft: $sixMonthsAgoEndDraft");
      // print("sevenMonthsAgoEndDraft: $sevenMonthsAgoEndDraft");
      // print("eightMonthsAgoEndDraft: $eightMonthsAgoEndDraft");
      // print("nineMonthsAgoEndDraft: $nineMonthsAgoEndDraft");
      // print("tenMonthsAgoEndDraft: $tenMonthsAgoEndDraft");
      // print("elevenMonthsAgoEndDraft: $elevenMonthsAgoEndDraft");
      notifyListeners();
    } catch (e) {
      print('Error en getDashboards() - $e');
    }
  }

  Future<void> pickDocument(String document) async {
    try {
      var url = supabase.storage.from('jsa/templates').getPublicUrl(document);
      print(url);
      // .getPublicUrl("${jsa.id}_${jsa.createdAt}_14.pdf");
      var bodyBytes = (await http.get(Uri.parse(url))).bodyBytes;
      pdfController = PdfController(document: PdfDocument.openData(bodyBytes));
    } catch (e) {
      log('Error in pickDocument() - $e');
      return;
    }
    return;
  }

  //Descargar PDF
  String pdfUrl = '';
  void descargarArchivo(Uint8List datos, String nombreArchivo) {
    // Crear un Blob con los datos
    final blob = html.Blob([datos]);

    // Crear una URL para el Blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Crear un enlace HTML para la descarga
    final anchor = html.AnchorElement(href: url)
      ..target = 'web'
      ..download = nombreArchivo;

    // Hacer clic en el enlace para iniciar la descarga
    html.document.body?.children.add(anchor);
    anchor.click();

    // Limpiar después de la descarga
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
