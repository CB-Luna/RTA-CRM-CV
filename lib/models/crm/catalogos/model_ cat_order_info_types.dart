// To parse this JSON data, do
//
//     final catOrderInfoTypes = catOrderInfoTypesFromJson(jsonString);

import 'dart:convert';

class CatOrderInfoTypes {
  int? id;
  DateTime? createdAt;
  String? name;
  bool? visible;
  Parameters? parameters;

  CatOrderInfoTypes({
    this.id,
    this.createdAt,
    this.name,
    this.visible,
    this.parameters,
  });

  factory CatOrderInfoTypes.fromRawJson(String str) => CatOrderInfoTypes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CatOrderInfoTypes.fromJson(Map<String, dynamic> json) => CatOrderInfoTypes(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        name: json["name"],
        visible: json["visible"],
        parameters: json["parameters"] == null ? null : Parameters.fromJson(json["parameters"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "name": name,
        "visible": visible,
        "parameters": parameters?.toJson(),
      };
}

class Parameters {
  bool? newCircuitId;
  bool? existingCircuitId;

  Parameters({
    this.newCircuitId,
    this.existingCircuitId,
  });

  factory Parameters.fromRawJson(String str) => Parameters.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
        newCircuitId: json["new_circuit_id"],
        existingCircuitId: json["existing_circuit_id"],
      );

  Map<String, dynamic> toJson() => {
        "new_circuit_id": newCircuitId,
        "existing_circuit_id": existingCircuitId,
      };
}
