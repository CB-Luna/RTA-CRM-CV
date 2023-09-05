// To parse this JSON data, do
//
//     final catCircuitTypes = catCircuitTypesFromJson(jsonString);

import 'dart:convert';

class CatCircuitTypes {
  int? id;
  DateTime? createdAt;
  String? name;
  bool? visible;
  Parameters? parameters;

  CatCircuitTypes({
    this.id,
    this.createdAt,
    this.name,
    this.visible,
    this.parameters,
  });

  factory CatCircuitTypes.fromRawJson(String str) => CatCircuitTypes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CatCircuitTypes.fromJson(Map<String, dynamic> json) => CatCircuitTypes(
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
  bool? cir;
  bool? portSize;
  bool? evcod;

  Parameters({
    this.cir,
    this.portSize,
    this.evcod,
  });

  factory Parameters.fromRawJson(String str) => Parameters.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
        cir: json["cir"],
        portSize: json["port_size"],
        evcod: json["evcod"],
      );

  Map<String, dynamic> toJson() => {
        "cir": cir,
        "port_size": portSize,
        "evcod": evcod,
      };
}
