import 'dart:convert';

class DataJSAView {
  Employee employee;
  int id;
  String task;
  DateTime createdAt;
  String title;
  int companyFk;
  String company;
  String userFk;
  List<UserJSA> usersJSA;
  List<Step> steps;
  String status;

  DataJSAView({
    required this.employee,
    required this.id,
    required this.task,
    required this.createdAt,
    required this.title,
    required this.companyFk,
    required this.company,
    required this.userFk,
    required this.usersJSA,
    required this.steps,
    required this.status,
  });

  factory DataJSAView.fromJson(String str) =>
      DataJSAView.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataJSAView.fromMap(Map<String, dynamic> json) => DataJSAView(
        employee: Employee.fromMap(json["employee"]),
        id: json["id"],
        task: json["task"],
        createdAt: DateTime.parse(json["created_at"]),
        title: json["title"],
        companyFk: json["company_fk"],
        company: json["company"],
        userFk: json["user_fk"],
        usersJSA:
            List<UserJSA>.from(json["usersjsa"].map((x) => UserJSA.fromMap(x))),
        steps: List<Step>.from(json["steps"].map((x) => Step.fromMap(x))),
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "employee": employee.toMap(),
        "id": id,
        "task": task,
        "created_at": createdAt.toIso8601String(),
        "title": title,
        "company_fk": companyFk,
        "company": company,
        "user_fk": userFk,
        "steps": List<dynamic>.from(steps.map((x) => x.toMap())),
        "usersjsa": List<dynamic>.from(usersJSA.map((x) => x.toMap())),
        "status": status,
      };
}

class Employee {
  String name;
  String lastName;
  int sequentialId;
  String userProfileId;

  Employee({
    required this.name,
    required this.lastName,
    required this.sequentialId,
    required this.userProfileId,
  });

  factory Employee.fromJson(String str) => Employee.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        name: json["name"],
        lastName: json["last_name"],
        sequentialId: json["sequential_id"],
        userProfileId: json["user_profile_id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "last_name": lastName,
        "sequential_id": sequentialId,
        "user_profile_id": userProfileId,
      };
}

class Step {
  String title;
  int riskLevel;
  int controlLevel;
  int stepId;

  Step({
    required this.title,
    required this.riskLevel,
    required this.controlLevel,
    required this.stepId,
  });

  factory Step.fromJson(String str) => Step.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Step.fromMap(Map<String, dynamic> json) => Step(
        title: json["title"],
        riskLevel: json["risk_level"],
        controlLevel: json["control_level"],
        stepId: json["step_id"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "risk_level": riskLevel,
        "control_level": controlLevel,
        "step_id": stepId,
      };
}

class UserJSA {
  String name;
  String lastName;
  int jsaFk;
  String userFk;

  UserJSA({
    required this.name,
    required this.lastName,
    required this.jsaFk,
    required this.userFk,
  });

  factory UserJSA.fromJson(String str) => UserJSA.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserJSA.fromMap(Map<String, dynamic> json) => UserJSA(
        name: json["name"],
        lastName: json["last_name"],
        jsaFk: json["jsa_fk"],
        userFk: json["user_fk"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "last_name": lastName,
        "jsa_fk": jsaFk,
        "user_fk": userFk,
      };
}

class RetrievedJsa {
  String title;
  String task;
  String createdAt;
  int id;
  int membersSigned;
  int membersTotal;

  RetrievedJsa({
    required this.title,
    required this.task,
    required this.createdAt,
    required this.id,
    required this.membersSigned,
    required this.membersTotal,
  });

  factory RetrievedJsa.fromJson(String str) =>
      RetrievedJsa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RetrievedJsa.fromMap(Map<String, dynamic> json) => RetrievedJsa(
        title: json["title"],
        task: json["task"],
        createdAt: json["created_at"],
        id: json["id"],
        membersSigned: json["signed"],
        membersTotal: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "task": task,
        "createdAt": createdAt,
        "id": id,
        "signed": membersSigned,
        "total": membersTotal,
      };
}
