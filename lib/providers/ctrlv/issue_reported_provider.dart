import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../helpers/globals.dart';
import '../../models/issues.dart';
import '../../models/issues_comments.dart';
import '../../models/issues_open_close.dart';
import '../../models/issues_x_user.dart';
import '../../models/vehicle.dart';

class IssueReportedProvider extends ChangeNotifier {
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];
  int pageRowCount = 9;
  int page = 1;

  //---------------- Variables Para ingresar los Issues --------------------------
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

  // Listas R
  List<IssuesComments> bucketInspectionR = [];
  List<IssuesComments> carBodyWorkR = [];
  List<IssuesComments> equipmentR = [];
  List<IssuesComments> extraR = [];
  List<IssuesComments> fluidCheckR = [];
  List<IssuesComments> lightsR = [];
  List<IssuesComments> measureR = [];
  List<IssuesComments> securityR = [];

  // Listas D
  List<IssuesComments> bucketInspectionD = [];
  List<IssuesComments> carBodyWorkD = [];
  List<IssuesComments> equipmentD = [];
  List<IssuesComments> extraD = [];
  List<IssuesComments> fluidCheckD = [];
  List<IssuesComments> lightsD = [];
  List<IssuesComments> measureD = [];
  List<IssuesComments> securityD = [];

  // ------------------ Voleanos para las banderas ---------------------- //
  //variables para banderas
  bool bucketInspectR = true;
  late bool carBodyInspectR;
  late bool equipmentInspectR;
  late bool extraInspectR;
  late bool fluidCheckInspectR;
  late bool ligthsInspectR;
  late bool measureInspectR;
  late bool securityInspectR;
  //---------------- Variables Para ingresar los Issues CLOSED --------------------------\

  List<BucketInspection> issuePart1Closed = [];
  List<BucketInspection> issuePartDClosed = [];
  List<CarBodywork> issueCarBodywRClosed = [];
  List<CarBodywork> issueCarBodyWDClosed = [];
  List<Equiment> issueEquipmentRClosed = [];
  List<Equiment> issueEquipmentDClosed = [];
  List<Extra> issueExtraRClosed = [];
  List<Extra> issueExtradDClosed = [];
  List<FluidCheck> issueFluidCheckRClosed = [];
  List<FluidCheck> issueFluidCheckDClosed = [];
  List<Lights> issueLightsRClosed = [];
  List<Lights> issueLightsDClosed = [];
  List<Security> issueSecurityRClosed = [];
  List<Security> issueSecurityDClosed = [];
  List<Measure> issueMeasureRClosed = [];
  List<Measure> issueMeasureDClosed = [];

  // --------------------- Variables Globales -----------------------------------
  IssuesComments? registroIssueComments;
  bool cambiovistaMeasures = true;
  IssuesXUser? actualIssueXUser;
  List<IssuesXUser> issuesxUser = [];
  Uint8List? webImage;
  TextEditingController dateTimeClosedIssueController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  Vehicle? actualVehicle;
  List<Issues> issues = [];

  IssuesComments? actualissuesComments;

  // ---------------------- Listas R -------------------------
  //List<IssuesComments> bucketInspectionR = [];
  List<IssueOpenclose> bucketInspectionRR = [];
  List<IssueOpenclose> listTotalClosedIssue = [];

  List<IssueOpenclose> carBodyWorkRR = [];
  List<IssueOpenclose> equipmentRR = [];
  List<IssueOpenclose> extraRR = [];
  List<IssueOpenclose> fluidCheckRR = [];
  List<IssueOpenclose> lightsRR = [];
  List<IssueOpenclose> measureRR = [];
  List<IssueOpenclose> securityRR = [];

  // ---------------------- Listas D -------------------------

  //List<IssuesComments> bucketInspectionD = [];
  List<IssueOpenclose> bucketInspectionDD = [];
  List<IssueOpenclose> carBodyWorkDD = [];
  List<IssueOpenclose> equipmentDD = [];
  List<IssueOpenclose> extraDD = [];
  List<IssueOpenclose> fluidCheckDD = [];
  List<IssueOpenclose> lightsDD = [];
  List<IssueOpenclose> measureDD = [];
  List<IssueOpenclose> securityDD = [];

  List<bool> indexSelected = [
    true, //General Information
    false, //Issues
    false, //Service
  ];
  Future<void> updateState() async {
    rows.clear();
    getIssuesAll(actualVehicle!);
    await selectIssuesXUser(0);
  }

  bool validateElementAtList(List<IssueOpenclose> list, int id) {
    return list.any((element) {
      if (element.idIssue == id) {
        return true;
      } else {
        return false;
      }
    });
  }

  bool validateElementAtListIC(List<IssuesComments> list, int id) {
    return list.any((element) {
      if (element.idIssue == id) {
        return true;
      } else {
        return false;
      }
    });
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

  // Contador para mostrar toda en que sección de los issues estamos
  int contadorSeccion = 0;
  void setContador(int contador, {bool notify = true}) {
    contadorSeccion = contador;
    if (notify) notifyListeners();
  }

  // Función que hace lo de movernos entre las ventanas
  int issuesView = 0;
  void setIssueViewActual(int value, {notify = true}) {
    issuesView = value;
    if (notify) notifyListeners();
  }

  // Limpiar los registrosIssueComments cuando sales del ojito
  void clearRegistroIssueComments({notify = true}) {
    print("ClearRegitroIssueComments");
    registroIssueComments = null;
    if (notify) notifyListeners();
  }

  // Seleccionar el Issue Comments
  void selectIssuesComments(IssuesComments issueComments) {
    actualissuesComments = issueComments;
    notifyListeners();
  }

  // Seleccionar el vehiculo actual para la información
  void selectVehicle(Vehicle vehicle, {notify = true}) {
    actualVehicle = vehicle;
    if (notify) notifyListeners();
  }

  // Seleccionamos el IssueXUser que vamos a usar
  Future<void> selectIssuesXUser(int index) async {
    actualIssueXUser = issuesxUser[index];
  }

  // Función para traer de Supabase los IssuesXUsers
  Future<void> getIssuesxUsers(Vehicle vehicle, {bool notify = true}) async {
    try {
      issuesxUser.clear();
      final List<dynamic> resList;
      final IssuesXUser issueXUserAll = IssuesXUser(
          idVehicleFk: vehicle.idVehicle,
          company: vehicle.company.company,
          name: "All",
          lastName: "",
          issuesR: 0,
          issuesD: 0,
          userProfileId: "0",
          sequentialId: 0);

      issuesxUser.add(issueXUserAll);
      final res = await supabaseCtrlV
          .from('issues_x_users')
          .select()
          .match({'id_vehicle_fk': vehicle.idVehicle});

      resList = res as List<dynamic>;
      for (var element in resList) {
        issuesxUser.add(IssuesXUser.fromJson(jsonEncode(element)));
      }
      print(issuesxUser.length);
    } catch (e) {
      print("Error en getIssuesxUsers - $e");
    }
    if (notify) notifyListeners();
  }

  // Función para traer las funciones de los nombres de los IssueComments
  void getIssueCommentsName(int contador, IssuesXUser? actualIssueXUser) {
    try {
      //   clearListgetIssues();
      if (contador == 1) {
        cambiovistaMeasures = true;

        getIssuesFluidCheck(actualIssueXUser!);

        print("getIssuesFluidCheck");
      }
      if (contador == 2) {
        cambiovistaMeasures = true;

        getIssuesCarBodywork(actualIssueXUser!);
        print("getCarbodywork");
      }
      if (contador == 3) {
        cambiovistaMeasures = true;

        getIssuesEquipment(actualIssueXUser!);
        print("getequipment");
      }
      if (contador == 4) {
        cambiovistaMeasures = true;

        getIssuesExtra(actualIssueXUser!);
        print("getextra");
      }
      if (contador == 5) {
        cambiovistaMeasures = true;

        getIssuesBasics(actualIssueXUser!);
        print("getBucketInspection");
      }
      if (contador == 6) {
        cambiovistaMeasures = true;

        getIssuesLights(actualIssueXUser!);
        print("getIssuesLights");
      }
      if (contador == 7) {
        cambiovistaMeasures = false;
        getIssuesMeasure(actualIssueXUser!);
        print("getIssuesMeasure");
      }
      if (contador == 8) {
        cambiovistaMeasures = true;

        getIssueSecurity(actualIssueXUser!);
        print("getIssueSecurity");
      }
    } catch (e) {
      print("Error in getIssueCommentsName() $e");
    }
  }

  // Función para traer las funciones de los comentarios y las fotos de los IssueComments
  void getIssuePhotosComments(int contador, IssueOpenclose issuesComments,
      {bool notify = true}) {
    try {
      if (contador == 1) {
        cambiovistaMeasures = true;
        getIssuesFluidsCheckComments(issuesComments);
        print("getIssuesFluidCheckComments");
      }
      if (contador == 2) {
        cambiovistaMeasures = true;
        getIssuesLightsComments(issuesComments);
        print("getIssuesLightsComments");
      }
      if (contador == 3) {
        cambiovistaMeasures = true;
        getIssueCarBodyWorkComments(issuesComments);
        print("getCarbodyworkComments");
      }
      if (contador == 4) {
        cambiovistaMeasures = true;
        getIssuesSecurityComments(issuesComments);
        print("getIssuesSecurityComments");
      }
      if (contador == 5) {
        cambiovistaMeasures = true;
        getIssuesExtraComments(issuesComments);
        print("getextraComments");
      }
      if (contador == 6) {
        cambiovistaMeasures = true;
        getIssuesEquipmentComments(issuesComments);
        print("getequipmentComments");
      }
      if (contador == 7) {
        cambiovistaMeasures = false;
        getIssuesBucketInspectionComments(issuesComments);
        print("getBucketInspectionComments");
      }
      if (contador == 8) {
        cambiovistaMeasures = true;
        getIssuesMeasuresComments(issuesComments);
        print("getIssuesMeasureComments");
      }
    } catch (e) {
      print("error in get IssuseComments() $e");
    }
  }

  void clearListasdegetIssues() {
    fluidCheckR.clear();
    fluidCheckD.clear();
    lightsR.clear();
    lightsD.clear();
    carBodyWorkR.clear();
    carBodyWorkD.clear();
    securityR.clear();
    securityR.clear();
    extraR.clear();
    extraD.clear();
    equipmentR.clear();
    equipmentD.clear();
    bucketInspectionR.clear();
    bucketInspectionD.clear();
    measureR.clear();
    measureD.clear();
    print("Entro a clearListasdegetIssues");
    notifyListeners();
  }

  Future<void> getIssues(IssuesXUser actualIssueXUser) async {
    bucketInspectR = true;
    carBodyInspectR = true;
    equipmentInspectR = true;
    extraInspectR = true;
    fluidCheckInspectR = true;
    ligthsInspectR = true;
    measureInspectR = true;
    securityInspectR = true;

    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      // SUPBASECTRlV es el control vehicular
      await getIssuesFluidCheck(actualIssueXUser!);
      await getIssuesLights(actualIssueXUser!);
      await getIssuesCarBodywork(actualIssueXUser!);
      await getIssueSecurity(actualIssueXUser!);
      await getIssuesExtra(actualIssueXUser!);
      await getIssuesEquipment(actualIssueXUser!);

      getIssuesBasics(actualIssueXUser!);
      // await issueReportedProvider.getIssuesMeasure(
      //     issueReportedProvider.actualIssueXUser!);

      rows.add(
        PlutoRow(
          cells: {
            "idIssues": PlutoCell(value: ""),
            "Status": PlutoCell(value: "Check Out "),
            "FluidsCheck": PlutoCell(value: fluidCheckRR),
            "Lights": PlutoCell(value: lightsRR),
            "CarBodyWork": PlutoCell(value: carBodyWorkRR),
            "Security": PlutoCell(value: securityRR),
            "Extra": PlutoCell(value: extraRR),
            "Equipment": PlutoCell(value: equipmentRR),
            "BucketInspection": PlutoCell(value: bucketInspectionRR),
            "Measures": PlutoCell(value: measureRR),
          },
        ),
      );
      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      print('Error en getIssues() - $e');
    }
    notifyListeners();
  }

  // Función para traernos los vehiculos
  Future<void> getIssuesAll(Vehicle vehicle) async {
    bucketInspectR = true;
    carBodyInspectR = true;
    equipmentInspectR = true;
    extraInspectR = true;
    fluidCheckInspectR = true;
    ligthsInspectR = true;
    measureInspectR = true;
    securityInspectR = true;

    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      // SUPBASECTRlV es el control vehicular
      final res = await supabaseCtrlV
          .from('issues_view')
          .select()
          .eq('id_vehicle', vehicle.idVehicle);

      issues = (res as List<dynamic>)
          .map((issues) => Issues.fromJson(jsonEncode(issues)))
          .toList();

      print(" ------------------- length en ALL: ${issues.length}");
      rows.clear();
      for (Issues issue in issues) {
        //Repetir esto con todas las listas
        issue.bucketInspectionR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            bucketInspectR = false;
            String nameIssue = key;
            String? comments =
                issue.bucketInspectionR.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue.bucketInspectionR
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue.bucketInspectionR.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                idIssue: issue.idBucketInspectionRFk,
                nameIssue: nameIssue,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            if (!validateElementAtListIC(
                bucketInspectionR, issue.idBucketInspectionRFk)) {
              print("Nuevo elemento Agregado bucketInspectionR");
              bucketInspectionR.add(newIssuesComments);
            }
            // bucketInspectionR.add(newIssuesComments);
          }
        });
        //Bucket delivered llamada a su lista
        issue.bucketInspectionD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            bucketInspectR = false;
            String nameIssue = key;
            String? comments =
                issue.bucketInspectionD.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue.bucketInspectionD
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue.bucketInspectionD.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                idIssue: issue.idBucketInspectionDFk ?? 123,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            bucketInspectionD.add(newIssuesComments);
          }
        });

        //Car BodyWork R
        issue.carBodyworkR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            carBodyInspectR = false;
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
                idIssue: issue.idCarBodyworkRFk,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            carBodyWorkR.add(newIssuesComments);
          }
        });

        //Car BodyWork D
        issue.carBodyworkD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            carBodyInspectR = false;
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
                idIssue: issue.idCarBodyworkDFk ?? 123,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            carBodyWorkD.add(newIssuesComments);
          }
        });

        // Equipment R
        issue.equimentR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            equipmentInspectR = false;
            String nameIssue = key;
            String? comments = issue.equimentR.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue.equimentR
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue.equimentR.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                idIssue: issue.idEquipmentRFk,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            equipmentR.add(newIssuesComments);
          }
        });

        //Equipment R
        issue.equimentD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            equipmentInspectR = false;
            String nameIssue = key;
            String? comments = issue.equimentD.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue.equimentD
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue.equimentD.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                idIssue: issue.idEquipmentDFk ?? 123,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            equipmentD.add(newIssuesComments);
          }
        });

        //Extra R
        issue.extraR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            extraInspectR = false;
            String nameIssue = key;
            String? comments = issue.extraR.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue.extraR
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue.extraR.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                idIssue: issue.idExtraRFk,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            extraR.add(newIssuesComments);
          }
        });

        //Extra D
        issue.extraD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            extraInspectR = false;
            String nameIssue = key;
            String? comments = issue.extraD.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue.extraD
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue.extraD.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                idIssue: issue.idExtraDFk ?? 123,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            extraD.add(newIssuesComments);
          }
        });

        //Fluid Check R
        issue.fluidCheckR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            fluidCheckInspectR = false;
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
                idIssue: issue.idFluidsCheckRFk,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            fluidCheckR.add(newIssuesComments);
          }
        });

        //Fluid Check D
        issue.fluidCheckD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            fluidCheckInspectR = false;
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
                idIssue: issue.idFluidsCheckDFk ?? 123,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            fluidCheckD.add(newIssuesComments);
          }
        });

        //Lights R
        issue.lightsR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            ligthsInspectR = false;
            String nameIssue = key;
            String? comments = issue.lightsR.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue.lightsR
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');
            listImage.removeLast();

            DateTime dateAdded =
                DateTime.parse(issue.lightsR.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                idIssue: issue.idLightsRFk,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            print("lightsR ${newIssuesComments.nameIssue}");

            lightsR.add(newIssuesComments);
          }
        });

        //Lights D
        issue.lightsD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            ligthsInspectR = false;
            String nameIssue = key;
            String? comments = issue.lightsD.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue.lightsD
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue.lightsD.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                idIssue: issue.idLightsDFk == null ? 123 : issue.idLightsDFk!,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            lightsD.add(newIssuesComments);
          }
        });

        //Measure R
        issue.measureR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            measureInspectR = false;
            String nameIssue = key;
            String? comments = issue.measureR.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue.measureR
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue.measureR.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                idIssue: issue.idMeasureRFk,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            measureR.add(newIssuesComments);
          }
        });

        //Measure D
        issue.measureD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            measureInspectR = false;
            String nameIssue = key;
            String? comments = issue.measureD.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue.measureD
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue.measureD.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                idIssue: issue.idMeasureDFk ?? 123,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            measureD.add(newIssuesComments);
          }
        });

        //Security R
        issue.securityR.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            securityInspectR = false;
            String nameIssue = key;
            String? comments = issue.securityR.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue.securityR
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue.securityR.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                idIssue: issue.idSecurityRFk,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            securityR.add(newIssuesComments);
          }
        });

        //Security D
        issue.securityD.toMap().forEach((key, value) {
          if (value == 'Bad' && !(key.contains("_comments"))) {
            securityInspectR = false;
            String nameIssue = key;
            String? comments = issue.securityD.toMap()["${nameIssue}_comments"];
            List<String> listImage = issue.securityD
                .toMap()["${nameIssue}_image"]
                .toString()
                .split('|');

            DateTime dateAdded =
                DateTime.parse(issue.securityD.toMap()["date_added"]);
            IssuesComments newIssuesComments = IssuesComments(
                nameIssue: nameIssue,
                idIssue: issue.idSecurityDFk ?? 123,
                comments: comments,
                listImages: listImage,
                dateAdded: dateAdded);
            securityD.add(newIssuesComments);
          }
        });
        if (issue.issuesD == null) {
          issue.fluidCheckR.state = true;
          issue.lightsR.state = true;
          issue.carBodyworkR.state = true;
          issue.securityR.state = true;
          issue.extraR.state = true;
          issue.bucketInspectionR.state = true;
          issue.equimentR.state = true;
          issue.measureR.state = true;

          rows.add(
            PlutoRow(
              cells: {
                "idIssues": PlutoCell(value: issue.issuesR.toString()),
                "Status": PlutoCell(value: "Check Out ${issue.idControlForm}"),
                "FluidsCheck": PlutoCell(value: issue.fluidCheckR),
                "Lights": PlutoCell(value: issue.lightsR),
                "CarBodyWork": PlutoCell(value: issue.carBodyworkR),
                "Security": PlutoCell(value: issue.securityR),
                "Extra": PlutoCell(value: issue.extraR),
                "Equipment": PlutoCell(value: issue.equimentR),
                "BucketInspection": PlutoCell(value: issue.bucketInspectionR),
                "Measures": PlutoCell(value: issue.measureR),
              },
            ),
          );
        } else {
          issue.fluidCheckD.state = false;
          issue.lightsD.state = false;
          issue.carBodyworkD.state = false;
          issue.securityD.state = false;
          issue.extraD.state = false;
          issue.bucketInspectionD.state = false;
          issue.equimentD.state = false;
          issue.measureD.state = false;
          rows.add(
            PlutoRow(
              cells: {
                "idIssues": PlutoCell(value: issue.issuesD.toString()),
                "Status": PlutoCell(value: "Check In ${issue.idControlForm}"),
                "FluidsCheck": PlutoCell(value: issue.fluidCheckD),
                "Lights": PlutoCell(value: issue.lightsD),
                "CarBodyWork": PlutoCell(value: issue.carBodyworkD),
                "Security": PlutoCell(value: issue.securityD),
                "Extra": PlutoCell(value: issue.extraD),
                "Equipment": PlutoCell(value: issue.equimentD),
                "BucketInspection": PlutoCell(value: issue.bucketInspectionD),
                "Measures": PlutoCell(value: issue.measureD),
              },
            ),
          );
          // rows.add(
          //   PlutoRow(
          //     cells: {
          //       "Status": PlutoCell(value: "Check Out"),
          //       "FluidsCheck": PlutoCell(value: issue.fluidCheckR),
          //       "Lights": PlutoCell(value: issue.lightsR),
          //       "CarBodyWork": PlutoCell(value: issue.carBodyworkR),
          //       "Security": PlutoCell(value: issue.securityR),
          //       "Extra": PlutoCell(value: issue.extraR),
          //       "Equipment": PlutoCell(value: issue.equimentR),
          //       "BucketInspection": PlutoCell(value: issue.bucketInspectionR),
          //       "Measures": PlutoCell(value: issue.measureR),
          //     },
          //   ),
          // );
        }
      }

      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      print('Error en getIssueAll() - $e');
    }
    notifyListeners();
  }

  // Función para cerrar los Issue
  Future<bool> closeIssue() async {
    // print(res);
    try {
      switch (contadorSeccion) {
        case 1:
          print(contadorSeccion);
          await supabaseCtrlV.from('fluids_check').update({
            registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_"):
                "Closed",
            "${registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_")}_comments":
                "Issue Closed update at ${dateTimeClosedIssueController.text}",
            // "${registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_")}_dateClosed":
            //     dateTimeClosedIssueController.text,
          }).eq("id_fluids_check", registroIssueComments!.idIssue);

          return true;
        case 2:
          print(contadorSeccion);
          await supabaseCtrlV.from('lights').update({
            registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_"):
                "Closed",
            "${registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_")}_comments":
                "Issue Closed update at ${dateTimeClosedIssueController.text}"
          }).eq("id_lights", registroIssueComments!.idIssue);
          return true;
        case 3:
          print(contadorSeccion);
          await supabaseCtrlV.from('car_bodywork').update({
            registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_"):
                "Closed",
            "${registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_")}_comments":
                "Issue Closed update at ${dateTimeClosedIssueController.text}"
          }).eq("car_bodywork.id_car_bodywork", registroIssueComments!.idIssue);
          return true;
        case 4:
          print(contadorSeccion);
          await supabaseCtrlV.from('security').update({
            registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_"):
                "Closed",
            "${registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_")}_comments":
                "Issue Closed update at ${dateTimeClosedIssueController.text}"
          }).eq("id_security", registroIssueComments!.idIssue);
          return true;

        case 5:
          print(contadorSeccion);
          await supabaseCtrlV.from('extra').update({
            registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_"):
                "Closed",
            "${registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_")}_comments":
                "Issue Closed update at ${dateTimeClosedIssueController.text}"
          }).eq("id_extra", registroIssueComments!.idIssue);
          return true;
        case 6:
          print(contadorSeccion);
          await supabaseCtrlV.from('equipment').update({
            registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_"):
                "Closed",
            "${registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_")}_comments":
                "Issue Closed update at ${dateTimeClosedIssueController.text}"
          }).eq("id_equipment", registroIssueComments!.idIssue);
          return true;

        case 7:
          print(contadorSeccion);
          await supabaseCtrlV.from('bucket_inspection').update({
            registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_"):
                "Closed",
            "${registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_")}_comments":
                "Issue Closed update at ${dateTimeClosedIssueController.text}",
            "${registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_")}_dateClosed":
                dateTimeClosedIssueController.text,
          }).eq("id_bucket_inspection", registroIssueComments!.idIssue);
          return true;

        case 8:
          print(contadorSeccion);
          await supabaseCtrlV.from('measures').update({
            registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_"):
                "Closed",
            "${registroIssueComments!.nameIssue.toLowerCase().replaceAll(" ", "_")}_comments":
                "Issue Closed update at ${dateTimeClosedIssueController.text}"
          }).eq("id_measure", registroIssueComments!.idIssue);
          return true;

        default:
          return true;
      }
    } catch (e) {
      print('Error in closeIssue() - $e');
      return false;
    }
  }

  // Función para traer el nombre de los issues de BucketInspection
  Future<void> getIssuesBasics(IssuesXUser issuesXUser) async {
    // clearListgetIssues();
    try {
      final res = await supabaseCtrlV
          .from('issues_view')
          .select(
              'id_vehicle, bucket_inspection_r ->id_bucket_inspection, bucket_inspection_r ->holes_drilled,bucket_inspection_r ->insulated, bucket_inspection_r ->bucket_liner, bucket_inspection_r ->date_added')
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
          if (!validateElementAtList(
              bucketInspectionRR, issue.idBucketInspection!)) {
            print("Nuevo elemento Agregado bucketInspectionRR");
            bucketInspectionRR.add(newIssueComments);
          }
        }
        if (issue.bucketLiner == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Bucket Liner",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              bucketInspectionRR, issue.idBucketInspection!)) {
            print("Nuevo elemento Agregado bucketInspectionRR");
            bucketInspectionRR.add(newIssueComments);
          }
        }
        if (issue.insulated == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Insulated",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              bucketInspectionRR, issue.idBucketInspection!)) {
            print("Nuevo elemento Agregado bucketInspectionRR");
            bucketInspectionRR.add(newIssueComments);
          }
        }
      }

      // BucketInspectionD
      for (BucketInspection issue in issuePartD) {
        if (issue.holesDrilled == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Holes Drilled",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              bucketInspectionDD, issue.idBucketInspection!)) {
            print("Nuevo elemento Agregado bucketInspectionDD");
            bucketInspectionDD.add(newIssueComments);
          }
        }
        if (issue.bucketLiner == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Bucket Liner",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              bucketInspectionDD, issue.idBucketInspection!)) {
            print("Nuevo elemento Agregado bucketInspectionDD");
            bucketInspectionDD.add(newIssueComments);
          }
        }
        if (issue.insulated == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Insulated",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              bucketInspectionDD, issue.idBucketInspection!)) {
            print("Nuevo elemento Agregado bucketInspectionDD");
            bucketInspectionDD.add(newIssueComments);
          }
        }
      }
      print("Entro a getIssuesBasics");
    } catch (e) {
      print("Error in getIssuesBasics() - $e");
    }
    notifyListeners();
  }

  // Función para traer el nombre de los issues de BucketInspection closed
  Future<void> getIssueBucketInspectionClosed(
    IssuesXUser issuesXUser,
  ) async {
    print("actualissuexUSER: $issuesXUser");
    print("Entro a getIssueBucketInspectionClosed");
    try {
      final res = await supabaseCtrlV
          .from('issues_view')
          .select(
              'id_vehicle, bucket_inspection_r ->id_bucket_inspection, bucket_inspection_r ->holes_drilled,bucket_inspection_r ->insulated, bucket_inspection_r ->bucket_liner,bucket_inspection_r ->bucket_liner_dateClosed, bucket_inspection_r ->date_added')
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

      issuePart1Closed = (res as List<dynamic>)
          .map((issuePart1Closed) =>
              BucketInspection.fromJson(jsonEncode(issuePart1Closed)))
          .toList();
      issuePartDClosed = (resD as List<dynamic>)
          .map((issuePartDClosed) =>
              BucketInspection.fromJson(jsonEncode(issuePartDClosed)))
          .toList();

      // BucketInspectionR
      for (BucketInspection issue in issuePart1Closed) {
        if (issue.holesDrilled == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Holes Drilled",
              category: "Bucket Inspection",
              dateAddedOpen: issue.dateAdded!);

          if (!validateElementAtList(
              listTotalClosedIssue, issue.idBucketInspection!)) {
            print("Nuevo elemento Agregado bucketInspectionRR");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.bucketLiner == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Bucket Liner",
              category: "Bucket Inspection",
              dateAddedClose: issue.bucketLinerClosed,
              dateAddedOpen: issue.dateAdded!);
          print("bucketLinerClosed: ${issue.bucketLinerClosed}");
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idBucketInspection!)) {
            print("Nuevo elemento Agregado bucketInspectionRR");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.insulated == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Insulated",
              category: "Bucket Inspection",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idBucketInspection!)) {
            print("dateAddedClose: ${newIssueComments.dateAddedClose}");
            print("Nuevo elemento Agregado bucketInspectionRR");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
      }

      // BucketInspectionD
      for (BucketInspection issue in issuePartDClosed) {
        if (issue.holesDrilled == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Holes Drilled",
              category: "Bucket Inspection",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idBucketInspection!)) {
            print("Nuevo elemento Agregado bucketInspectionDD");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.bucketLiner == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Bucket Liner",
              category: "Bucket Inspection",
              dateAddedClose: issue.bucketLinerClosed,
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idBucketInspection!)) {
            print("Nuevo elemento Agregado bucketInspectionDD");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.insulated == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idBucketInspection!,
              nameIssue: "Insulated",
              category: "Bucket Inspection",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idBucketInspection!)) {
            print("Nuevo elemento Agregado bucketInspectionDD");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
      }
      print("Entro a getIssueBucketInspectionClosed");
    } catch (e) {
      print("Error in getIssueBucketInspectionClosed() - $e");
    }
    notifyListeners();
  }

  // Función para traer los comentarios de los issues de BucketInspection
  Future<void> getIssuesBucketInspectionComments(
      IssueOpenclose issueOpenClose) async {
    // clearListgetIssues();

    try {
      if (issueOpenClose.nameIssue == "Holes Drilled") {
        final res = await supabaseCtrlV
            .from('bucket_inspection')
            .select('holes_drilled_comments, holes_drilled_image, date_added')
            .eq('id_bucket_inspection', issueOpenClose.idIssue);
        final resHolesDrilled = res as List<dynamic>;
        if (resHolesDrilled.isNotEmpty) {
          List<String> listImage = resHolesDrilled.first['holes_drilled_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resHolesDrilled.first['holes_drilled_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resHolesDrilled.first['date_added']));
        }
      }
      if (issueOpenClose.nameIssue == "Bucket Liner") {
        final res = await supabaseCtrlV
            .from('bucket_inspection')
            .select('bucket_liner_comments, bucket_liner_image, date_added')
            .eq('id_bucket_inspection', issueOpenClose.idIssue);
        final resBucketLiner = res as List<dynamic>;
        if (resBucketLiner.isNotEmpty) {
          List<String> listImage =
              resBucketLiner.first['holes_drilled_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resBucketLiner.first['bucket_liner_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resBucketLiner.first['date_added']));
        }
      }
      if (issueOpenClose.nameIssue == "Insulated") {
        final res = await supabaseCtrlV
            .from('bucket_inspection')
            .select('insulated_comments, insulated_image, date_added')
            .eq('id_bucket_inspection', issueOpenClose.idIssue);
        final resInsulated = res as List<dynamic>;
        if (resInsulated.isNotEmpty) {
          List<String> listImage =
              resInsulated.first['insulated_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resInsulated.first['insulated_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resInsulated.first['date_added']));
        }
      }
      print("Entro a getIssuesBucketInspectionComments");
    } catch (e) {
      print("Error in getIssuesBucketInspectionComments() - $e");
    }
    notifyListeners();
  }

  // Función para traer el nombre de los issues de CarBodyWork
  Future<void> getIssueCarBodyWorkComments(
      IssueOpenclose issueOpenClose) async {
    // clearListgetIssues();
    print("Entro a  getIssueCarBodyWorkComment");
    try {
      if (issueOpenClose.nameIssue == "Wiper Blades Front") {
        final res = await supabaseCtrlV
            .from('car_bodywork')
            .select(
                'wiper_blades_front_comments, wiper_blades_front_image, date_added')
            .eq('id_car_bodywork', issueOpenClose.idIssue);
        final resWiperBladeF = res as List<dynamic>;
        if (resWiperBladeF.isNotEmpty) {
          List<String> listImage = resWiperBladeF
              .first['wiper_blades_front_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resWiperBladeF.first['wiper_blades_front_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resWiperBladeF.first['date_added']));
          print(
              "RegistroIssueCommentsCar: ${registroIssueComments!.nameIssue}");
        }

        notifyListeners();
      }
      if (issueOpenClose.nameIssue == "Wiper Blades Back") {
        final res = await supabaseCtrlV
            .from('car_bodywork')
            .select(
                'wiper_blades_back_comments, wiper_blades_back_image, date_added')
            .eq('id_car_bodywork', issueOpenClose.idIssue);
        final resWiperBladeB = res as List<dynamic>;
        if (resWiperBladeB.isNotEmpty) {
          List<String> listImage = resWiperBladeB
              .first['wiper_blades_back_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resWiperBladeB.first['wiper_blades_back_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resWiperBladeB.first['date_added']));
        }
        notifyListeners();
      }
      if (issueOpenClose.nameIssue == "General Body") {
        final res = await supabaseCtrlV
            .from('car_bodywork')
            .select('general_body_comments, general_body_image, date_added')
            .eq('id_car_bodywork', issueOpenClose.idIssue);
        final resGeneralB = res as List<dynamic>;
        if (resGeneralB.isNotEmpty) {
          List<String> listImage =
              resGeneralB.first['general_body_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resGeneralB.first['general_body_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resGeneralB.first['date_added']));
        }
        notifyListeners();
      }
      if (issueOpenClose.nameIssue == "Decaling") {
        final res = await supabaseCtrlV
            .from('car_bodywork')
            .select('decaling_comments, decaling_image, date_added')
            .eq('id_car_bodywork', issueOpenClose.idIssue);
        final resDecaling = res as List<dynamic>;
        if (resDecaling.isNotEmpty) {
          List<String> listImage =
              resDecaling.first['decaling_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resDecaling.first['decaling_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resDecaling.first['date_added']));
        }
        notifyListeners();
      }
      if (issueOpenClose.nameIssue == "Tires") {
        final res = await supabaseCtrlV
            .from('car_bodywork')
            .select('tires_comments, tires_image, date_added')
            .eq('id_car_bodywork', issueOpenClose.idIssue);
        final resTires = res as List<dynamic>;
        if (resTires.isNotEmpty) {
          List<String> listImage =
              resTires.first['tires_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resTires.first['tires_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resTires.first['date_added']));
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Glass") {
        final res = await supabaseCtrlV
            .from('car_bodywork')
            .select('glass_comments, glass_image, date_added')
            .eq('id_car_bodywork', issueOpenClose.idIssue);
        final resGlass = res as List<dynamic>;
        if (resGlass.isNotEmpty) {
          List<String> listImage =
              resGlass.first['glass_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resGlass.first['glass_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resGlass.first['date_added']));
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Mirrors") {
        final res = await supabaseCtrlV
            .from('car_bodywork')
            .select('mirrors_comments, mirrors_image, date_added')
            .eq('id_car_bodywork', issueOpenClose.idIssue);
        final resMirrors = res as List<dynamic>;
        if (resMirrors.isNotEmpty) {
          List<String> listImage =
              resMirrors.first['mirrors_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resMirrors.first['mirrors_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resMirrors.first['date_added']));
        }
        notifyListeners();
      }
      if (issueOpenClose.nameIssue == "Parking") {
        final res = await supabaseCtrlV
            .from('car_bodywork')
            .select('parking_comments, parking_image, date_added')
            .eq('id_car_bodywork', issueOpenClose.idIssue);
        final resParking = res as List<dynamic>;
        if (resParking.isNotEmpty) {
          List<String> listImage =
              resParking.first['parking_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resParking.first['parking_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resParking.first['date_added']));
        }
        notifyListeners();
      }
      if (issueOpenClose.nameIssue == "Brakes") {
        final res = await supabaseCtrlV
            .from('car_bodywork')
            .select('brakes_comments, brakes_image, date_added')
            .eq('id_car_bodywork', issueOpenClose.idIssue);
        final resBrakes = res as List<dynamic>;
        if (resBrakes.isNotEmpty) {
          List<String> listImage =
              resBrakes.first['brakes_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resBrakes.first['brakes_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resBrakes.first['date_added']));
        }
        notifyListeners();
      }
      if (issueOpenClose.nameIssue == "Emg Brakes") {
        final res = await supabaseCtrlV
            .from('car_bodywork')
            .select('emg_brakes_comments, emg_brakes_image, date_added')
            .eq('id_car_bodywork', issueOpenClose.idIssue);
        final resEmgBrakes = res as List<dynamic>;
        if (resEmgBrakes.isNotEmpty) {
          List<String> listImage =
              resEmgBrakes.first['emg_brakes_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resEmgBrakes.first['emg_brakes_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resEmgBrakes.first['date_added']));
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Horn") {
        final res = await supabaseCtrlV
            .from('car_bodywork')
            .select('horn_comments, horn_image, date_added')
            .eq('id_car_bodywork', issueOpenClose.idIssue);
        final resHorn = res as List<dynamic>;
        if (resHorn.isNotEmpty) {
          List<String> listImage =
              resHorn.first['horn_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resHorn.first['horn_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resHorn.first['date_added']));
        }
        notifyListeners();
      }
      print("Entro a getIssueCarBodyWorkComments");
    } catch (e) {
      print("Error in getIssueCarBodyWorkComments() - $e");
    }
    notifyListeners();
  }

  // Función para traer los comentarios de los issues de CarBodywork
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
              nameIssue: "Wiper Blades Front",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkRR, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRR");
            carBodyWorkRR.add(newIssueComments);
          }
        }
        if (issue.wiperBladesBack == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Wiper Blades Back",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkRR, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRR");
            carBodyWorkRR.add(newIssueComments);
          }
        }
        if (issue.windshieldWiperFront == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "WindShield Wiper Front",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkRR, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRR");
            carBodyWorkRR.add(newIssueComments);
          }
        }
        if (issue.windshieldWiperBack == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "WindShield Wiper Back",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkRR, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRR");
            carBodyWorkRR.add(newIssueComments);
          }
        }
        if (issue.generalBody == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "General Body",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkRR, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRR");
            carBodyWorkRR.add(newIssueComments);
          }
        }
        if (issue.decaling == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Decaling",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkRR, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRR");
            carBodyWorkRR.add(newIssueComments);
          }
        }
        if (issue.tires == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Tires",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkRR, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRR");
            carBodyWorkRR.add(newIssueComments);
          }
        }
        if (issue.glass == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Glass",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkRR, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRR");
            carBodyWorkRR.add(newIssueComments);
          }
        }
        if (issue.mirrors == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Mirrors",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkRR, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRR");
            carBodyWorkRR.add(newIssueComments);
          }
        }
        if (issue.parking == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Parking",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkRR, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRR");
            carBodyWorkRR.add(newIssueComments);
          }
        }
        if (issue.brakes == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Brakes",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkRR, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRR");
            carBodyWorkRR.add(newIssueComments);
          }
        }
        if (issue.emgBrakes == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Emg Brakes",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkRR, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRR");
            carBodyWorkRR.add(newIssueComments);
          }
        }
        if (issue.horn == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Horn",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkRR, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRR");
            carBodyWorkRR.add(newIssueComments);
          }
        }
      }

      // BucketInspectionD
      for (CarBodywork issue in issueCarBodyWD) {
        if (issue.wiperBladesFront == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Wuper Blades Front",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkDD, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDD");
            carBodyWorkDD.add(newIssueComments);
          }
        }
        if (issue.wiperBladesBack == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Wiper Blades Back",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkDD, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDD");
            carBodyWorkDD.add(newIssueComments);
          }
        }
        if (issue.windshieldWiperFront == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "WindShield Wiper Front",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkDD, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDD");
            carBodyWorkDD.add(newIssueComments);
          }
        }
        if (issue.windshieldWiperBack == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "WindShield Wiper Back",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkDD, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDD");
            carBodyWorkDD.add(newIssueComments);
          }
        }
        if (issue.generalBody == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "General Body",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkDD, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDD");
            carBodyWorkDD.add(newIssueComments);
          }
        }
        if (issue.decaling == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Decaling",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkDD, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDD");
            carBodyWorkDD.add(newIssueComments);
          }
        }
        if (issue.tires == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Tires",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkDD, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDD");
            carBodyWorkDD.add(newIssueComments);
          }
        }
        if (issue.glass == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Glass",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkDD, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDD");
            carBodyWorkDD.add(newIssueComments);
          }
        }
        if (issue.mirrors == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Mirrors",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkDD, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDD");
            carBodyWorkDD.add(newIssueComments);
          }
        }
        if (issue.parking == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Parking",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkDD, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDD");
            carBodyWorkDD.add(newIssueComments);
          }
        }
        if (issue.brakes == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Brakes",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkDD, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDD");
            carBodyWorkDD.add(newIssueComments);
          }
        }
        if (issue.emgBrakes == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Emg Brakes",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkDD, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDD");
            carBodyWorkDD.add(newIssueComments);
          }
        }
        if (issue.horn == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Horn",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(carBodyWorkDD, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDD");
            carBodyWorkDD.add(newIssueComments);
          }
        }
      }
      print("Entro a getIssuesCarBodywork");
    } catch (e) {
      print("Error in getIssuesCarBodywork() - $e");
    }
    notifyListeners();
  }

  // Función para traer los comentarios de los issues de CarBodywork
  Future<void> getIssuesCarBodyworkClosed(IssuesXUser issuesXUser) async {
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

      issueCarBodywRClosed = (res as List<dynamic>)
          .map((issueCarBodywRClosed) =>
              CarBodywork.fromJson(jsonEncode(issueCarBodywRClosed)))
          .toList();
      issueCarBodyWDClosed = (resD as List<dynamic>)
          .map((issueCarBodyWDClosed) =>
              CarBodywork.fromJson(jsonEncode(issueCarBodyWDClosed)))
          .toList();

      // BucketInspectionR
      for (CarBodywork issue in issueCarBodywRClosed) {
        if (issue.wiperBladesFront == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Wiper Blades Front",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.wiperBladesBack == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              category: "CarBodywork",
              nameIssue: "Wiper Blades Back",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.windshieldWiperFront == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              category: "CarBodywork",
              nameIssue: "WindShield Wiper Front",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.windshieldWiperBack == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              category: "CarBodywork",
              nameIssue: "WindShield Wiper Back",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.generalBody == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "General Body",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.decaling == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Decaling",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.tires == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Tires",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.glass == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Glass",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.mirrors == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Mirrors",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.parking == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Parking",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.brakes == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Brakes",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.emgBrakes == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Emg Brakes",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.horn == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Horn",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
      }

      // BucketInspectionD
      for (CarBodywork issue in issueCarBodyWDClosed) {
        if (issue.wiperBladesFront == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Wiper Blades Front",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.wiperBladesBack == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              category: "CarBodywork",
              nameIssue: "Wiper Blades Back",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.windshieldWiperFront == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              category: "CarBodywork",
              nameIssue: "WindShield Wiper Front",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.windshieldWiperBack == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              category: "CarBodywork",
              nameIssue: "WindShield Wiper Back",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.generalBody == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "General Body",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.decaling == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Decaling",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.tires == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Tires",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.glass == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Glass",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.mirrors == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Mirrors",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.parking == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Parking",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.brakes == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Brakes",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.emgBrakes == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Emg Brakes",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.horn == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idCarBodywork!,
              nameIssue: "Horn",
              category: "CarBodywork",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idCarBodywork!)) {
            print("Nuevo elemento Agregado carBodyWorkDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
      }
      print("Entro a getIssuesCarBodyworkClosed");
    } catch (e) {
      print("Error in getIssuesCarBodyworkClosed() - $e");
    }
    notifyListeners();
  }

  // Función para traer los comentarios de los issues de Equipment
  Future<void> getIssuesEquipmentComments(IssueOpenclose issueOpenClose) async {
    // clearListgetIssues();
    print("Entro a  getIssuesEquipmentComments");
    try {
      if (issueOpenClose.nameIssue == "ignition key") {
        final res = await supabaseCtrlV
            .from('equipment')
            .select('ignition_key_comments, ignition_key_image, date_added')
            .eq('id_equipment', issueOpenClose.idIssue);
        final resIgnitionK = res as List<dynamic>;
        if (resIgnitionK.isNotEmpty) {
          List<String> listImage =
              resIgnitionK.first['ignition_key_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resIgnitionK.first['ignition_key_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resIgnitionK.first['date_added']));
          print(
              "getIssuesEquipmentComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }
      if (issueOpenClose.nameIssue == "Bins Box Key") {
        final res = await supabaseCtrlV
            .from('equipment')
            .select('bins_box_key_comments, bins_box_key_image, date_added')
            .eq('id_equipment', issueOpenClose.idIssue);
        final resBinsBoxKey = res as List<dynamic>;
        if (resBinsBoxKey.isNotEmpty) {
          List<String> listImage =
              resBinsBoxKey.first['bins_box_key_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resBinsBoxKey.first['bins_box_key_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resBinsBoxKey.first['date_added']));
          print(
              "getIssuesEquipmentComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Vehicle Registration Copy") {
        final res = await supabaseCtrlV
            .from('equipment')
            .select(
                'vehicle_registration_copy_comments, vehicle_registration_copy_image, date_added')
            .eq('id_equipment', issueOpenClose.idIssue);
        final resVehicleRC = res as List<dynamic>;
        if (resVehicleRC.isNotEmpty) {
          List<String> listImage = resVehicleRC
              .first['vehicle_registration_copy_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments:
                  resVehicleRC.first['vehicle_registration_copy_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resVehicleRC.first['date_added']));
          print(
              "getIssuesEquipmentComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Vehicle Insurance Copy") {
        final res = await supabaseCtrlV
            .from('equipment')
            .select(
                'vehicle_insurance_copy_comments, vehicle_insurance_copy_image, date_added')
            .eq('id_equipment', issueOpenClose.idIssue);
        final resVehicleIC = res as List<dynamic>;
        if (resVehicleIC.isNotEmpty) {
          List<String> listImage = resVehicleIC
              .first['vehicle_insurance_copy_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resVehicleIC.first['vehicle_insurance_copy_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resVehicleIC.first['date_added']));
          print(
              "getIssuesEquipmentComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Bucket Lift Operator Manual") {
        final res = await supabaseCtrlV
            .from('equipment')
            .select(
                'bucket_lift_operator_manual_comments, bucket_lift_operator_manual_image, date_added')
            .eq('id_equipment', issueOpenClose.idIssue);
        final resBucketLiftOM = res as List<dynamic>;
        if (resBucketLiftOM.isNotEmpty) {
          List<String> listImage = resBucketLiftOM
              .first['bucket_lift_operator_manual_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments:
                  resBucketLiftOM.first['bucket_lift_operator_manual_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resBucketLiftOM.first['date_added']));
          print(
              "getIssuesEquipmentComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }
      print("Entro a getIssuesEquipmentComments");
    } catch (e) {
      print("Error in getIssuesEquipmentComments() - $e");
    }
    notifyListeners();
  }

  // Función para traer los nombre de los issues de Equipment
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

          if (!validateElementAtList(equipmentRR, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentRR");
            equipmentRR.add(newIssueComments);
          }
        }
        if (issue.binsBoxKey == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Bins Box Key",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(equipmentRR, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentRR");
            equipmentRR.add(newIssueComments);
          }
        }
        if (issue.vehicleRegistrationCopy == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Vehicle Registration Copy",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(equipmentRR, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentRR");
            equipmentRR.add(newIssueComments);
          }
        }
        if (issue.vehicleInsuranceCopy == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Vehicle Insurance Copy",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(equipmentRR, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentRR");
            equipmentRR.add(newIssueComments);
          }
        }
        if (issue.bucketLiftOperatorManual == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Bucket Lift Operator Manual",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(equipmentRR, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentRR");
            equipmentRR.add(newIssueComments);
          }
        }
      }
      // BucketInspectionD

      for (Equiment issue in issueEquipmentD) {
        if (issue.ignitionKey == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "ignition key",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(equipmentDD, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentDD");
            equipmentDD.add(newIssueComments);
          }
        }
        if (issue.binsBoxKey == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Bins Box Key",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(equipmentDD, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentDD");
            equipmentDD.add(newIssueComments);
          }
        }
        if (issue.vehicleRegistrationCopy == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Vehicle Registration Copy",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(equipmentDD, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentDD");
            equipmentDD.add(newIssueComments);
          }
        }
        if (issue.vehicleInsuranceCopy == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Vehicle Insurance Copy",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(equipmentDD, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentDD");
            equipmentDD.add(newIssueComments);
          }
        }
        if (issue.bucketLiftOperatorManual == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Bucket Lift Operator Manual",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(equipmentDD, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentDD");
            equipmentDD.add(newIssueComments);
          }
        }
      }
      print("Entro a getIssuesEquipment");
    } catch (e) {
      print("Error in getIssuesEquipment() - $e");
    }
    //clearListgetIssues();

    notifyListeners();
  }

  // Función para traer los nombre de los issues de Equipment Closed
  Future<void> getIssuesEquipmentClosed(IssuesXUser issuesXUser) async {
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

      issueEquipmentRClosed = (res as List<dynamic>)
          .map((issueEquipmentRClosed) =>
              Equiment.fromJson(jsonEncode(issueEquipmentRClosed)))
          .toList();
      issueEquipmentDClosed = (resD as List<dynamic>)
          .map((issueEquipmentDClosed) =>
              Equiment.fromJson(jsonEncode(issueEquipmentDClosed)))
          .toList();

      // BucketInspectionR
      for (Equiment issue in issueEquipmentRClosed) {
        if (issue.ignitionKey == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "ignition key",
              category: "Equipment",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.binsBoxKey == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Bins Box Key",
              category: "Equipment",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.vehicleRegistrationCopy == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Vehicle Registration Copy",
              category: "Equipment",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.vehicleInsuranceCopy == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Vehicle Insurance Copy",
              category: "Equipment",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.bucketLiftOperatorManual == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Bucket Lift Operator Manual",
              category: "Equipment",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
      }
      // BucketInspectionD

      for (Equiment issue in issueEquipmentDClosed) {
        if (issue.ignitionKey == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "ignition key",
              category: "Equipment",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.binsBoxKey == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Bins Box Key",
              category: "Equipment",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.vehicleRegistrationCopy == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Vehicle Registration Copy",
              category: "Equipment",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.vehicleInsuranceCopy == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Vehicle Insurance Copy",
              category: "Equipment",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.bucketLiftOperatorManual == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idEquipment!,
              nameIssue: "Bucket Lift Operator Manual",
              category: "Equipment",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idEquipment!)) {
            print("Nuevo elemento Agregado equipmentDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
      }
      print("Entro a getIssuesEquipmentClosed");
    } catch (e) {
      print("Error in getIssuesEquipmentClosed() - $e");
    }
    //clearListgetIssues();

    notifyListeners();
  }

  // Función para traer los nombre de los issues de Extra
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

      //// print(res);

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
          if (!validateElementAtList(extraRR, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRR");
            extraRR.add(newIssueComments);
          }
        }
        if (issue.stepLadder == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Step Ladder",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraRR, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRR");
            extraRR.add(newIssueComments);
          }
        }
        if (issue.ladderStraps == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Ladder Straps",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraRR, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRR");
            extraRR.add(newIssueComments);
          }
        }
        if (issue.hydraulicFluidForBucket == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Hydraulic Fluid for Bucket",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraRR, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRR");
            extraRR.add(newIssueComments);
          }
        }
        if (issue.fiberReelRack == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Fiber Reel Rack",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraRR, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRR");
            extraRR.add(newIssueComments);
          }
        }
        if (issue.binsLockedAndSecure == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Bins Locked and Secure",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraRR, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRR");
            extraRR.add(newIssueComments);
          }
        }
        if (issue.safetyHarness == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Safety Harness",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraRR, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRR");
            extraRR.add(newIssueComments);
          }
        }
        if (issue.lanyardSafetyHarness == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Lanyard Safety Harness",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraRR, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRR");
            extraRR.add(newIssueComments);
          }
        }
      }
      // ExtraR
      for (Extra issue in issueExtraR) {
        if (issue.ladder == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Ladder",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraDD, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraDD");
            extraDD.add(newIssueComments);
          }
        }
        if (issue.stepLadder == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Step Ladder",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraDD, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraDD");
            extraDD.add(newIssueComments);
          }
        }
        if (issue.ladderStraps == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Ladder Straps",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraDD, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraDD");
            extraDD.add(newIssueComments);
          }
        }
        if (issue.hydraulicFluidForBucket == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Hydraulic Fluid for Bucket",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraDD, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraDD");
            extraDD.add(newIssueComments);
          }
        }
        if (issue.fiberReelRack == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Fiber Reel Rack",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraDD, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraDD");
            extraDD.add(newIssueComments);
          }
        }
        if (issue.binsLockedAndSecure == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Bins Locked and Secure",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraDD, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraDD");
            extraDD.add(newIssueComments);
          }
        }
        if (issue.safetyHarness == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Safety Harness",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraDD, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraDD");
            extraDD.add(newIssueComments);
          }
        }
        if (issue.lanyardSafetyHarness == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Lanyard Safety Harness",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(extraDD, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraDD");
            extraDD.add(newIssueComments);
          }
        }
      }
      print("Entro a getIssuesExtra");
    } catch (e) {
      print("Error in getIssuesExtra() - $e");
    }
    //clearListgetIssues();

    notifyListeners();
  }

  // Función para traer los nombre de los issues de Extra
  Future<void> getIssuesExtraClosed(IssuesXUser issuesXUser) async {
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

      issueExtraRClosed = (res as List<dynamic>)
          .map((issueExtraRClosed) =>
              Extra.fromJson(jsonEncode(issueExtraRClosed)))
          .toList();
      issueExtradDClosed = (resD as List<dynamic>)
          .map((issueExtradDClosed) =>
              Extra.fromJson(jsonEncode(issueExtradDClosed)))
          .toList();

      // ExtraR
      for (Extra issue in issueExtraRClosed) {
        if (issue.ladder == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Ladder",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.stepLadder == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Step Ladder",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.ladderStraps == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Ladder Straps",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.hydraulicFluidForBucket == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Hydraulic Fluid for Bucket",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.fiberReelRack == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Fiber Reel Rack",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.binsLockedAndSecure == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Bins Locked and Secure",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.safetyHarness == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Safety Harness",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.lanyardSafetyHarness == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Lanyard Safety Harness",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
      }
      // ExtraR
      for (Extra issue in issueExtradDClosed) {
        if (issue.ladder == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Ladder",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.stepLadder == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Step Ladder",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.ladderStraps == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Ladder Straps",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.hydraulicFluidForBucket == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Hydraulic Fluid for Bucket",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.fiberReelRack == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Fiber Reel Rack",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.binsLockedAndSecure == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Bins Locked and Secure",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.safetyHarness == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Safety Harness",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.lanyardSafetyHarness == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idExtra!,
              nameIssue: "Lanyard Safety Harness",
              category: "Extra",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idExtra!)) {
            print("Nuevo elemento Agregado extraRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
      }
      print("Entro a getIssuesExtraClosed");
    } catch (e) {
      print("Error in getIssuesExtraClosed() - $e");
    }
    //clearListgetIssues();

    notifyListeners();
  }

  // Función para traer los comentarios de los issues de Extra
  Future<void> getIssuesExtraComments(IssueOpenclose issueOpenClose) async {
    // clearListgetIssues();
    print("Entro a  getIssuesExtraComments");
    try {
      if (issueOpenClose.nameIssue == "Ladder") {
        final res = await supabaseCtrlV
            .from('extra')
            .select('ladder_comments, ladder_image, date_added')
            .eq('id_extra', issueOpenClose.idIssue);
        final resLadder = res as List<dynamic>;
        if (resLadder.isNotEmpty) {
          List<String> listImage =
              resLadder.first['ladder_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resLadder.first['ladder_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resLadder.first['date_added']));
          print(
              "getIssuesEquipmentComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Step Ladder") {
        final res = await supabaseCtrlV
            .from('extra')
            .select('step_ladder_comments, step_ladder_image, date_added')
            .eq('id_extra', issueOpenClose.idIssue);
        final resStepLadder = res as List<dynamic>;
        if (resStepLadder.isNotEmpty) {
          List<String> listImage =
              resStepLadder.first['step_ladder_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resStepLadder.first['step_ladder_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resStepLadder.first['date_added']));
          print(
              "getIssuesEquipmentComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Ladder Straps") {
        final res = await supabaseCtrlV
            .from('extra')
            .select('ladder_straps_comments, ladder_straps_image, date_added')
            .eq('id_extra', issueOpenClose.idIssue);
        final resLadderS = res as List<dynamic>;
        if (resLadderS.isNotEmpty) {
          List<String> listImage =
              resLadderS.first['ladder_straps_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              nameIssue: issueOpenClose.nameIssue,
              idIssue: issueOpenClose.idIssue,
              comments: resLadderS.first['ladder_straps_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resLadderS.first['date_added']));
          print(
              "getIssuesEquipmentComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Hydraulic Fluid for Bucket") {
        final res = await supabaseCtrlV
            .from('extra')
            .select(
                'hydraulic_fluid_for_bucket_comments, hydraulic_fluid_for_bucket_image, date_added')
            .eq('id_extra', issueOpenClose.idIssue);
        final resHydraFFB = res as List<dynamic>;
        if (resHydraFFB.isNotEmpty) {
          List<String> listImage = resHydraFFB
              .first['hydraulic_fluid_for_bucket_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments:
                  resHydraFFB.first['hydraulic_fluid_for_bucket_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resHydraFFB.first['date_added']));
          print(
              "getIssuesEquipmentComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Fiber Reel Rack") {
        final res = await supabaseCtrlV
            .from('extra')
            .select(
                'fiber_reel_rack_comments, fiber_reel_rack_image, date_added')
            .eq('id_extra', issueOpenClose.idIssue);
        final resFiberRR = res as List<dynamic>;
        if (resFiberRR.isNotEmpty) {
          List<String> listImage =
              resFiberRR.first['fiber_reel_rack_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resFiberRR.first['fiber_reel_rack_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resFiberRR.first['date_added']));
          print(
              "getIssuesEquipmentComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Bins Locked and Secure") {
        final res = await supabaseCtrlV
            .from('extra')
            .select(
                'bins_locked_and_secure_comments, bins_locked_and_secure_image, date_added')
            .eq('id_extra', issueOpenClose.idIssue);
        final resBinsLAS = res as List<dynamic>;
        if (resBinsLAS.isNotEmpty) {
          List<String> listImage = resBinsLAS
              .first['bins_locked_and_secure_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resBinsLAS.first['bins_locked_and_secure_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resBinsLAS.first['date_added']));
          print(
              "getIssuesEquipmentComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Safety Harness") {
        final res = await supabaseCtrlV
            .from('extra')
            .select('safety_harness_comments, safety_harness_image, date_added')
            .eq('id_extra', issueOpenClose.idIssue);
        final resSafetyH = res as List<dynamic>;
        if (resSafetyH.isNotEmpty) {
          List<String> listImage =
              resSafetyH.first['safety_harness_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resSafetyH.first['safety_harness_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resSafetyH.first['date_added']));
          print(
              "getIssuesEquipmentComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Lanyard Safety Harness") {
        final res = await supabaseCtrlV
            .from('extra')
            .select(
                'lanyard_safety_harness_comments, lanyard_safety_harness_image, date_added')
            .eq('id_extra', issueOpenClose.idIssue);
        final resLanyardSH = res as List<dynamic>;
        if (resLanyardSH.isNotEmpty) {
          List<String> listImage = resLanyardSH
              .first['lanyard_safety_harness_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resLanyardSH.first['lanyard_safety_harness_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resLanyardSH.first['date_added']));
          print(
              "getIssuesEquipmentComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }
      print("Entro a getIssuesEquipmentComments");
    } catch (e) {
      print("Error in getIssuesEquipmentComments() - $e");
    }
    notifyListeners();
  }

  // Función para traer los nombre de los issues de FluidsCheck
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
              nameIssue: "engine_oil",
              dateAddedOpen: issue.dateAdded!);

          if (!validateElementAtList(fluidCheckRR, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheck");
            fluidCheckRR.add(newIssueComments);
          }
        }
        if (issue.transmission == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Transmission",
              dateAddedOpen: issue.dateAdded!);

          if (!validateElementAtList(fluidCheckRR, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheck");
            fluidCheckRR.add(newIssueComments);
          }
        }
        if (issue.coolant == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Coolant",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(fluidCheckRR, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheck");
            fluidCheckRR.add(newIssueComments);
          }
        }
        if (issue.powerSteering == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Power Steering",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(fluidCheckRR, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheck");
            fluidCheckRR.add(newIssueComments);
          }
        }
        if (issue.dieselExhaustFluid == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Diesel Exhaust Fluid",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(fluidCheckRR, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheck");
            fluidCheckRR.add(newIssueComments);
          }
        }
        if (issue.windshieldWasherFluid == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Windshield Washer Fluid ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(fluidCheckRR, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheck");
            fluidCheckRR.add(newIssueComments);
          }
        }
      }
      // FluidCheckD
      for (FluidCheck issue in issueFluidCheckD) {
        if (issue.engineOil == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Engine Oil",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(fluidCheckDD, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckDD");
            fluidCheckDD.add(newIssueComments);
          }
        }
        if (issue.transmission == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Transmission",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(fluidCheckDD, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckDD");
            fluidCheckDD.add(newIssueComments);
          }
        }
        if (issue.coolant == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Coolant",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(fluidCheckDD, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckDD");
            fluidCheckDD.add(newIssueComments);
          }
        }
        if (issue.powerSteering == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Power Steering",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(fluidCheckDD, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckDD");
            fluidCheckDD.add(newIssueComments);
          }
        }
        if (issue.dieselExhaustFluid == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Diesel Exhaust Fluid",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(fluidCheckDD, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckDD");
            fluidCheckDD.add(newIssueComments);
          }
        }
        if (issue.windshieldWasherFluid == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Windshield Washer Fluid ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(fluidCheckDD, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckDD");
            fluidCheckDD.add(newIssueComments);
          }
        }
      }
      print("Entro a getIssuesFluidCheck");
      print("FluidcHeckRR : ${fluidCheckRR.length}");
    } catch (e) {
      print("Error in getIssuesFluidCheck() - $e");
    }

    notifyListeners();
  }

  // Función para traer los nombre de los issues de FluidsCheck
  Future<void> getIssuesFluidCheckClosed(IssuesXUser issuesXUser) async {
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

      issueFluidCheckRClosed = (res as List<dynamic>)
          .map((issueFluidCheckRClosed) =>
              FluidCheck.fromJson(jsonEncode(issueFluidCheckRClosed)))
          .toList();
      issueFluidCheckDClosed = (resD as List<dynamic>)
          .map((issueFluidCheckDClosed) =>
              FluidCheck.fromJson(jsonEncode(issueFluidCheckDClosed)))
          .toList();

      // FluidCheckR

      for (FluidCheck issue in issueFluidCheckRClosed) {
        if (issue.engineOil == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "engine_oil",
              category: "Fluids Check",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.transmission == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Transmission",
              category: "Fluids Check",
              dateAddedOpen: issue.dateAdded!);

          if (!validateElementAtList(
              listTotalClosedIssue, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.coolant == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Coolant",
              category: "Fluids Check",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.powerSteering == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Power Steering",
              category: "Fluids Check",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.dieselExhaustFluid == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Diesel Exhaust Fluid",
              category: "Fluids Check",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.windshieldWasherFluid == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Windshield Washer Fluid ",
              category: "Fluids Check",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
      }
      // FluidCheckD
      for (FluidCheck issue in issueFluidCheckDClosed) {
        if (issue.engineOil == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              category: "Fluids Check",
              nameIssue: "Engine Oil",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.transmission == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              category: "Fluids Check",
              nameIssue: "Transmission",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.coolant == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              category: "Fluids Check",
              nameIssue: "Coolant",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.powerSteering == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Power Steering",
              category: "Fluids Check",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.dieselExhaustFluid == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Diesel Exhaust Fluid",
              category: "Fluids Check",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.windshieldWasherFluid == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idFluidsCheck!,
              nameIssue: "Windshield Washer Fluid ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(
              listTotalClosedIssue, issue.idFluidsCheck!)) {
            print("Nuevo elemento Agregado FluidCheckDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
      }
      print("Entro a getIssuesFluidCheckClosed");
    } catch (e) {
      print("Error in getIssuesFluidCheckClosed() - $e");
    }

    notifyListeners();
  }

  // Función para traer los comentarios de los issues de FluidsCheck
  Future<void> getIssuesFluidsCheckComments(
      IssueOpenclose issueOpenClose) async {
    // clearListgetIssues();
    print("Entro a getIssuesFluidsCheckComments");
    try {
      if (issueOpenClose.nameIssue == "engine_oil") {
        final res = await supabaseCtrlV
            .from('fluids_check')
            .select('engine_oil_comments, engine_oil_image, date_added')
            .eq('id_fluids_check', issueOpenClose.idIssue);
        final resEngineOil = res as List<dynamic>;
        if (resEngineOil.isNotEmpty) {
          List<String> listImage =
              resEngineOil.first['engine_oil_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resEngineOil.first['engine_oil_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resEngineOil.first['date_added']));
          print(
              "getIssuesFluidsCheckComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Transmission") {
        final res = await supabaseCtrlV
            .from('fluids_check')
            .select('transmission_comments, transmission_image, date_added')
            .eq('id_fluids_check', issueOpenClose.idIssue);
        final resTransmission = res as List<dynamic>;
        if (resTransmission.isNotEmpty) {
          List<String> listImage =
              resTransmission.first['transmission_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resTransmission.first['transmission_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resTransmission.first['date_added']));
          print(
              "getIssuesFluidsCheckComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Coolant") {
        final res = await supabaseCtrlV
            .from('fluids_check')
            .select('coolant_comments, coolant_image, date_added')
            .eq('id_fluids_check', issueOpenClose.idIssue);
        final resCoolant = res as List<dynamic>;
        if (resCoolant.isNotEmpty) {
          List<String> listImage =
              resCoolant.first['coolant_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resCoolant.first['coolant_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resCoolant.first['date_added']));
          print(
              "getIssuesFluidsCheckComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Power Steering") {
        final res = await supabaseCtrlV
            .from('fluids_check')
            .select('power_steering_comments, power_steering_image, date_added')
            .eq('id_fluids_check', issueOpenClose.idIssue);
        final resPowerS = res as List<dynamic>;
        if (resPowerS.isNotEmpty) {
          List<String> listImage =
              resPowerS.first['power_steering_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resPowerS.first['power_steering_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resPowerS.first['date_added']));
          print(
              "getIssuesFluidsCheckComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Diesel Exhaust Fluid") {
        final res = await supabaseCtrlV
            .from('fluids_check')
            .select(
                'diesel_exhaust_fluid_comments, diesel_exhaust_fluid_image, date_added')
            .eq('id_fluids_check', issueOpenClose.idIssue);
        final resDieselExF = res as List<dynamic>;
        if (resDieselExF.isNotEmpty) {
          List<String> listImage = resDieselExF
              .first['diesel_exhaust_fluid_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              nameIssue: issueOpenClose.nameIssue,
              idIssue: issueOpenClose.idIssue,
              comments: resDieselExF.first['diesel_exhaust_fluid_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resDieselExF.first['date_added']));
          print(
              "getIssuesFluidsCheckComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Windshield Washer Fluid ") {
        final res = await supabaseCtrlV
            .from('fluids_check')
            .select(
                'windshield_washer_fluid_comments, windshield_washer_fluid_image, date_added')
            .eq('id_fluids_check', issueOpenClose.idIssue);
        final resWindshieldWF = res as List<dynamic>;
        if (resWindshieldWF.isNotEmpty) {
          List<String> listImage = resWindshieldWF
              .first['windshield_washer_fluid_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments:
                  resWindshieldWF.first['windshield_washer_fluid_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resWindshieldWF.first['date_added']));
          print(
              "getIssuesFluidsCheckComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      print("Entro a getIssuesFluidsCheckComments");
    } catch (e) {
      print("Error in getIssuesFluidsCheckComments() - $e");
    }
    notifyListeners();
  }

  // Función para traer los nombre de los issues de Lights
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

      // print(res);

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
          if (!validateElementAtList(lightsRR, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRR");
            lightsRR.add(newIssueComments);
          }
        }
        if (issue.brakeLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Brake Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsRR, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRR");
            lightsRR.add(newIssueComments);
          }
        }
        if (issue.reverseLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Reverse Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsRR, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRR");
            lightsRR.add(newIssueComments);
          }
        }
        if (issue.warningLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Warning Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsRR, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRR");
            lightsRR.add(newIssueComments);
          }
        }
        if (issue.turnSignals == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Turn Signals",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsRR, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRR");
            lightsRR.add(newIssueComments);
          }
        }
        if (issue.the4WayFlashers == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "4 way Flashers ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsRR, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRR");
            lightsRR.add(newIssueComments);
          }
        }
        if (issue.dashLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Dash Lights ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsRR, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRR");
            lightsRR.add(newIssueComments);
          }
        }
        if (issue.strobeLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Strobe Lights ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsRR, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRR");
            lightsRR.add(newIssueComments);
          }
        }
        if (issue.cabRoofLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Cab Roof Lights ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsRR, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRR");
            lightsRR.add(newIssueComments);
          }
        }
        if (issue.clearanceLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Clearance Lights ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsRR, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRR");
            lightsRR.add(newIssueComments);
          }
        }
      }
      // LightsD
      for (Lights issue in issueLightsD) {
        if (issue.headlights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Headlights",
              dateAddedOpen: issue.dateAdded!);

          if (!validateElementAtList(lightsDD, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDD");
            lightsDD.add(newIssueComments);
          }
        }
        if (issue.brakeLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Brake Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsDD, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDD");
            lightsDD.add(newIssueComments);
          }
        }
        if (issue.reverseLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Reverse Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsDD, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDD");
            lightsDD.add(newIssueComments);
          }
        }
        if (issue.warningLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Warning Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsDD, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDD");
            lightsDD.add(newIssueComments);
          }
        }
        if (issue.turnSignals == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Turn Signals",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsDD, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDD");
            lightsDD.add(newIssueComments);
          }
        }
        if (issue.the4WayFlashers == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "4 way Flashers ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsDD, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDD");
            lightsDD.add(newIssueComments);
          }
        }
        if (issue.dashLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Dash Lights ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsDD, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDD");
            lightsDD.add(newIssueComments);
          }
        }
        if (issue.strobeLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Strobe Lights ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsDD, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDD");
            lightsDD.add(newIssueComments);
          }
        }
        if (issue.cabRoofLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Cab Roof Lights ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsDD, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDD");
            lightsDD.add(newIssueComments);
          }
        }
        if (issue.clearanceLights == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Clearance Lights ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(lightsDD, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDD");
            lightsDD.add(newIssueComments);
          }
        }
      }

      print("Entro a getIssuesLights");
    } catch (e) {
      print("Error in getIssuesLights() - $e");
    }

    notifyListeners();
  }

  // Función para traer los nombre de los issues de Lights Closed
  Future<void> getIssuesLightsClosed(IssuesXUser issuesXUser) async {
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

      // print(res);

      issueLightsRClosed = (res as List<dynamic>)
          .map((issueLightsRClosed) =>
              Lights.fromJson(jsonEncode(issueLightsRClosed)))
          .toList();
      issueLightsDClosed = (resD as List<dynamic>)
          .map((issueLightsDClosed) =>
              Lights.fromJson(jsonEncode(issueLightsDClosed)))
          .toList();

      // LightsR
      for (Lights issue in issueLightsRClosed) {
        if (issue.headlights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Headlights",
              category: "Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.brakeLights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Brake Lights",
              category: "Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.reverseLights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Reverse Lights",
              category: "Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.warningLights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              category: "Lights",
              nameIssue: "Warning Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.turnSignals == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Turn Signals",
              category: "Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.the4WayFlashers == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              category: "Lights",
              nameIssue: "4 way Flashers ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.dashLights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Dash Lights ",
              category: "Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.strobeLights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Strobe Lights ",
              category: "Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.cabRoofLights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Cab Roof Lights ",
              category: "Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.clearanceLights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              category: "Lights",
              nameIssue: "Clearance Lights ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
      }
      // LightsD
      for (Lights issue in issueLightsDClosed) {
        if (issue.headlights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Headlights",
              category: "Lights",
              dateAddedOpen: issue.dateAdded!);

          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.brakeLights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Brake Lights",
              category: "Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.reverseLights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              category: "Lights",
              nameIssue: "Reverse Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.warningLights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Warning Lights",
              category: "Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.turnSignals == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              nameIssue: "Turn Signals",
              category: "Lights",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.the4WayFlashers == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              category: "Lights",
              nameIssue: "4 way Flashers ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.dashLights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              category: "Lights",
              nameIssue: "Dash Lights ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.strobeLights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              category: "Lights",
              nameIssue: "Strobe Lights ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.cabRoofLights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              category: "Lights",
              nameIssue: "Cab Roof Lights ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.clearanceLights == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idLights!,
              category: "Lights",
              nameIssue: "Clearance Lights ",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idLights!)) {
            print("Nuevo elemento Agregado lightsDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
      }

      print("Entro a getIssuesLightsClosed");
    } catch (e) {
      print("Error in getIssuesLightsClosed() - $e");
    }

    notifyListeners();
  }

  // Función para traer los comentarios de los issues de Lights
  Future<void> getIssuesLightsComments(IssueOpenclose issueOpenClose) async {
    // clearListgetIssues();
    print("Entro a getIssuesLightsComments");
    try {
      if (issueOpenClose.nameIssue == "Headlights") {
        final res = await supabaseCtrlV
            .from('lights')
            .select('headlights_comments, headlights_image, date_added')
            .eq('id_lights', issueOpenClose.idIssue);
        final resLights = res as List<dynamic>;
        if (resLights.isNotEmpty) {
          List<String> listImage =
              resLights.first['headlights_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              nameIssue: issueOpenClose.nameIssue,
              idIssue: issueOpenClose.idIssue,
              comments: resLights.first['headlights_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resLights.first['date_added']));
          print("getIssuesLightsComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Brake Lights") {
        final res = await supabaseCtrlV
            .from('lights')
            .select('brake_lights_comments, brake_lights_image, date_added')
            .eq('id_lights', issueOpenClose.idIssue);
        final resBrakeLights = res as List<dynamic>;
        if (resBrakeLights.isNotEmpty) {
          List<String> listImage =
              resBrakeLights.first['brake_lights_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resBrakeLights.first['brake_lights_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resBrakeLights.first['date_added']));
          print("getIssuesLightsComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Reverse Lights") {
        final res = await supabaseCtrlV
            .from('lights')
            .select('reverse_lights_comments, reverse_lights_image, date_added')
            .eq('id_lights', issueOpenClose.idIssue);
        final resReverseL = res as List<dynamic>;
        if (resReverseL.isNotEmpty) {
          List<String> listImage =
              resReverseL.first['reverse_lights_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resReverseL.first['reverse_lights_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resReverseL.first['date_added']));
          print("getIssuesLightsComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Warning Lights") {
        final res = await supabaseCtrlV
            .from('lights')
            .select('warning_lights_comments, warning_lights_image, date_added')
            .eq('id_lights', issueOpenClose.idIssue);
        final resWarningL = res as List<dynamic>;
        if (resWarningL.isNotEmpty) {
          List<String> listImage =
              resWarningL.first['warning_lights_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resWarningL.first['warning_lights_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resWarningL.first['date_added']));
          print("getIssuesLightsComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Turn Signals") {
        final res = await supabaseCtrlV
            .from('lights')
            .select('turn_signals_comments, turn_signals_image, date_added')
            .eq('id_lights', issueOpenClose.idIssue);
        final resTurnS = res as List<dynamic>;
        if (resTurnS.isNotEmpty) {
          List<String> listImage =
              resTurnS.first['turn_signals_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resTurnS.first['turn_signals_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resTurnS.first['date_added']));
          print("getIssuesLightsComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "4 way Flashers ") {
        final res = await supabaseCtrlV
            .from('lights')
            .select('4_way_flashers_comments, 4_way_flashers_image, date_added')
            .eq('id_lights', issueOpenClose.idIssue);
        final res4WayF = res as List<dynamic>;
        if (res4WayF.isNotEmpty) {
          List<String> listImage =
              res4WayF.first['4_way_flashers_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: res4WayF.first['4_way_flashers_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(res4WayF.first['date_added']));
          print("getIssuesLightsComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Dash Lights ") {
        final res = await supabaseCtrlV
            .from('lights')
            .select('dash_lights_comments, dash_lights_image, date_added')
            .eq('id_lights', issueOpenClose.idIssue);
        final resDashL = res as List<dynamic>;
        if (resDashL.isNotEmpty) {
          List<String> listImage =
              resDashL.first['dash_lights_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resDashL.first['dash_lights_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resDashL.first['date_added']));
          print("getIssuesLightsComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Strobe Lights ") {
        final res = await supabaseCtrlV
            .from('lights')
            .select('strobe_lights_comments, strobe_lights_image, date_added')
            .eq('id_lights', issueOpenClose.idIssue);
        final resStrobeL = res as List<dynamic>;
        if (resStrobeL.isNotEmpty) {
          List<String> listImage =
              resStrobeL.first['strobe_lights_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resStrobeL.first['strobe_lights_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resStrobeL.first['date_added']));
          print("getIssuesLightsComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Cab Roof Lights ") {
        final res = await supabaseCtrlV
            .from('lights')
            .select(
                'cab_roof_lights_comments, cab_roof_lights_image, date_added')
            .eq('id_lights', issueOpenClose.idIssue);
        final resCabRoofL = res as List<dynamic>;
        if (resCabRoofL.isNotEmpty) {
          List<String> listImage =
              resCabRoofL.first['cab_roof_lights_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              nameIssue: issueOpenClose.nameIssue,
              idIssue: issueOpenClose.idIssue,
              comments: resCabRoofL.first['cab_roof_lights_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resCabRoofL.first['date_added']));
          print("getIssuesLightsComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Clearance Lights ") {
        final res = await supabaseCtrlV
            .from('lights')
            .select(
                'clearance_lights_comments, clearance_lights_image, date_added')
            .eq('id_lights', issueOpenClose.idIssue);
        final resClearanceL = res as List<dynamic>;
        if (resClearanceL.isNotEmpty) {
          List<String> listImage = resClearanceL.first['clearance_lights_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resClearanceL.first['clearance_lights_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resClearanceL.first['date_added']));
          print("getIssuesLightsComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }
      print("Entro a getIssuesLightsComments");
    } catch (e) {
      print("Error in getIssuesLightsComments() - $e");
    }
    notifyListeners();
  }

  // Función para traer los nombre de los issues de Measures
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

      // print(res);

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
          if (!validateElementAtList(measureRR, issue.idMeasure!)) {
            print("Nuevo elemento Agregado measureRR");
            measureRR.add(newIssueComments);
          }
        }

        IssueOpenclose newIssueComments = IssueOpenclose(
            idIssue: issue.idMeasure!,
            nameIssue: "Mileage",
            percentage: issue.mileage.toString(),
            dateAddedOpen: issue.dateAdded!);
        if (!validateElementAtList(measureRR, issue.idMeasure!)) {
          print("Nuevo elemento Agregado measureRR");
          measureRR.add(newIssueComments);
        }
      }
      // MeasureD
      for (Measure issue in issueMeasureD) {
        if (issue.gas != "") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idMeasure!,
              nameIssue: "Gas",
              percentage: issue.gas,
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(measureDD, issue.idMeasure!)) {
            print("Nuevo elemento Agregado measureDD");
            measureDD.add(newIssueComments);
          }
        }

        IssueOpenclose newIssueComments = IssueOpenclose(
            idIssue: issue.idMeasure!,
            nameIssue: "Mileage",
            percentage: issue.mileage.toString(),
            dateAddedOpen: issue.dateAdded!);
        if (!validateElementAtList(measureDD, issue.idMeasure!)) {
          print("Nuevo elemento Agregado measureDD");
          measureDD.add(newIssueComments);
        }
      }

      print("Entro a getIssueMeasure");
    } catch (e) {
      print("Error in getIssueMeasure() - $e");
    }

    notifyListeners();
  }

  // Función para traer los nombre de los issues de Measures Closed
  Future<void> getIssuesMeasureClosed(IssuesXUser issuesXUser) async {
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

      issueMeasureRClosed = (res as List<dynamic>)
          .map((issueMeasureRClosed) =>
              Measure.fromJson(jsonEncode(issueMeasureRClosed)))
          .toList();
      issueMeasureDClosed = (resD as List<dynamic>)
          .map((issueMeasureDClosed) =>
              Measure.fromJson(jsonEncode(issueMeasureDClosed)))
          .toList();

      // MeasureR
      for (Measure issue in issueMeasureRClosed) {
        if (issue.gas != "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idMeasure!,
              nameIssue: "Gas",
              percentage: issue.gas,
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(measureRR, issue.idMeasure!)) {
            print("Nuevo elemento Agregado measureRR");
            measureRR.add(newIssueComments);
          }
        }

        IssueOpenclose newIssueComments = IssueOpenclose(
            idIssue: issue.idMeasure!,
            nameIssue: "Mileage",
            percentage: issue.mileage.toString(),
            dateAddedOpen: issue.dateAdded!);
        if (!validateElementAtList(measureRR, issue.idMeasure!)) {
          print("Nuevo elemento Agregado measureRR");
          measureRR.add(newIssueComments);
        }
      }
      // MeasureD
      for (Measure issue in issueMeasureDClosed) {
        if (issue.gas != "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idMeasure!,
              nameIssue: "Gas",
              percentage: issue.gas,
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(measureDD, issue.idMeasure!)) {
            print("Nuevo elemento Agregado measureDD");
            measureDD.add(newIssueComments);
          }
        }

        IssueOpenclose newIssueComments = IssueOpenclose(
            idIssue: issue.idMeasure!,
            nameIssue: "Mileage",
            percentage: issue.mileage.toString(),
            dateAddedOpen: issue.dateAdded!);
        if (!validateElementAtList(measureDD, issue.idMeasure!)) {
          print("Nuevo elemento Agregado measureDD");
          measureDD.add(newIssueComments);
        }
      }

      print("Entro a getIssueMeasure");
    } catch (e) {
      print("Error in getIssueMeasure() - $e");
    }

    notifyListeners();
  }

  // Función para traer los comentarios de los issues de Measures
  Future<void> getIssuesMeasuresComments(IssueOpenclose issueOpenClose) async {
    // clearListgetIssues();
    print("Entro a getIssuesMeasuresComments");
    try {
      if (issueOpenClose.nameIssue == "Gas") {
        final res = await supabaseCtrlV
            .from('measures')
            .select('gas_comments, gas_image, date_added')
            .eq('id_measure', issueOpenClose.idIssue);
        final resGas = res as List<dynamic>;
        if (resGas.isNotEmpty) {
          List<String> listImage =
              resGas.first['gas_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resGas.first['gas_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resGas.first['date_added']));
          print(
              "getIssuesMeasuresComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Mileage") {
        final res = await supabaseCtrlV
            .from('measures')
            .select('mileage_comments, mileage_image, date_added')
            .eq('id_measure', issueOpenClose.idIssue);
        final resMileage = res as List<dynamic>;
        if (resMileage.isNotEmpty) {
          List<String> listImage =
              resMileage.first['gas_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resMileage.first['gas_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resMileage.first['date_added']));
          print(
              "getIssuesMeasuresComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      print("Entro a getIssuesMeasuresComments");
    } catch (e) {
      print("Error in getIssuesMeasuresComments() - $e");
    }
    notifyListeners();
  }

  // Función para traer los nombre de los issues de Security
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

      // print(res);

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
          if (!validateElementAtList(securityRR, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityRR");
            securityRR.add(newIssueComments);
          }
        }
        if (issue.triangleReflectors == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Triangle Reflectors",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(securityRR, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityRR");
            securityRR.add(newIssueComments);
          }
        }
        if (issue.wheelChocks == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Wheel Chocks",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(securityRR, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityRR");
            securityRR.add(newIssueComments);
          }
        }
        if (issue.fireExtinguisher == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Fire Extinguisher",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(securityRR, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityRR");
            securityRR.add(newIssueComments);
          }
        }
        if (issue.firstAidKitSafetyVest == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "First Aid Kit Safety Vest",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(securityRR, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityRR");
            securityRR.add(newIssueComments);
          }
        }
        if (issue.backUpAlarm == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Back Up Alarm",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(securityRR, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityRR");
            securityRR.add(newIssueComments);
          }
        }
      }

      // SecurityR
      for (Security issue in issueSecurityD) {
        if (issue.rtaMagnet == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "RTA Magnet",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(securityDD, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityDD");
            securityDD.add(newIssueComments);
          }
        }
        if (issue.triangleReflectors == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Triangle Reflectors",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(securityDD, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityDD");
            securityDD.add(newIssueComments);
          }
        }
        if (issue.wheelChocks == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Wheel Chocks",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(securityDD, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityDD");
            securityDD.add(newIssueComments);
          }
        }
        if (issue.fireExtinguisher == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Fire Extinguisher",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(securityDD, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityDD");
            securityDD.add(newIssueComments);
          }
        }
        if (issue.firstAidKitSafetyVest == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "First Aid Kit Safety Vest",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(securityDD, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityDD");
            securityDD.add(newIssueComments);
          }
        }
        if (issue.backUpAlarm == "Bad") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Back Up Alarm",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(securityDD, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityDD");
            securityDD.add(newIssueComments);
          }
        }
      }

      print("Entro a getIssuesSecuurity");
    } catch (e) {
      print("Error in getIssuesSecuurity() - $e");
    }

    notifyListeners();
  }

  // Funcion de getIssueSecurity issue cerrado
  Future<void> getIssueSecurityClosed(IssuesXUser issuesXUser) async {
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

      // print(res);

      issueSecurityRClosed = (res as List<dynamic>)
          .map((issueSecurityRClosed) =>
              Security.fromJson(jsonEncode(issueSecurityRClosed)))
          .toList();
      issueSecurityDClosed = (resD as List<dynamic>)
          .map((issueSecurityDClosed) =>
              Security.fromJson(jsonEncode(issueSecurityDClosed)))
          .toList();

      // SecurityR
      for (Security issue in issueSecurityRClosed) {
        if (issue.rtaMagnet == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "RTA Magnet",
              category: "Security",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.triangleReflectors == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Triangle Reflectors",
              category: "Security",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.wheelChocks == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Wheel Chocks",
              category: "Security",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.fireExtinguisher == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Fire Extinguisher",
              category: "Security",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.firstAidKitSafetyVest == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "First Aid Kit Safety Vest",
              category: "Security",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.backUpAlarm == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Back Up Alarm",
              category: "Security",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityRRClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
      }

      // SecurityR
      for (Security issue in issueSecurityDClosed) {
        if (issue.rtaMagnet == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "RTA Magnet",
              category: "Security",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.triangleReflectors == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Triangle Reflectors",
              category: "Security",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.wheelChocks == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Wheel Chocks",
              category: "Security",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.fireExtinguisher == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Fire Extinguisher",
              category: "Security",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.firstAidKitSafetyVest == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "First Aid Kit Safety Vest",
              category: "Security",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
        if (issue.backUpAlarm == "Closed") {
          IssueOpenclose newIssueComments = IssueOpenclose(
              idIssue: issue.idSecurity!,
              nameIssue: "Back Up Alarm",
              category: "Security",
              dateAddedOpen: issue.dateAdded!);
          if (!validateElementAtList(listTotalClosedIssue, issue.idSecurity!)) {
            print("Nuevo elemento Agregado securityDDClosed");
            listTotalClosedIssue.add(newIssueComments);
          }
        }
      }

      print("Entro a getIssuesSecurityClosed");
    } catch (e) {
      print("Error in getIssuesSecurityClosed() - $e");
    }

    notifyListeners();
  }

  // Función para traer los comentarios de los issues de Security
  Future<void> getIssuesSecurityComments(IssueOpenclose issueOpenClose) async {
    // clearListgetIssues();
    print("Entro a getIssuesSecurityComments");
    try {
      if (issueOpenClose.nameIssue == "RTA Magnet") {
        final res = await supabaseCtrlV
            .from('security')
            .select('rta_magnet_comments, rta_magnet_image, date_added')
            .eq('id_security', issueOpenClose.idIssue);
        final resRTAM = res as List<dynamic>;
        if (resRTAM.isNotEmpty) {
          List<String> listImage =
              resRTAM.first['rta_magnet_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resRTAM.first['rta_magnet_commnets'],
              listImages: listImage,
              dateAdded: DateTime.parse(resRTAM.first['date_added']));
          print(
              "getIssuesSecurityComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Triangle Reflectors") {
        final res = await supabaseCtrlV
            .from('security')
            .select(
                'triangle_reflectors_comments, triangle_reflectors_image, date_added')
            .eq('id_security', issueOpenClose.idIssue);
        final resTriangleR = res as List<dynamic>;
        if (resTriangleR.isNotEmpty) {
          List<String> listImage = resTriangleR
              .first['triangle_reflectors_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resTriangleR.first['triangle_reflectors_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resTriangleR.first['date_added']));
          print(
              "getIssuesSecurityComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Wheel Chocks") {
        final res = await supabaseCtrlV
            .from('security')
            .select('wheel_chocks_comments, wheel_chocks_image, date_added')
            .eq('id_security', issueOpenClose.idIssue);
        final resWheelChocks = res as List<dynamic>;
        if (resWheelChocks.isNotEmpty) {
          List<String> listImage =
              resWheelChocks.first['wheel_chocks_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              nameIssue: issueOpenClose.nameIssue,
              idIssue: issueOpenClose.idIssue,
              comments: resWheelChocks.first['wheel_chocks_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resWheelChocks.first['date_added']));
          print(
              "getIssuesSecurityComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Fire Extinguisher") {
        final res = await supabaseCtrlV
            .from('security')
            .select(
                'fire_extinguisher_comments, fire_extinguisher_image, date_added')
            .eq('id_security', issueOpenClose.idIssue);
        final resFireExting = res as List<dynamic>;
        if (resFireExting.isNotEmpty) {
          List<String> listImage = resFireExting
              .first['fire_extinguisher_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resFireExting.first['fire_extinguisher_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resFireExting.first['date_added']));
          print(
              "getIssuesSecurityComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "First Aid Kit Safety Vest") {
        final res = await supabaseCtrlV
            .from('security')
            .select(
                'first_aid_kit_safety_vest_comments, first_aid_kit_safety_vest_image, date_added')
            .eq('id_security', issueOpenClose.idIssue);
        final resFirstAidKSV = res as List<dynamic>;
        if (resFirstAidKSV.isNotEmpty) {
          List<String> listImage = resFirstAidKSV
              .first['first_aid_kit_safety_vest_image']
              .toString()
              .split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments:
                  resFirstAidKSV.first['first_aid_kit_safety_vest_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resFirstAidKSV.first['date_added']));
          print(
              "getIssuesSecurityComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      if (issueOpenClose.nameIssue == "Back Up Alarm") {
        final res = await supabaseCtrlV
            .from('security')
            .select('back_up_alarm_comments, back_up_alarm_image, date_added')
            .eq('id_security', issueOpenClose.idIssue);
        final resBackUpAlarm = res as List<dynamic>;
        if (resBackUpAlarm.isNotEmpty) {
          List<String> listImage =
              resBackUpAlarm.first['back_up_alarm_image'].toString().split('|');

          registroIssueComments = IssuesComments(
              idIssue: issueOpenClose.idIssue,
              nameIssue: issueOpenClose.nameIssue,
              comments: resBackUpAlarm.first['back_up_alarm_comments'],
              listImages: listImage,
              dateAdded: DateTime.parse(resBackUpAlarm.first['date_added']));
          print(
              "getIssuesSecurityComments: ${registroIssueComments!.nameIssue}");
        }
        notifyListeners();
      }

      print("Entro a getIssuesSecurityComments");
    } catch (e) {
      print("Error in getIssuesSecurityComments() - $e");
    }
    notifyListeners();
  }

  // Limpiar las listas
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
}
