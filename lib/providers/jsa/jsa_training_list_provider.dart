import 'dart:convert';
import 'dart:developer';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/jsa/training.dart';
import 'package:rta_crm_cv/models/jsa/user_training.dart';
import 'package:rta_crm_cv/models/user.dart';

class JsaTrainingListProvider extends ChangeNotifier {
  // ------------ Lista de variables ---------------
  List<Training> trainingList = [];
  List<PlutoRow> rows = [];
  // List<User> usersTraining = [];
  List<UserTraining> usersTrainings = [];

  // ------------     Variables   ---------------
  PlutoGridStateManager? stateManager;
  UserTraining? userTrainingSelected;
  int pageRowCount = 10;
  int page = 1;
  bool loadingGrid = false;
  final searchController = TextEditingController();
  PdfController? pdfController;
  Uint8List? documento;

  // UpdateState Admin
  Future<void> updateState() async {
    // await getTrainingList();
    loadingGrid = false;
    await getUsersTraining();
    // notifyListeners();
  }

  // void setPageSize(String x) {
  //   switch (x) {
  //     case 'more':
  //       if (pageRowCount < rows.length) pageRowCount++;
  //       break;
  //     case 'less':
  //       if (pageRowCount > 1) pageRowCount--;
  //       break;
  //     default:
  //       return;
  //   }
  //   stateManager!.createFooter;
  //   // notifyListeners();
  // }

  // void setPage(String x) {
  //   switch (x) {
  //     case 'next':
  //       if (page < stateManager!.totalPage) page++;
  //       break;
  //     case 'previous':
  //       if (page > 1) page--;
  //       break;
  //     case 'start':
  //       page = 1;
  //       break;
  //     case 'end':
  //       page = stateManager!.totalPage;
  //       break;
  //     default:
  //       return;
  //   }
  //   stateManager!.setPage(page);
  //   // notifyListeners();
  // }

  // get de la lista de training, se usa en la pantalla que ve el tecnico
  Future<void> getTrainingList(String userfk) async {
    try {
      final res = await supabaseJsa
          .from('training_view')
          .select()
          .eq('user_fk', userfk);
      // .eq('company_fk', currentUser!.company_fk);
      if (res == null) {
        print('Error en getTrainingList()');
        return;
      }
      trainingList = (res as List<dynamic>)
          .map((training) => Training.fromJson(jsonEncode(training)))
          .toList();
      for (var training in trainingList) {
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: training.idTraining),
              'NAME_Column': PlutoCell(value: training.title),
              'Creation_Column': PlutoCell(value: training.creationDate),
              'Expiration_Column': PlutoCell(value: training.expirationDate),
              'STATUS_Column': PlutoCell(value: training.status.name),
              'DOCUMENT_Column': PlutoCell(value: training.docname),
            },
          ),
        );
      }
      // print("El trainingListLenght es: ${trainingList.length}");
      // print("En getInformationJSA con el JSA_FK: con res: $res");
      // rows.clear();
      notifyListeners();
    } catch (e) {
      print('Error en getTrainingList() - $e');
    }
  }

  // Está función trae los usuarios que tienen asignados trainings
  Future<void> getUsersTraining() async {
    try {
      final res = await supabaseJsa.from('user_training_view').select();

      usersTrainings = (res as List<dynamic>)
          .map((training) => UserTraining.fromJson(jsonEncode(training)))
          .toList();

      // print("usersTrainings length es: ${usersTrainings.length}");
      // for (var user in usersTrainings) {
      //   print("user: ${user.name}");
      // }
      notifyListeners();
    } catch (e) {
      print("Error in getUsersTraining: $e");
    }
  }

  // Nos trae la información de los trainings por usuarios
  Future<void> getInformationTraining(String userfk) async {
    try {
      rows.clear();

      userTrainingSelected = usersTrainings
          .firstWhere((element) => element.userProfileId == userfk);

      userTrainingSelected?.trainings
          .sort((a, b) => b.idTraining.compareTo(a.idTraining));

      for (var training in userTrainingSelected!.trainings) {
        rows.add(
          PlutoRow(
            cells: {
              'ID_Column': PlutoCell(value: training.idTraining),
              'NAME_Column': PlutoCell(value: training.title),
              'Creation_Column': PlutoCell(value: training.creationDate),
              'Expiration_Column': PlutoCell(value: training.expirationDate),
              'STATUS_Column': PlutoCell(value: training.status.name),
              'DOCUMENT_Column': PlutoCell(value: training.docname),
            },
          ),
        );
      }
    } catch (e) {
      print('Error en getInformationTraining() - $e');
    }
  }

  // Selecciona Documento de la base de datos
  Future<void> pickDocument(String document) async {
    try {
      var url = supabase.storage.from('jsa/training').getPublicUrl(document);
      print(url);
      // .getPublicUrl("${jsa.id}_${jsa.createdAt}_14.pdf");
      if (document.contains("http")) {
        documento = null;
      } else {
        var bodyBytes = (await http.get(Uri.parse(url))).bodyBytes;
        documento = bodyBytes;

        pdfController =
            PdfController(document: PdfDocument.openData(bodyBytes));
      }
    } catch (e) {
      log('Error in pickDocument() - $e');
      return;
    }
    return;
  }

  // Descarga la imagen del training
  Future<void> downloadAndSaveImage(String url) async {
    final http.Response r = await http.get(
      Uri.parse(url),
    );

    final data = r.bodyBytes;
    final base64data = base64Encode(data);
    final a = html.AnchorElement(href: 'data:image/jpeg;base64,$base64data');
    List<String> parts = url.split('/');
    String fileName = parts.last;
    a.download = fileName;
    a.click();
    a.remove();
  }

  //Descargar PDF
  String pdfUrl = '';
  void descargarArchivo(Uint8List datos, String nombreArchivo) {
    final blob = html.Blob([datos]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..target = 'web'
      ..download = nombreArchivo;
    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
