// To parse this JSON data, do
//
//     final catDataCenters = catDataCentersFromJson(jsonString);

import 'dart:convert';

class CatDataCenters {
  int? id;
  DateTime? createdAt;
  String? name;
  bool? visible;

  CatDataCenters({
    this.id,
    this.createdAt,
    this.name,
    this.visible,
  });

  factory CatDataCenters.fromRawJson(String str) => CatDataCenters.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CatDataCenters.fromJson(Map<String, dynamic> json) => CatDataCenters(
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
