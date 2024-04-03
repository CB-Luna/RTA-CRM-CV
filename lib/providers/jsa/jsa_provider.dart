import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/doc_create_final_document.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/doc_create_task_risk_control.dart';
import 'package:uuid/uuid.dart';
import 'package:pdfx/pdfx.dart';

import '../../models/user.dart';
import '../../pages/jsa/doc_creation/doc_create_resume.dart';
import '../../pages/jsa/doc_creation/doc_creation_card.dart';
import '../../models/jsa/jsa_general_information.dart';
import 'dart:html' as html;

var uuid = const Uuid();

class JsaProvider extends ChangeNotifier {
  JsaGeneralInfo? jsaGeneralInfo;
  List<User> users = [];
  String? companySelected;
  JsaGeneralInfo get jsa => jsaGeneralInfo!;
  final searchController = TextEditingController();

  // Valores JSA
  bool selectedList = true;
  bool circleList = true;
  bool selectedTask = false;
  bool circleListTask = false;
  bool selectedResume = false;
  bool circleResume = false;
  bool selectedFinal = false;
  bool circleFinal = false;
  int stepperTaped = 0;
  // int buttonViewTaped = 0;
  int buttonViewTaped = 0;
  final viewTaped = {
    0: const CustomDocCreationCard(), // Step 1
    1: const CustomDocCreationTaskRiskControl(), // Step 2
    2: const CustomDocResume(), // Step 2
    3: const CustomDocCreationFinalDocument(), // Step 2
    // 2: const Step3PaymentDetailsForm(), // Step 3
  };

  // PDF Data
  PdfController? finalPdfController;
  Uint8List? documento;

  final borderStyle = const pw.BorderSide(width: 1);
  final columnWidths = {
    0: const pw.FlexColumnWidth(1), // Ancho flexible para la primera columna
    1: const pw.FlexColumnWidth(1), // Ancho flexible para la segunda columna
    2: const pw.FlexColumnWidth(1), // Ancho flexible para la tercera columna
  };

  // Funciones
  void setIcons(int index) {
    if (index == 0) {
      selectedList = true;
      circleList = true;
      selectedTask = false;
      circleListTask = false;
      selectedResume = false;
      circleResume = false;
      selectedFinal = false;
      circleFinal = false;
    } else if (index == 1) {
      selectedList = true;
      circleList = true;
      selectedTask = true;
      circleListTask = true;
      selectedResume = false;
      circleResume = false;
      selectedFinal = false;
      circleFinal = false;
    } else if (index == 2) {
      selectedList = true;
      circleList = true;
      selectedTask = true;
      circleListTask = true;
      selectedResume = true;
      circleResume = true;
      selectedFinal = false;
      circleFinal = false;
    } else {
      selectedList = true;
      circleList = true;
      selectedTask = true;
      circleListTask = true;
      selectedResume = true;
      circleResume = true;
      selectedFinal = true;
      circleFinal = true;
    }
  }

