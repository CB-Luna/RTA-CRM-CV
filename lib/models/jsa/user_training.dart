import 'dart:convert';

class UserTraining {
  final String name;
  final String lastName;
  final int sequentialId;
  final String userProfileId;
  final Role role;
  final Company company;
  final List<IndividualTraining> trainings;

  UserTraining({
    required this.name,
    required this.lastName,
    required this.sequentialId,
    required this.userProfileId,
    required this.role,
    required this.company,
    required this.trainings,
  });

  factory UserTraining.fromJson(String str) =>
      UserTraining.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserTraining.fromMap(Map<String, dynamic> json) => UserTraining(
        name: json["name"],
        lastName: json["last_name"],
        sequentialId: json["sequential_id"],
        userProfileId: json["user_profile_id"],
        role: Role.fromMap(json["role"]),
        company: Company.fromMap(json["company"]),
        trainings: List<IndividualTraining>.from(
            json["trainings"].map((x) => IndividualTraining.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "last_name": lastName,
        "sequential_id": sequentialId,
        "user_profile_id": userProfileId,
        "role": role.toMap(),
        "company": company.toMap(),
        "trainings": List<dynamic>.from(trainings.map((x) => x.toMap())),
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

class IndividualTraining {
  final int idTraining;
  final String userFk;
  final String title;
  final String docname;
  final DateTime creationDate;
  final DateTime expirationDate;
  final Status status;

  IndividualTraining({
    required this.idTraining,
    required this.userFk,
    required this.title,
    required this.docname,
    required this.creationDate,
    required this.expirationDate,
    required this.status,
  });

  factory IndividualTraining.fromJson(String str) =>
      IndividualTraining.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IndividualTraining.fromMap(Map<String, dynamic> json) =>
      IndividualTraining(
        idTraining: json["id_training"],
        userFk: json["user_fk"],
        title: json["title"],
        docname: json["doc_name"],
        creationDate: DateTime.parse(json["creation_date"]),
        expirationDate: DateTime.parse(json["expiration_date"]),
        status: Status.fromMap(json["status"]),
      );

  Map<String, dynamic> toMap() => {
        "id_training": idTraining,
        "user_fk": userFk,
        "title": title,
        "doc_name": docname,
        "creation_date": creationDate.toIso8601String(),
        "expiration_date": expirationDate.toIso8601String(),
        "status": status.toMap(),
      };
}
