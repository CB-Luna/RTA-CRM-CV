import 'dart:convert';

class JsaDocumentList {
  int? jsaSignedId;
  String? name;
  String? lastName;
  String? docName;
  Employee? employee;
  DateTime? createdAt;
  DocumentStatus? documentStatus;

  JsaDocumentList({
    this.jsaSignedId,
    this.name,
    this.lastName,
    this.docName,
    this.employee,
    this.createdAt,
    this.documentStatus,
  });

  factory JsaDocumentList.fromJson(String str) =>
      JsaDocumentList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JsaDocumentList.fromMap(Map<String, dynamic> json) => JsaDocumentList(
        jsaSignedId: json["jsa_signed_id"],
        name: json["name"],
        lastName: json["last_name"],
        docName: json["doc_name"],
        employee: json["employee"] == null
            ? null
            : Employee.fromMap(json["employee"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        documentStatus: json["document_status"] == null
            ? null
            : DocumentStatus.fromMap(json["document_status"]),
      );

  Map<String, dynamic> toMap() => {
        "jsa_signed_id": jsaSignedId,
        "name": name,
        "last_name": lastName,
        "doc_name": docName,
        "employee": employee?.toMap(),
        "created_at": createdAt?.toIso8601String(),
        "document_status": documentStatus?.toMap(),
      };
}

class DocumentStatus {
  int? id;
  String? status;

  DocumentStatus({
    this.id,
    this.status,
  });

  factory DocumentStatus.fromJson(String str) =>
      DocumentStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DocumentStatus.fromMap(Map<String, dynamic> json) => DocumentStatus(
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
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
