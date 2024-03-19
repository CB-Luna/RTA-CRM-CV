import 'dart:convert';

class Jsa {
  Employee? employee;
  int? id;
  String? task;
  DateTime? createdAt;
  String? title;
  int? companyFk;
  String? docName;
  String? company;
  String? userFk;
  List<Step>? steps;
  List<Usersjsa> usersjsa;
  String? status;
  int? idStatus;

  Jsa({
    this.employee,
    this.id,
    this.task,
    this.createdAt,
    this.title,
    this.companyFk,
    this.docName,
    this.company,
    this.userFk,
    this.steps,
    required this.usersjsa,
    this.status,
    this.idStatus,
  });

  factory Jsa.fromJson(String str) => Jsa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Jsa.fromMap(Map<String, dynamic> json) => Jsa(
        employee: json["employee"] == null
            ? null
            : Employee.fromMap(json["employee"]),
        id: json["id"],
        task: json["task"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        title: json["title"],
        companyFk: json["company_fk"],
        docName: json["doc_name"],
        company: json["company"],
        userFk: json["user_fk"],
        steps: json["steps"] == null
            ? []
            : List<Step>.from(json["steps"]!.map((x) => Step.fromMap(x))),
        usersjsa: json["usersjsa"] == null
            ? []
            : List<Usersjsa>.from(
                json["usersjsa"]!.map((x) => Usersjsa.fromMap(x))),
        status: json["status"],
        idStatus: json["id_status"],
      );

  Map<String, dynamic> toMap() => {
        "employee": employee?.toMap(),
        "id": id,
        "task": task,
        "created_at": createdAt?.toIso8601String(),
        "title": title,
        "company_fk": companyFk,
        "doc_name": docName,
        "company": company,
        "user_fk": userFk,
        "steps": steps == null
            ? []
            : List<dynamic>.from(steps!.map((x) => x.toMap())),
        "usersjsa": List<dynamic>.from(usersjsa.map((x) => x.toMap())),
        "status": status,
        "id_status": idStatus,
      };
}

class Employee {
  String? name;
  String? lastName;
  int? sequentialId;
  String? userProfileId;

  Employee({
    this.name,
    this.lastName,
    this.sequentialId,
    this.userProfileId,
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
  String? title;
  int? riskLevel;
  int? controlLevel;
  int? stepId;

  Step({
    this.title,
    this.riskLevel,
    this.controlLevel,
    this.stepId,
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

class Usersjsa {
  String? name;
  String? userFk;
  int? jsaFk;
  int? idStatus;
  String? docName;
  String? lastName;
  Status? status;
  Role? role;

  Usersjsa({
    this.name,
    this.userFk,
    this.jsaFk,
    this.idStatus,
    this.docName,
    this.lastName,
    this.status,
    this.role,
  });

  factory Usersjsa.fromJson(String str) => Usersjsa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usersjsa.fromMap(Map<String, dynamic> json) => Usersjsa(
        name: json["name"],
        userFk: json["user_fk"],
        jsaFk: json["jsa_fk"],
        idStatus: json["id_status"],
        docName: json["doc_name"],
        lastName: json["last_name"],
        status: json["status"] == null ? null : Status.fromMap(json["status"]),
        role: json["role"] == null ? null : Role.fromMap(json["role"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "user_fk": userFk,
        "jsa_fk": jsaFk,
        "id_status": idStatus,
        "doc_name": docName,
        "last_name": lastName,
        "status": status?.toMap(),
        "role": role?.toMap(),
      };
}

class Role {
  int? idRole;
  String? name;
  String? application;

  Role({
    this.idRole,
    this.name,
    this.application,
  });

  factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Role.fromMap(Map<String, dynamic> json) => Role(
        idRole: json["id_role"],
        name: json["name"],
        application: json["application"],
      );

  Map<String, dynamic> toMap() => {
        "id_role": idRole,
        "name": name,
        "application": application,
      };
}

class Status {
  int? idStatus;
  String? status;

  Status({
    this.idStatus,
    this.status,
  });

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        idStatus: json["id_status"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id_status": idStatus,
        "status": status,
      };
}
