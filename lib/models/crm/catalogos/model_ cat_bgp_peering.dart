// To parse this JSON data, do
//
//     final catBgpPeering = catBgpPeeringFromJson(jsonString);

import 'dart:convert';

class CatBgpPeering {
  int? id;
  DateTime? createdAt;
  String? name;
  bool? visible;

  CatBgpPeering({
    this.id,
    this.createdAt,
    this.name,
    this.visible,
  });

  factory CatBgpPeering.fromRawJson(String str) => CatBgpPeering.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CatBgpPeering.fromJson(Map<String, dynamic> json) => CatBgpPeering(
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
