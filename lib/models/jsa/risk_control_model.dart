import 'dart:convert';

class RiskControlModel {
  int stepFk;
  String name;
  DateTime createdAt;
  int id;

  RiskControlModel({
    required this.stepFk,
    required this.name,
    required this.createdAt,
    required this.id,
  });

  factory RiskControlModel.fromJson(String str) =>
      RiskControlModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RiskControlModel.fromMap(Map<String, dynamic> json) =>
      RiskControlModel(
        stepFk: json["step_fk"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "step_fk": stepFk,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "id": id,
      };
}
