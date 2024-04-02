import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../../providers/jsa/jsa_provider.dart';

class JsaGeneralInfo {
  String? company;
  String? title;
  String? taskName;
  List<JsaStepsJson>? jsaStepsJson;
  List<TeamMembers>? teamMembers;

  JsaGeneralInfo({
    this.company,
    this.title,
    this.taskName,
    this.jsaStepsJson,
    this.teamMembers,
  });

  factory JsaGeneralInfo.fromJson(String str) =>
      JsaGeneralInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JsaGeneralInfo.fromMap(Map<String, dynamic> json) => JsaGeneralInfo(
        company: json["company"],
        title: json["title"],
        taskName: json["taskname"],
        jsaStepsJson: json["jsaStepsJson"] == null
            ? []
            : List<JsaStepsJson>.from(
                json["jsaStepsJson"]!.map((x) => JsaStepsJson.fromMap(x))),
        teamMembers: json["teamMembers"] == null
            ? []
            : List<TeamMembers>.from(
                json["teamMembers"]!.map((x) => TeamMembers.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'company': company,
        'title': title,
        'taskName': taskName,
        'jsaSteps': jsaStepsJson,
      };
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

  JsaStepsJson(
      {required this.title,
      required this.description,
      required this.risks,
      required this.controls,
      this.id,
      this.riskLevel,
      this.riskColor,
      this.controlColor,
      this.controlLevel});

  factory JsaStepsJson.fromJson(String str) =>
      JsaStepsJson.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JsaStepsJson.fromMap(Map<String, dynamic> json) => JsaStepsJson(
        title: json["title"],
        description: json["description"],
        riskLevel: json["risk_level"],
        riskColor: json["risk_color"],
        controlColor: json["control_color"],
        controlLevel: json["control_level"],
        risks: json["risks"] == null
            ? []
            : List<Risks>.from(json["steps"]!.map((x) => Risks.fromMap(x))),
        controls: json["control"] == null
            ? []
            : List<Control>.from(json["steps"]!.map((x) => Control.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'id': uuid.v1(),
        'description': description,
        'risks': risks,
        'controls': controls,
      };
}

class Risks {
  String? title;

  Risks({this.title});

  factory Risks.fromJson(String str) => Risks.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Risks.fromMap(Map<String, dynamic> json) => Risks(
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
      };
}

class Control {
  String? title;
  String? controlLevel;
  Color? color;
  Control({this.title, this.controlLevel, this.color});

  factory Control.fromJson(String str) => Control.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Control.fromMap(Map<String, dynamic> json) => Control(
      title: json["title"],
      controlLevel: json["control_level"],
      color: json["color"]);

  Map<String, dynamic> toMap() =>
      {"title": title, "control_level": controlLevel, "color": color};
}

class TeamMembers {
  String? name;
  String? role;
  // String? picString;
  String? pic;
  String? id;

  TeamMembers({this.name, this.role, this.id, this.pic});

  factory TeamMembers.fromJson(String str) =>
      TeamMembers.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TeamMembers.fromMap(Map<String, dynamic> json) => TeamMembers(
      name: json["name"], role: json["role"], pic: json["pic"], id: json["id"]);

  Map<String, dynamic> toMap() => {
        'name': name,
        'role': role,
        'id': id,
        'pic': pic,
      };
}
