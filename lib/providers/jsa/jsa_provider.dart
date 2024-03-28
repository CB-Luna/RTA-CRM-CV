import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class JsaProvider extends ChangeNotifier {
  JsaGeneralInfo? jsaGeneralInfo;

  JsaGeneralInfo get jsa => jsaGeneralInfo!;

  void createJsaGeneralInfo(String? company, String? title, String? taskName) {
    print("JsaCreation");
    List<JsaStepsJson> jsaStepsJson = [];
    jsaGeneralInfo = JsaGeneralInfo(company, title, taskName, jsaStepsJson);
    print(jsaGeneralInfo!.toJson());
    print("JsaCreation End");
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
}

class JsaGeneralInfo {
  String? company;
  String? title;
  String? taskName;
  List<JsaStepsJson>? jsaStepsJson;
  JsaGeneralInfo(
    this.company,
    this.title,
    this.taskName,
    this.jsaStepsJson,
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
