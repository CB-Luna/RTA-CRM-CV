// To parse this JSON data, do
//
//     final catDataCenters = catDataCentersFromJson(jsonString);

import 'dart:convert';

class GenericCat {
  int? id;
  DateTime? createdAt;
  String? name;
  bool? visible;

  GenericCat({
    this.id,
    this.createdAt,
    this.name,
    this.visible,
  });

  factory GenericCat.fromRawJson(String str) => GenericCat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GenericCat.fromJson(Map<String, dynamic> json) => GenericCat(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        name: json["name"],
        visible: json["visible"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "name": name,
        "visible": visible,
      };
}
