// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, unrelated_type_equality_checks, avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:pdfx/pdfx.dart';

import '../../models/jsa/jsa.dart';
import '../../models/jsa/jsa_document_list.dart';
import '../../models/jsa/users_jsa.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

class JSADocumentListProvider extends ChangeNotifier {
  bool istaped = false;

  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  int pageRowCount = 10;
  int page = 1;
  List<JsaDocumentList> jsaDocuments = [];
  List<UsersJsa> usersJsa = [];
  List<Jsa> listJSA = [];
  List<Jsa> listJSAFiltered = [];
  PdfController? pdfController;
  late Uint8List documento;

  List<Jsa> list = [];

  Jsa? jsaSelected;
  int signedUsers = 0;
  List<Usersjsa> filteredUsers = [];
  int numberJSA = 0;

  bool loadingGrid = false;
  Future<void> updateState() async {
    loadingGrid = false;
    await getDocumentList();
  }

  Future<void> getDocumentList() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      if (currentUser!.isManagerJSA) {
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
      } else {
        final res = await supabaseJsa.from('jsa_view').select();
        if (res == null) {
          print('Error en getDocumentList()');
          return;
        }
        // print(res);
        listJSA = (res as List<dynamic>)
            .map((jSA) => Jsa.fromJson(jsonEncode(jSA)))
            .toList();
      }

      // print("En getInformationJSA con el JSA_FK: con res: $res");
      rows.clear();
    } catch (e) {
      print('Error en getDocumentList() - $e');
    }
    notifyListeners();
  }

  void getInformationJSA(int index) {
    try {
      numberJSA = listJSA[index].id!;
      signedUsers = 0;
      rows.clear();
      jsaSelected = listJSA.firstWhere((element) => element.id == numberJSA);

      if (jsaSelected != null) {
        for (Usersjsa user in jsaSelected!.usersjsa) {
          // if (user.role!.application == "JSA") {
          // for (Usersjsa user in filteredUsers) {
          print("UsersName: ${user.name}");
          rows.add(
            PlutoRow(
              cells: {
                'ID_Column': PlutoCell(value: user.userFk),
                'NAME_Column':
                    PlutoCell(value: "${user.name} ${user.lastName}"),
                'ROLE_Column': PlutoCell(value: user.role!.name),
                'STATUS_Column': PlutoCell(value: user.status!.status),
                'DOCUMENT_Column': PlutoCell(value: user.docName),
              },
            ),
          );
          if (user.status!.status == "Signed") {
            signedUsers++;
          }
        }
      }
    } catch (e) {
      print('Error en getInformationJSA() - $e');
    }
    // notifyListeners();
  }

  Future<void> pickDocument(String document) async {
    try {
      var url = supabase.storage.from('jsa/signed_docs').getPublicUrl(document);
      print(url);
      // .getPublicUrl("${jsa.id}_${jsa.createdAt}_14.pdf");
      var bodyBytes = (await http.get(Uri.parse(url))).bodyBytes;
      documento = bodyBytes;

      pdfController = PdfController(document: PdfDocument.openData(bodyBytes));
    } catch (e) {
      log('Error in pickDocument() - $e');
      return;
    }
    return;
  }

  Future<void> filterDocuments(String query) async {
    // print(query);
    // listJSA = listJSA
    //     .where((document) =>
    //         document.title!.toLowerCase().contains(query.toLowerCase()))
    //     .toList();

    if (searchController.text.isEmpty) {
      if (currentUser!.isManagerJSA) {
        final res = await supabaseJsa
            .from('jsa_view')
            .select()
            .eq('company_fk', currentUser!.company_fk);
        if (res == null) {
          print('Error en filterDocuments()');
          return;
        }
        // print(res);
        listJSA = (res as List<dynamic>)
            .map((jSA) => Jsa.fromJson(jsonEncode(jSA)))
            .toList();
      } else {
        final res = await supabaseJsa.from('jsa_view').select();
        if (res == null) {
          print('Error en filterDocuments()');
          return;
        }
        // print(res);
        listJSA = (res as List<dynamic>)
            .map((jSA) => Jsa.fromJson(jsonEncode(jSA)))
            .toList();
      }
    } else {
      // listJSA = listJSA
      //     .where((elemento) =>
      //         elemento.title != null &&
      //         elemento.title!
      //             .toLowerCase()
      //             .contains(searchController.text.toLowerCase()))
      //     .toList();
      print("SearchController: ${searchController.text}");
      listJSA = listJSA
          .where((elemento) =>
              elemento.title != null &&
                  elemento.title!
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()) ||
              elemento.id != null &&
                  elemento.id!.toString().contains(searchController.text))
          .toList();
    }

    // for (var list in listJSA) {
    //   print("Name list: ${list.title}");
    // }

    print("La lista listJSAFiltered: ${listJSA.length}");
    notifyListeners();
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