  void setButtonViewTaped(int index) {
    buttonViewTaped = index;
    stepperTaped = index;
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

  void editJsaGeneralInfo(String? company, String? title, String? taskName) {
    jsaGeneralInfo!.company = company;
    jsaGeneralInfo!.title = title;
    jsaGeneralInfo!.taskName = taskName;
    print(jsaGeneralInfo!.toJson());
    notifyListeners();
  }

  void addJsaSteps(String title, String description) {
    jsaGeneralInfo!.jsaStepsJson!.add(JsaStepsJson(
        title: title,
        description: description,
        risks: [],
        controls: [],
        id: uuid.v1(),
        controlLevel: '',
        controlColor: Colors.transparent,
        riskColor: Colors.transparent,
        riskLevel: ''));
    print('Step Name: ${title}');
    print('Step Description: ${description}');

    notifyListeners();
  }

  void addJsaRisks(String title, String stepId) {
    jsaGeneralInfo!.jsaStepsJson!.forEach((element) {
      if (element.id == stepId) {
        element.risks.add(Risks(title: title));
      }
    });

    notifyListeners();
  }

  Future<void> getListUsers(String company) async {
    try {
      final res = await supabase
          .from('users')
          .select()
          .eq('company->>company', company);
      if (res == null) {
        print('Error en getDocumentList()');
        return;
      }
      users = (res as List<dynamic>)
          .map((usuario) => User.fromMap(usuario))
          .toList();
      users = users
          .where((user) => user.roles.any((role) =>
              role.application == currentUser!.currentRole.application))
          .toList();

      // print("En getInformationJSA con el JSA_FK: con res: $res");
    } catch (e) {
      print('Error en getListUsers() - $e');
    }
    notifyListeners();
  }

  void setRiskLevel(String riskLevel, String stepId) {
    Color color = Colors.transparent;
    print("El color inicial es: $color");
    print("El riskLevel es: $riskLevel");
    switch (riskLevel) {
      // case '0.0':
      // case '1.0':
      // case '2.0':
      // case '3.0':
      //   color = Colors.green;
      //   break;

      // case '4.0':
      // case '5.0':
      // case '6.0':
      //   color = Colors.yellow;
      //   break;

      // case '7.0':
      // case '8.0':
      // case '9.0':
      //   color = Colors.red.shade200;
      //   break;
      case '0':
      case '1':
      case '2':
      case '3':
        color = Colors.green;
        break;

      case '4':
      case '5':
      case '6':
        color = Colors.yellow;
        break;

      case '7':
      case '8':
      case '9':
        color = Colors.red.shade200;
        break;
    }
    print("El color despues del switch es: $color");
    jsaGeneralInfo!.jsaStepsJson!.forEach((element) {
      if (element.id == stepId) {
        element.riskLevel = riskLevel;
        element.riskColor = color;
      }
    });

    notifyListeners();
  }

  void setControlLevel(String riskLevel, String stepId) {
    Color color = Colors.transparent;
    switch (riskLevel) {
      // case '0.0':
      // case '1.0':
      // case '2.0':
      // case '3.0':
      //   color = Colors.green;
      //   break;

      // case '4.0':
      // case '5.0':
      // case '6.0':
      //   color = Colors.yellow;
      //   break;

      // case '7.0':
      // case '8.0':
      // case '9.0':
      //   color = Colors.red.shade200;
      //   break;
      case '0':
      case '1':
      case '2':
      case '3':
        color = Colors.green;
        break;

      case '4':
      case '5':
      case '6':
        color = Colors.yellow;
        break;

      case '7':
      case '8':
      case '9':
        color = Colors.red.shade200;
        break;
    }
    jsaGeneralInfo!.jsaStepsJson!.forEach((element) {
      if (element.id == stepId) {
        element.controlLevel = riskLevel;
        element.controlColor = color;
      }
    });

    notifyListeners();
  }

  void addJsaControl(String title, String stepId) {
    jsaGeneralInfo!.jsaStepsJson!.forEach((element) {
      if (element.id == stepId) {
        element.controls.add(Control(title: title, controlLevel: ''));
      }
    });

    notifyListeners();
  }

  void editJsaRisk(String riskTitle, String stepId, String newRiskTitle) {
    jsaGeneralInfo!.jsaStepsJson!
        .where((element) => element.id == stepId)
        .forEach((element) {
      element
          .risks[element.risks
              .indexWhere((elementRisk) => elementRisk.title == riskTitle)]
          .title = newRiskTitle;
      // element.risks.forEach((elementRisk) {
      //   if (elementRisk == riskTitle) {
      //     elementRisk = newRiskTitle;
      //   }

      // });
    });

    notifyListeners();
  }

  void editJsaControl(
      String controlTitle, String stepId, String newcontrolTitle) {
    jsaGeneralInfo!.jsaStepsJson!
        .where((element) => element.id == stepId)
        .forEach((element) {
      element
          .controls[element.controls
              .indexWhere((elementRisk) => elementRisk.title == controlTitle)]
          .title = newcontrolTitle;

      // element.risks.forEach((elementRisk) {
      //   if (elementRisk == riskTitle) {
      //     elementRisk = newRiskTitle;
      //   }

      // });
    });

    notifyListeners();
  }

  void notifyEdit() {
    notifyListeners();
  }

  void deleteJsaSteps(String stepId) {
    jsaGeneralInfo!.jsaStepsJson!
        .removeWhere((element) => element.id == stepId);
    notifyListeners();
  }

  void deleteJsaRisk(String risk) {
    jsaGeneralInfo!.jsaStepsJson!.forEach((element) {
      element.risks.removeWhere((elementRisk) => elementRisk.title == risk);
    });

    notifyListeners();
  }

  void deleteJsaControl(String control) {
    jsaGeneralInfo!.jsaStepsJson!.forEach((element) {
      element.controls
          .removeWhere((elementcontrol) => elementcontrol.title == control);
    });

    notifyListeners();
  }

  void addTeamMembers(TeamMembers teamMember) {
    try {
      jsaGeneralInfo!.teamMembers!.add(teamMember);
      print(
          "El length del jsaGeneralInformation es: ${jsaGeneralInfo!.teamMembers!.length}");
      notifyListeners();
    } catch (e) {
      print("Error in addTeamMembers() - $e");
    }
  }

  void deleteTeamMembers(String id) {
    try {
      jsaGeneralInfo!.teamMembers!.removeWhere((element) => element.id == id);
      print(
          "El length del jsaGeneralInformation es: ${jsaGeneralInfo!.teamMembers!.length}");
      notifyListeners();
    } catch (e) {
      print("Error in addTeamMembers() - $e");
    }
  }

  Future<PdfController> clientPDF(JsaProvider jsa) async {
    finalPdfController = null;
    notifyListeners();
    final logo = (await rootBundle.load('assets/images/rta_logo.png'))
        .buffer
        .asUint8List();

    final pdf = pw.Document();
    final date = DateTime.now();

    int step = jsa.jsaGeneralInfo!.jsaStepsJson!.length;
    final generalInfo = jsa.jsaGeneralInfo;
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          children: [
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topLeft,
                    width: 250,
                    height: 80,
                    child: pw.Image(pw.MemoryImage(logo), fit: pw.BoxFit.fill),
                  ),
                  //Titulo
                  pw.Column(children: [
                    pw.Text(
                      textAlign: pw.TextAlign.end,
                      'JSA No._______________________',
                      style: const pw.TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ]),
                ]),

            pw.SizedBox(height: 10),
            pw.Row(children: [
              pw.Text('Company Name: ___${generalInfo!.company}___',
                  textAlign: pw.TextAlign.start),
              pw.Text('Title:__${generalInfo.title}__')
            ]),
            //Contenido
            pw.SizedBox(height: 15),
            pw.Container(
              alignment: pw.Alignment.center,
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
                        verticalAlignment: pw.TableCellVerticalAlignment.middle,
                        children: [
                          pw.Text('Job Steps',
                              textAlign: pw.TextAlign.center,
                              style: const pw.TextStyle(
                                fontSize: 15,
                              )),
                          pw.Text('Hazards',
                              textAlign: pw.TextAlign.center,
                              style: const pw.TextStyle(
                                fontSize: 15,
                              )),
                          pw.Text('Barriers or Controls',
                              textAlign: pw.TextAlign.center,
                              style: const pw.TextStyle(
                                fontSize: 15,
                              ))
                        ]),
                    //Builder de los diferentes Steps
                    //HACER CONSULTA DOBLE EN CUANTO A  LOS STEPS PARA RIESGOS Y CONTROL
                  ]),
            ),
            pw.ListView.builder(
                itemBuilder: (context, index) {
                  return pw.Table(
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
                          children: [
                            pw.Text(
                              generalInfo.jsaStepsJson![index].title,
                              textAlign: pw.TextAlign.center,
                              style: const pw.TextStyle(
                                fontSize: 13,
                              ),
                            ),
                            pw.Container(
                              child: pw.Column(children: [
                                pw.ListView.builder(
                                  itemCount: generalInfo
                                      .jsaStepsJson![index].risks.length,
                                  itemBuilder: (context, indexR) {
                                    print(
                                        "Riesgos: ${generalInfo.jsaStepsJson![index].risks[indexR].title}");
                                    return pw.Text(
                                      textAlign: pw.TextAlign.center,
                                      "${generalInfo.jsaStepsJson![index].risks[indexR].title}",
                                      style: const pw.TextStyle(
                                        fontSize: 11,
                                      ),
                                    );
                                  },
                                ),
                                pw.Text(
                                    '${generalInfo.jsaStepsJson![index].riskLevel}')
                              ]),
                            ),
                            pw.Container(
                              child: pw.Column(children: [
                                pw.ListView.builder(
                                  itemCount: generalInfo
                                      .jsaStepsJson![index].controls.length,
                                  itemBuilder: (context, indexC) {
                                    return pw.Text(
                                      textAlign: pw.TextAlign.center,
                                      "${generalInfo.jsaStepsJson![index].controls[indexC].title}",
                                      style: const pw.TextStyle(
                                        fontSize: 11,
                                      ),
                                    );
                                  },
                                ),
                                pw.Text(
                                    '${generalInfo.jsaStepsJson![index].controlLevel}')
                              ]),
                            ),
                          ],
                        )
                      ]);
                },
                itemCount: step),
            pw.SizedBox(height: 15),
            pw.Container(
                child: pw.Table(
                    border: pw.TableBorder(
                      left: borderStyle,
                      right: borderStyle,
                      top: borderStyle,
                      bottom: borderStyle,
                      verticalInside: borderStyle,
                      horizontalInside: borderStyle,
                    ),
                    children: [
                  pw.TableRow(children: [
                    pw.Center(
                      child: pw.Text("Team Members",
                          style: const pw.TextStyle(
                            fontSize: 15,
                          )),
                    ),
                    pw.Container(
                      child: pw.Column(children: [
                        pw.ListView.builder(
                          itemCount: generalInfo.teamMembers!.length,
                          itemBuilder: (context, indexC) {
                            return pw.Text(
                              textAlign: pw.TextAlign.center,
                              "${generalInfo.teamMembers![indexC].name}",
                              style: const pw.TextStyle(
                                fontSize: 11,
                              ),
                            );
                          },
                        ),
                      ]),
                    ),
                  ]),
                ])),
            pw.SizedBox(height: 15),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Prepared By:_____${currentUser!.name} ${currentUser!.lastName}________',
                    style: const pw.TextStyle(
                      fontSize: 13,
                      // color: pdfcolor.PdfColor.fromInt(0xFF060606),
                    ),
                  ),
                  pw.Text(
                    'Date Approved:____${DateFormat("MMM/dd/yyyy").format(date)}_________',
                    textAlign: pw.TextAlign.end,
                    style: const pw.TextStyle(
                      fontSize: 13,
                      // color: pdfcolor.PdfColor.fromInt(0xFF060606),
                    ),
                  ),
                ]),

            pw.SizedBox(height: 10),
            pw.Text(
              'Instructions:',
              style: const pw.TextStyle(
                fontSize: 15,
                // color: pdfcolor.PdfColor.fromInt(0xFF060606),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Column(children: [
              pw.Row(children: [
                pw.Text(
                  '1. To be prepared by the supervisor most directly involved in the work.',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    // color: pdfcolor.PdfColor.fromInt(0xFF060606),
                  ),
                ),
              ]),
              pw.SizedBox(height: 5),
              pw.Row(children: [
                pw.Text(
                  "2. Must be approved by preparer's management supervisor",
                  style: const pw.TextStyle(
                    fontSize: 10,
                    // color: pdfcolor.PdfColor.fromInt(0xFF060606),
                  ),
                ),
              ]),
              pw.SizedBox(height: 5),
              pw.Row(children: [
                pw.Text(
                  '3. Must be reviewed by all workers involved in the work.',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    // color: pdfcolor.PdfColor.fromInt(0xFF060606),
                  ),
                ),
              ]),
              pw.SizedBox(height: 5),
              pw.Row(children: [
                pw.Text(
                  '4. Emergency plan must be considered',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    // color: pdfcolor.PdfColor.fromInt(0xFF060606),
                  ),
                ),
              ]),
              pw.SizedBox(height: 5),
              pw.Row(children: [
                pw.Text(
                  '5. If the work plan changes and the JSA is amended, changes must be reviewed \nby all workers involved in the work',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    // color: pdfcolor.PdfColor.fromInt(0xFF060606),
                  ),
                ),
              ]),
            ]),
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
                      // pw.Image(
                      //   pw.MemoryImage(signature!),
                      //   height: 58,
                      //   width: 200,
                      //   fit: pw.BoxFit.fill,
                      //   alignment: pw.Alignment.center,
                      // ),
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

    return finalPdfController!;
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
