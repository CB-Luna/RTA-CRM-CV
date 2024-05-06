// ignore_for_file: unnecessary_null_comparison, implementation_imports, depend_on_referenced_packages, unnecessary_import

import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/pdf.dart' as pwp;
import 'package:pdfx/pdfx.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabaseFlutter;
import 'package:storage_client/src/types.dart';
import 'package:rta_crm_cv/models/jsa/team_members.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import '../../helpers/globals.dart';
import '../../models/jsa/jsa_general_information.dart';
import '../../models/jsa/safety_briefing.dart';
import '../../models/user.dart';

class JsaSafetyProvider extends ChangeNotifier {
  // ------------ Lista de variables para los controladores ---------------
  final titleController = TextEditingController();
  final userController = TextEditingController();
  final dateController = TextEditingController();
  final datedueController = TextEditingController();
  final issueController = TextEditingController();
  final backgroundController = TextEditingController();
  final contactController = TextEditingController();
  final recomendationsController = TextEditingController();
  final urlController = TextEditingController();
  final searchController = TextEditingController();
  final companyController = TextEditingController();

  // ------------ Lista de variables ---------------
  List<SafetyBriefing> listSafety = [];
  List<User> users = [];
  List<PlutoRow> rows = [];
  List<TeamMembersSafetyModel> teamMembers = [];
  List<User> membersSelection = [];
  List<String> emails = [];

  // ------------ Variables individuales ---------------
  User? user;
  SafetyBriefing? safetyBriefingSelected;
  // PDF DATA
  PdfController? finalPdfController;
  late Uint8List documento;
  final date = DateTime.now();
  JsaGeneralInfo get jsa => jsaGeneralInfo!;
  JsaGeneralInfo? jsaGeneralInfo;
  PlutoGridStateManager? stateManager;
  int pageRowCount = 10;
  int page = 1;
  bool loadingGrid = false;
  PdfController? pdfController;

  // ------------ Variables de los Image ---------------
  String? imageName;
  String? imageUrl;
  String? imageUrlUpdate;
  Uint8List? webImage;
  Uint8List? webImageClear;
  String? placeHolderImage;
  Uuid uuid = const Uuid();

  int infowidgets = 0;
  int numberSafetyBrief = 0;

  final borderStyle = const pw.BorderSide(width: 1);
  final columnWidths = {
    0: const pw.FlexColumnWidth(1), // Ancho flexible para la primera columna
    1: const pw.FlexColumnWidth(1), // Ancho flexible para la segunda columna
    2: const pw.FlexColumnWidth(1), // Ancho flexible para la tercera columna
  };

  Future<void> updateState() async {
    loadingGrid = false;
    await getSafetyList();
  }

  // get a list of the safety documents
  Future<void> getSafetyList() async {
    try {
      final res = await supabaseJsa.from('safety_brief_view').select();
      // .eq('company_fk', currentUser!.company_fk);
      if (res == null) {
        print('Error en getSafetyList()');
        return;
      }
      // print(res);
      listSafety = (res as List<dynamic>)
          .map((jSA) => SafetyBriefing.fromJson(jsonEncode(jSA)))
          .toList();

      print("En getInformationJSA con el JSA_FK: con res: $res");
      // rows.clear();
    } catch (e) {
      print('Error en getSafetyList() - $e');
    }
    notifyListeners();
  }

  Future<void> filterDocuments(String query) async {
    if (searchController.text.isEmpty) {
      if (currentUser!.isManagerJSA) {
        final res = await supabaseJsa.from('safety_brief_view').select();
        // .eq('company_fk', currentUser!.company_fk);
        if (res == null) {
          print('Error en filterDocuments()');
          return;
        }
        // print(res);
        listSafety = (res as List<dynamic>)
            .map((safety) => SafetyBriefing.fromJson(jsonEncode(safety)))
            .toList();
      } else {
        final res = await supabaseJsa.from('safety_brief_view').select();
        if (res == null) {
          print('Error en filterDocuments()');
          return;
        }
        // print(res);
        listSafety = (res as List<dynamic>)
            .map((safety) => SafetyBriefing.fromJson(jsonEncode(safety)))
            .toList();
      }
    } else {
      print("SearchController: ${searchController.text}");
      listSafety = listSafety
          .where((elemento) =>
              elemento.title != null &&
                  elemento.title
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase()) ||
              elemento.id != null &&
                  elemento.id.toString().contains(searchController.text) ||
              elemento.preparedBy != null &&
                  elemento.preparedBy
                      .toString()
                      .contains(searchController.text))
          .toList();
    }

