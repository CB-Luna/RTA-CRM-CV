import 'dart:convert';

class SafetyBriefing {
  final int id;
  final String title;
  final String preparedBy;
  final DateTime date;
  final String issue;
  final String background;
  final String contact;
  final String recommendation;
  final String docName;
  final SafetyBriefingStatus status;
  final List<Usersjsa> usersjsa;

  SafetyBriefing({
    required this.id,
    required this.title,
    required this.preparedBy,
    required this.date,
    required this.issue,
    required this.background,
    required this.contact,
    required this.recommendation,
    required this.docName,
    required this.status,
    required this.usersjsa,
  });

  factory SafetyBriefing.fromJson(String str) =>
      SafetyBriefing.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SafetyBriefing.fromMap(Map<String, dynamic> json) => SafetyBriefing(
        id: json["id"],
        title: json["title"],
        preparedBy: json["prepared_by"],
        date: DateTime.parse(json["date"]),
        issue: json["issue"],
        background: json["background"],
        contact: json["contact"],
        recommendation: json["recommendation"],
        docName: json["doc_name"],
        status: SafetyBriefingStatus.fromMap(json["status"]),
        usersjsa: List<Usersjsa>.from(
            json["usersjsa"].map((x) => Usersjsa.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "prepared_by": preparedBy,
        "date": date.toIso8601String(),
        "issue": issue,
        "background": background,
        "contact": contact,
        "recommendation": recommendation,
        "doc_name": docName,
        "status": status.toMap(),
        "usersjsa": List<dynamic>.from(usersjsa.map((x) => x.toMap())),
      };
}

class SafetyBriefingStatus {
  final int id;
  final String name;

  SafetyBriefingStatus({
    required this.id,
    required this.name,
  });

  factory SafetyBriefingStatus.fromJson(String str) =>
      SafetyBriefingStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SafetyBriefingStatus.fromMap(Map<String, dynamic> json) =>
      SafetyBriefingStatus(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class Usersjsa {
  final int id;
  final String name;
  final String userFk;
  final int safetyBriefingFk;
  final String lastName;
  final UsersjsaStatus status;
  final Role role;

  Usersjsa({
    required this.id,
    required this.name,
    required this.userFk,
    required this.safetyBriefingFk,
    required this.lastName,
    required this.status,
    required this.role,
  });

  factory Usersjsa.fromJson(String str) => Usersjsa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usersjsa.fromMap(Map<String, dynamic> json) => Usersjsa(
        id: json["id"],
        name: json["name"],
        userFk: json["user_fk"],
        safetyBriefingFk: json["safety_briefing_fk"],
        lastName: json["last_name"],
        status: UsersjsaStatus.fromMap(json["status"]),
        role: Role.fromMap(json["role"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "user_fk": userFk,
        "safety_briefing_fk": safetyBriefingFk,
        "last_name": lastName,
        "status": status.toMap(),
        "role": role.toMap(),
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

class UsersjsaStatus {
  final int idStatus;
  final String status;

  UsersjsaStatus({
    required this.idStatus,
    required this.status,
  });

  factory UsersjsaStatus.fromJson(String str) =>
      UsersjsaStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsersjsaStatus.fromMap(Map<String, dynamic> json) => UsersjsaStatus(
        idStatus: json["id_status"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id_status": idStatus,
        "status": status,
      };
}

// class SafetyBriefing {
//   final int id;
//   final String title;
//   final DateTime date;
//   final String issue;
//   final String background;
//   final String analisis;
//   final String recommendation;
//   final String docName;
//   final List<Usersjsa> usersjsa;

//   SafetyBriefing({
//     required this.id,
//     required this.title,
//     required this.date,
//     required this.issue,
//     required this.background,
//     required this.analisis,
//     required this.recommendation,
//     required this.docName,
//     required this.usersjsa,
//   });

//   factory SafetyBriefing.fromJson(String str) =>
//       SafetyBriefing.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory SafetyBriefing.fromMap(Map<String, dynamic> json) => SafetyBriefing(
//         id: json["id"],
//         title: json["title"],
//         date: DateTime.parse(json["date"]),
//         issue: json["issue"],
//         background: json["background"],
//         analisis: json["analisis"],
//         recommendation: json["recommendation"],
//         docName: json["doc_name"],
//         usersjsa: List<Usersjsa>.from(
//             json["usersjsa"].map((x) => Usersjsa.fromMap(x))),
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "title": title,
//         "date": date.toIso8601String(),
//         "issue": issue,
//         "background": background,
//         "analisis": analisis,
//         "recommendation": recommendation,
//         "doc_name": docName,
//         "usersjsa": List<dynamic>.from(usersjsa.map((x) => x.toMap())),
//       };
// }

// class Usersjsa {
//   final String name;
//   final String userFk;
//   final int safetyBriefingFk;
//   final String lastName;
//   final dynamic docName;
//   final Role role;

//   Usersjsa({
//     required this.name,
//     required this.userFk,
//     required this.safetyBriefingFk,
//     required this.lastName,
//     required this.docName,
//     required this.role,
//   });

//   factory Usersjsa.fromJson(String str) => Usersjsa.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Usersjsa.fromMap(Map<String, dynamic> json) => Usersjsa(
//         name: json["name"],
//         userFk: json["user_fk"],
//         safetyBriefingFk: json["safety_briefing_fk"],
//         lastName: json["last_name"],
//         docName: json["doc_name"],
//         role: Role.fromMap(json["role"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "name": name,
//         "user_fk": userFk,
//         "safety_briefing_fk": safetyBriefingFk,
//         "last_name": lastName,
//         "doc_name": docName,
//         "role": role.toMap(),
//       };
// }

// class Role {
//   final int idRole;
//   final String name;
//   final String application;

//   Role({
//     required this.idRole,
//     required this.name,
//     required this.application,
//   });

//   factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Role.fromMap(Map<String, dynamic> json) => Role(
//         idRole: json["id_role"],
//         name: json["name"],
//         application: json["application"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id_role": idRole,
//         "name": name,
//         "application": application,
//       };
// }
