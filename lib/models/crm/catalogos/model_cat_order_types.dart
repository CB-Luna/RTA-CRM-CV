// To parse this JSON data, do
//
//     final catOrderTypes = catOrderTypesFromJson(jsonString);

import 'dart:convert';

class CatOrderTypes {
  int? id;
  DateTime? createdAt;
  String? name;
  bool? visible;

  CatOrderTypes({
    this.id,
    this.createdAt,
    this.name,
    this.visible,
  });

  factory CatOrderTypes.fromRawJson(String str) => CatOrderTypes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CatOrderTypes.fromJson(Map<String, dynamic> json) => CatOrderTypes(
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
