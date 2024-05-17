import 'dart:convert';

class Training {
  final Employee employee;
  final int idTraining;
  final String title;
  final String userfk;
  final String docname;
  final DateTime creationDate;
  final DateTime expirationDate;
  final Status status;

  Training({
    required this.employee,
    required this.idTraining,
    required this.title,
    required this.userfk,
    required this.docname,
    required this.creationDate,
    required this.expirationDate,
    required this.status,
  });

  factory Training.fromJson(String str) => Training.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Training.fromMap(Map<String, dynamic> json) => Training(
        employee: Employee.fromMap(json["employee"]),
        idTraining: json["id_training"],
        title: json["title"],
        userfk: json["user_fk"],
        docname: json["doc_name"],
        creationDate: DateTime.parse(json["creation_date"]),
        expirationDate: DateTime.parse(json["expiration_date"]),
        status: Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "employee": employee.toMap(),
        "id_training": idTraining,
        "title": title,
        "user_fk": userfk,
        "doc_name": docname,
        "creation_date": creationDate.toIso8601String(),
        "expiration_date": expirationDate.toIso8601String(),
        "status": status.toMap(),
      };
}

class Employee {
  final String name;
  final String lastName;
  final int sequentialId;
  final String userProfileId;
  final Role role;
  final Company company;

  Employee({
    required this.name,
    required this.lastName,
    required this.sequentialId,
    required this.userProfileId,
    required this.role,
    required this.company,
  });

  factory Employee.fromJson(String str) => Employee.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        name: json["name"],
        lastName: json["last_name"],
        sequentialId: json["sequential_id"],
        userProfileId: json["user_profile_id"],
        role: Role.fromMap(json["role"]),
        company: Company.fromMap(json["company"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "last_name": lastName,
        "sequential_id": sequentialId,
        "user_profile_id": userProfileId,
        "role": role.toMap(),
        "company": company.toMap(),
      };
}

class Status {
  final int id;
  final String name;

  Status({
    required this.id,
    required this.name,
  });

  factory Status.fromJson(String str) => Status.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Status.fromMap(Map<String, dynamic> json) => Status(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class Company {
  final int id;
  final String name;

  Company({
    required this.id,
    required this.name,
  });

  factory Company.fromJson(String str) => Company.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Company.fromMap(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class Role {
  final int idRole;
  final String name;
  final String application;

  Role({
    required this.idRole,
    required this.name,
    required this.application,
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
