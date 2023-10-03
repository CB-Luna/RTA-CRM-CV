import 'dart:convert';

class ModelX2V2QuotesStatus {
  int? id;
  DateTime? createdAt;
  String? name;
  bool? visible;

  ModelX2V2QuotesStatus({
    this.id,
    this.createdAt,
    this.name,
    this.visible,
  });

  factory ModelX2V2QuotesStatus.fromJson(String str) => ModelX2V2QuotesStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelX2V2QuotesStatus.fromMap(Map<String, dynamic> json) => ModelX2V2QuotesStatus(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        name: json["name"],
        visible: json["visible"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "name": name,
        "visible": visible,
      };
}
