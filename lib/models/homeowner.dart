import 'dart:convert';

class HouseownerList {
    final int? id;
    final DateTime? createdAt;
    final DateTime? dueDate;
    final int? idStatus;
    final String? document;

    HouseownerList({
        this.id,
        this.createdAt,
        this.dueDate,
        this.idStatus,
        this.document,
    });

    factory HouseownerList.fromJson(String str) => HouseownerList.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory HouseownerList.fromMap(Map<String, dynamic> json) => HouseownerList(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        idStatus: json["id_status"],
        document: json["document"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "due_date": dueDate?.toIso8601String(),
        "id_status": idStatus,
        "document": document,
    };
}
