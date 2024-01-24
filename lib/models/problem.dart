import 'dart:convert';

class Problem {
  final int idProblem;
  final DateTime createdAt;
  final String? problem;
  final bool resolved;
  final String vehicleStatus;
  final int? idVehicleFk;

  Problem({
    required this.idProblem,
    required this.createdAt,
    this.problem,
    required this.resolved,
    required this.vehicleStatus,
    this.idVehicleFk,
  });

  factory Problem.fromJson(String str) => Problem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Problem.fromMap(Map<String, dynamic> json) => Problem(
        idProblem: json["id_problem"],
        createdAt: DateTime.parse(json["created_at"]),
        problem: json["problem"],
        resolved: json["resolved"],
        vehicleStatus: json["vehicle_status"],
        idVehicleFk: json["id_vehicle_fk"],
      );

  Map<String, dynamic> toMap() => {
        "id_problem": idProblem,
        "created_at": createdAt.toIso8601String(),
        "problem": problem,
        "resolved": resolved,
        "vehicle_status": vehicleStatus,
        "id_vehicle_fk": idVehicleFk,
      };
}