    // for (var list in listJSA) {
    //   print("Name list: ${list.title}");
    // }

    print("La lista listJSAFiltered: ${listSafety.length}");
    notifyListeners();
  }

  // Get informacion de los safety
  void getInformationSafety(int index) {
    try {
      numberSafetyBrief = listSafety[index].id;
      // signedUsers = 0;
      rows.clear();
      safetyBriefingSelected =
          listSafety.firstWhere((element) => element.id == numberSafetyBrief);
      if (safetyBriefingSelected != null) {
        for (Usersjsa user in safetyBriefingSelected!.usersjsa) {
          // if (user.role!.application == "JSA") {
          // for (Usersjsa user in filteredUsers) {
          // print("UsersName: ${user.name}");
          rows.add(
            PlutoRow(
              cells: {
                'ID_Column': PlutoCell(value: user.id),
                'NAME_Column':
                    PlutoCell(value: "${user.name} ${user.lastName}"),
                'ROLE_Column': PlutoCell(value: user.role.name),
                'STATUS_Column': PlutoCell(value: user.status.status),
                // 'DOCUMENT_Column': PlutoCell(value: user.docName),
              },
            ),
          );
          // if (user.status!.status == "Signed") {
          //   signedUsers++;
          // }
        }
      }
    } catch (e) {
      print('Error en getInformationSafety() - $e');
    }
    // notifyListeners();
  }

  // Seleccionar Documento
  Future<void> pickDocument(String document) async {
    try {
      var url =
          supabase.storage.from('jsa/safety_briefing').getPublicUrl(document);
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

  // Traer Usuarios
  Future<void> getListUsers(String company) async {
    try {
      final res = await supabase
          .from('users')
          .select()
          .eq('company->>company', company);

      // .eq('company->>company', currentUser!.companies.first.company);
      if (res == null) {
        print('Error en getListUsers()');
        return;
      }
      users = (res as List<dynamic>)
          .map((usuario) => User.fromMap(usuario))
          .toList();
      users = users
          .where((user) => user.roles.any((role) =>
              role.application == currentUser!.currentRole.application))
          .toList();
      // Se supone que esto filtra por el id 26 que es el technician jsa
      users = users
          .where((user) =>
              user.roles.any((role) => role.id == 26 || role.id == 24))
          .toList();

      log("Estoy en getListUsers");
      log("El length de users es: ${users.length}");
      log("La compania es :${currentUser!.companies.first.company}");

      // print("En getInformationJSA con el JSA_FK: con res: $res");
    } catch (e) {
      print('Error en getListUsers() - $e');
    }
    notifyListeners();
  }

  void createJsaGeneralInfo(String? company, String? title, String? taskName,
      List<TeamMembers> list) {
    print("JsaCreation");
    List<JsaStepsJson> jsaStepsJson = [];

    jsaGeneralInfo = JsaGeneralInfo(
        company: company,
        title: title,
        taskName: taskName,
        jsaStepsJson: jsaStepsJson,
        teamMembers: list);
    print(jsaGeneralInfo!.toJson());
    print("JsaCreation End");
    notifyListeners();
  }

  void addTeamMembers(TeamMembersSafetyModel teamMember) {
    try {
      teamMembers.add(teamMember);
      print(
          "El length del teamMembers es: ${teamMembers.length} en addTeamMembers");
      notifyListeners();
    } catch (e) {
      print("Error in addTeamMembers() - $e");
    }
  }

  void deleteTeamMembers(String id) {
    try {
      teamMembers.removeWhere((element) => element.id == id);
      print(
          "El length del teamMembers es: ${teamMembers.length} en deleteTeamMembers");
      notifyListeners();
    } catch (e) {
      print("Error in deleteTeamMembers() - $e");
    }
  }

  // MainUpload
  Future<supabaseFlutter.PostgrestList> mainUpload() async {
    Map<String, dynamic> mainData = {
      'title': titleController.text,
      'prepared_by': userController.text,
      'date': dateController.text,
      'issue': issueController.text,
      'background': backgroundController.text,
      'contact': contactController.text,
      'recommendation': recomendationsController.text,
      'id_status': 1,
      //traer foraneas
    };
    final response = await supabaseJsa
        .from('safety_briefing')
        .insert(mainData)
        .select<supabaseFlutter.PostgrestList>('id');

    if (response == null) {
      print('Error inserting MAIN data: ${response.toString()}');
    } else {
      print('MAIN Data inserted successfully!');
    }
    return response;
  }

  // Subir Documento
  Future<bool> uploadDocument(int seqId, int idJsa) async {
    // ejecBloq = true;
    // notifyListeners();

    try {
      if (documento == null) {
        return false;
      }
//se sube el documento
      await supabase.storage
          .from('jsa/safety_briefing')
          .uploadBinary('${titleController.text}_$seqId.pdf', documento!);

      await supabaseJsa.from('safety_briefing').update(
          {'doc_name': '${titleController.text}_$seqId.pdf'}).eq("id", idJsa);

      print("subida correcta a Supabase");
    } catch (e) {
      log('Error en uploadDocument() - $e');
      // ejecBloq = false;
      // notifyListeners();
      return false;
    }

    return true;
  }

  // TeamUpload
  Future<dynamic> teamUpload(int i, supabaseFlutter.PostgrestList response,
      teamResponse, int idSafety) async {
    try {
      Map<String, dynamic> jsaUserData = {
        'user_fk': teamMembers[i].id,
        'safety_briefing_fk': response[0]['id'],
        'id_status': 2,
        //traer foranea de risks y control
      };

      teamResponse = await supabaseJsa
          .from('safety_briefing_user_status')
          .insert(jsaUserData)
          .select<supabaseFlutter.PostgrestList>('id');

      // emails.add(teamMembers[i].email!);

      emails.add("juan.aispuro72@gmail.com");

      print("El length del correo es: ${emails.length}");

      String token;
      token = generateToken("juan.aispuro72@gmail.com", idSafety);
      final link = '${Uri.base.origin}SafetyBriefing?token=$token';

      await sendEmail(
        name: teamMembers[i].name!,
        link: link,
        email: emails,
      );
      emails.clear();
      // return true;
      return teamResponse;
    } catch (e) {
      print("Error in teamUpload() -$e");
    }
  }

  // Función de mandar correo
  Future<bool> sendEmail({
    required String name,
    required String link,
    required List<String> email,
  }) async {
    try {
      for (var email in emails) {
        String body = jsonEncode(
          {
            "action": "rtaMail",
            "template": "TemporaryLink",
            "subject": "Safety Briefing",
            "mailto": email,
            "variables": [
              {"name": "name", "value": name},
              {"name": "link", "value": link},
            ]
          },
        );
        final response = await http.post(Uri.parse(urlNotifications),
            headers: {'Content-Type': 'application/json'}, body: body);
        if (response.statusCode > 204) return false;
      }

      return true;
    } catch (e) {
      log('Error in sendEmail() - $e');
      return false;
    }
  }

  // Generate Token
  String generateToken(String email, int documentId) {
    //Generar token
    final jwt = JWT(
      {
        'email': email,
        'document_id': documentId,
        'creation_date': DateTime.now().toUtc().toIso8601String(),
      },
      issuer: 'https://github.com/jonasroussel/dart_jsonwebtoken',
    );

    // Sign it (default with HS256 algorithm)
    return jwt.sign(SecretKey('secret'));
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

  // Future<void> uploadImage() async {
  //   try {
  //     final storageResponse =
  //         await supabase.storage.from('assets/Vehicles').uploadBinary(
  //               placeHolderImage!,
  //               webImage!,
  //               fileOptions: const FileOptions(
  //                 cacheControl: '3600',
  //                 upsert: false,
  //               ),
  //             );

  //     if (storageResponse.isNotEmpty) {
  //       imageUrl = supabase.storage.from('assets/Vehicles').getPublicUrl(
  //             placeHolderImage!,
  //           );
  //     }

  //     // return imageName;
  //   } catch (e) {
  //     log('Error in uploadImage() - $e');
  //     // return null;
  //   }
  // }

  // Crear PDF
  Future<PdfController?> clientPDF() async {
    log("Documento Creado");

    finalPdfController = null;
    notifyListeners();
    final logo =
        (await rootBundle.load('assets/images/2.png')).buffer.asUint8List();
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          children: [
            // pw.Text(titleController.text),
            // pw.Text(userController.text),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topLeft,
                    width: 250,
                    height: 80,
                    child: pw.Image(pw.MemoryImage(logo), fit: pw.BoxFit.fill),
                  ),
                ]),
            pw.Container(
                height: 100,
                width: 700,
                padding: const pw.EdgeInsets.symmetric(vertical: 10.0),
                // decoration: pw.BoxDecoration(
                //     color: pwp.PdfColors.grey300, border: pw.Border.all()),
                child: pw.Table(
                    border: pw.TableBorder(
                      left: borderStyle,
                      right: borderStyle,
                      top: borderStyle,
                      bottom: borderStyle,
                      verticalInside: borderStyle,
                      horizontalInside: borderStyle,
                    ),
                    columnWidths: columnWidths,
                    children: [
                      pw.TableRow(
                          decoration: const pw.BoxDecoration(
                            color: pwp.PdfColors.grey300,
                          ),
                          verticalAlignment: pw.TableCellVerticalAlignment.top,
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(left: 10),
                              child: pw.Text('Briefing Note',
                                  textAlign: pw.TextAlign
                                      .start, // Aqui lo cambio a star para que inicie
                                  style: const pw.TextStyle(
                                    fontSize: 15,
                                  )),
                            ),
                            pw.Text(titleController.text,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(
                                  fontSize: 15,
                                )),
                          ]),
                      pw.TableRow(
                          decoration: const pw.BoxDecoration(
                            color: pwp.PdfColors.grey300,
                          ),
                          verticalAlignment:
                              pw.TableCellVerticalAlignment.middle,
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(left: 10),
                              child: pw.Text('Prepared By: ',
                                  textAlign: pw.TextAlign.start,
                                  style: const pw.TextStyle(
                                    fontSize: 15,
                                  )),
                            ),
                            pw.Text(userController.text,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(
                                  fontSize: 15,
                                )),
                          ]),
                      pw.TableRow(
                          decoration: const pw.BoxDecoration(
                            color: pwp.PdfColors.grey300,
                          ),
                          verticalAlignment:
                              pw.TableCellVerticalAlignment.middle,
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(left: 10),
                              child: pw.Text('Prepared For: ',
                                  textAlign: pw.TextAlign.start,
                                  style: const pw.TextStyle(
                                    fontSize: 15,
                                  )),
                            ),
                            pw.Column(
                              children:
                                  List.generate(teamMembers.length, (index) {
                                return pw.Container(
                                  padding: const pw.EdgeInsets.symmetric(
                                      vertical:
                                          5.0), // Ajusta el espaciado vertical entre los nombres
                                  child: pw.Text(
                                    "${teamMembers[index].name!}",
                                    style: pw.TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: pw.FontWeight.normal,
                                    ),
                                  ),
                                );
                              }),
                            ),
                            // pw.Row(
                            //   children:
                            //       List.generate(teamMembers.length, (index) {
                            //     return pw.Row(
                            //       children: [
                            //         pw.SizedBox(width: 10),
                            //         pw.Text(
                            //           "${teamMembers[index].name!} \n",
                            //           style: pw.TextStyle(
                            //             fontSize: 16.0,
                            //             fontWeight: pw.FontWeight.normal,
                            //           ),
                            //         ),
                            //       ],
                            //     );
                            //   }),
                            // ),
                          ]),
                      pw.TableRow(
                          decoration: const pw.BoxDecoration(
                            color: pwp.PdfColors.grey300,
                          ),
                          verticalAlignment:
                              pw.TableCellVerticalAlignment.middle,
                          children: [
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(left: 10),
                              child: pw.Text('Date: ',
                                  textAlign: pw.TextAlign.start,
                                  style: const pw.TextStyle(
                                    fontSize: 15,
                                  )),
                            ),
                            pw.Text(dateController.text,
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(
                                  fontSize: 15,
                                )),
                          ]),
                    ])),

            pw.SizedBox(height: 10),

            pw.SizedBox(height: 15),
            pw.Container(
                color: pwp.PdfColors.grey300,
                child: pw.Table(children: [
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 10),
                      child: pw.Text("Issue ",
                          style: const pw.TextStyle(
                            fontSize: 15,
                          )),
                    ),
                    pw.Container(
                      child: pw.Column(children: []),
                    ),
                  ]),
                ])),
            pw.SizedBox(height: 15),
            pw.Column(children: [
              pw.Row(children: [
                pw.Text(
                  issueController.text,
                  style: const pw.TextStyle(
                    fontSize: 10,
                    // color: pdfcolor.PdfColor.fromInt(0xFF060606),
                  ),
                ),
              ]),
              pw.SizedBox(height: 5),
            ]),
            pw.SizedBox(height: 15),

            pw.Container(
                color: pwp.PdfColors.grey300,
                child: pw.Table(children: [
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 10),
                      child: pw.Text("Background",
                          style: const pw.TextStyle(
                            fontSize: 15,
                          )),
                    ),
                    pw.Container(
                      child: pw.Column(children: []),
                    ),
                  ]),
                ])),
            pw.SizedBox(height: 15),
            pw.Column(children: [
              pw.Row(children: [
                pw.Text(
                  backgroundController.text,
                  style: const pw.TextStyle(
                    fontSize: 10,
                  ),
                ),
              ]),
              pw.SizedBox(height: 5),
            ]),
            pw.SizedBox(height: 15),

            pw.Container(
                color: pwp.PdfColors.grey300,
                child: pw.Table(children: [
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 10),
                      child: pw.Text("Recommendadations/ Conclusion",
                          style: const pw.TextStyle(
                            fontSize: 15,
                          )),
                    ),
                    pw.Container(
                      child: pw.Column(children: []),
                    ),
                  ]),
                ])),
            pw.SizedBox(height: 15),
            pw.Column(children: [
              pw.Row(children: [
                pw.Text(
                  recomendationsController.text,
                  style: const pw.TextStyle(
                    fontSize: 10,
                    // color: pdfcolor.PdfColor.fromInt(0xFF060606),
                  ),
                ),
              ]),
              pw.SizedBox(height: 5),
            ]),
            pw.SizedBox(height: 15),

            pw.Container(
                color: pwp.PdfColors.grey300,
                child: pw.Table(children: [
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 10),
                      child: pw.Text("Contact",
                          style: const pw.TextStyle(
                            fontSize: 15,
                          )),
                    ),
                    pw.Container(
                      child: pw.Column(children: []),
                    ),
                  ]),
                ])),

            pw.SizedBox(height: 15),
            pw.Column(children: [
              pw.Row(children: [
                pw.Text(
                  contactController.text,
                  style: const pw.TextStyle(
                    fontSize: 10,
                    // color: pdfcolor.PdfColor.fromInt(0xFF060606),
                  ),
                ),
              ]),
              pw.SizedBox(height: 5),
            ]),
            pw.SizedBox(height: 10),
            pw.Container(
                color: pwp.PdfColors.grey300,
                child: pw.Table(children: [
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 10),
                      child: pw.Text("Addiontal Info:",
                          style: const pw.TextStyle(
                            fontSize: 15,
                          )),
                    ),
                  ]),
                ])),
            pw.Container(
                child: pw.Table(children: [
              pw.TableRow(children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.only(left: 10),
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Text("URL: ${urlController.text}"),
                        pw.Text("Image:"),
                        webImage == null
                            ? pw.Container(
                                alignment: pw.Alignment.topLeft,
                                width: 250,
                                height: 80,
                              )
                            : pw.Container(
                                alignment: pw.Alignment.topLeft,
                                width: 250,
                                height: 80,
                                child: pw.Image(pw.MemoryImage(webImage!),
                                    fit: pw.BoxFit.fill),
                              ),
                      ]),
                ),
              ]),
            ])),

            pw.SizedBox(height: 10),

            pw.SizedBox(height: 20),
            pw.Expanded(
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Column(children: [
                      pw.Text(
                        'Accepted and Agreed to by RTA:',
                        style: const pw.TextStyle(
                          fontSize: 13,
                          // color: pdfcolor.PdfColor.fromInt(0xFF060606),
                        ),
                      ),
                      pw.Text(
                        '${currentUser!.name} ${currentUser!.lastName}, Employee',
                        style: const pw.TextStyle(
                          fontSize: 13,
                          // color: pdfcolor.PdfColor.fromInt(0xFF060606),
                        ),
                      ),
                    ]),
                  ]),
            )
          ],
        ),
      ),
    );
    pdf.save();
    finalPdfController = PdfController(
      document: PdfDocument.openData(pdf.save()),
    );
    documento = await pdf.save();
    notifyListeners();
    return finalPdfController;
  }

  clearAll() async {
    finalPdfController = null;
    titleController.clear();
    userController.clear();
    teamMembers.clear();
    dateController.clear();
    issueController.clear();
    backgroundController.clear();
    contactController.clear();
    recomendationsController.clear();
  }
}
