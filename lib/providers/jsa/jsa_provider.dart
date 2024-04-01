import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/doc_create_final_document.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/doc_create_task_risk_control.dart';
import 'package:uuid/uuid.dart';

import '../../models/user.dart';
import '../../pages/jsa/doc_creation/doc_create_resume.dart';
import '../../pages/jsa/doc_creation/doc_creation_card.dart';

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

  void createJsaGeneralInfo(String? company, String? title, String? taskName) {
    print("JsaCreation");
    List<JsaStepsJson> jsaStepsJson = [];
    List<TeamMembers> teamMembers = [];

    jsaGeneralInfo =
        JsaGeneralInfo(company, title, taskName, jsaStepsJson, teamMembers);
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
    jsaGeneralInfo!.jsaStepsJson!.add(JsaStepsJson(title, description, [], [],
        uuid.v1(), '', Colors.transparent, Colors.transparent, ''));
    print('Step Name: ${title}');
    print('Step Description: ${description}');

    notifyListeners();
  }

  void addJsaRisks(String title, String stepId) {
    jsaGeneralInfo!.jsaStepsJson!.forEach((element) {
      if (element.id == stepId) {
        element.risks.add(Risks(title));
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
    switch (riskLevel) {
      case '0.0':
      case '1.0':
      case '2.0':
      case '3.0':
        color = Colors.green;
        break;

      case '4.0':
      case '5.0':
      case '6.0':
        color = Colors.yellow;
        break;

      case '7.0':
      case '8.0':
      case '9.0':
        color = Colors.red.shade200;
        break;
    }
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
      case '0.0':
      case '1.0':
      case '2.0':
      case '3.0':
        color = Colors.green;
        break;

      case '4.0':
      case '5.0':
      case '6.0':
        color = Colors.yellow;
        break;

      case '7.0':
      case '8.0':
      case '9.0':
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
        element.controls.add(Control(title, ''));
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
    jsaGeneralInfo!.teamMembers!.add(teamMember);
    print(
        "El length del jsaGeneralInformation es: ${jsaGeneralInfo!.teamMembers!.length}");
    notifyListeners();
  }

  void deleteTeamMembers(String id) {
    jsaGeneralInfo!.teamMembers!.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}

class JsaGeneralInfo {
  String? company;
  String? title;
  String? taskName;
  List<JsaStepsJson>? jsaStepsJson;
  List<TeamMembers>? teamMembers;

  JsaGeneralInfo(
    this.company,
    this.title,
    this.taskName,
    this.jsaStepsJson,
    this.teamMembers,
  );

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'title': title,
      'taskName': taskName,
      'jsaSteps': jsaStepsJson,
    };
  }
}

class JsaStepsJson {
  String title;
  String description;
  String? riskLevel;
  Color? riskColor;
  Color? controlColor;

  String? controlLevel;
  List<Risks> risks;
  List<Control> controls;
  String? id;

  JsaStepsJson(this.title, this.description, this.risks, this.controls, this.id,
      this.riskLevel, this.riskColor, this.controlColor, this.controlLevel);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': uuid.v1(),
      'description': description,
      'risks': risks,
      'controls': controls,
    };
  }
}

class Risks {
  String? title;

  Risks(this.title);
}

class Control {
  String? title;
  String? controlLevel;
  Color? color;
  Control(this.title, this.controlLevel);
}

class TeamMembers {
  String? name;
  String? role;
  String? picString;
  String? pic;
  String? id;

  TeamMembers(this.name, this.role, this.id, this.picString, [this.pic]);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'id': id,
      'pic': pic,
    };
  }
}
