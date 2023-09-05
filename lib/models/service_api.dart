import 'dart:convert';

import 'package:rta_crm_cv/models/services.dart';
import 'package:rta_crm_cv/models/vehicle_api.dart';

class ServicesApi {
  ServicesApi({
    required this.idVehicle,
    required this.idService,
    this.serviceDate,
    required this.completed,
    required this.servicex,
    required this.vehicle,
  });

  int idService;
  int idVehicle;
  DateTime? serviceDate;
  bool completed;
  Services servicex;
  VehicleApi vehicle;

  factory ServicesApi.fromJson(String str) =>
      ServicesApi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServicesApi.fromMap(Map<String, dynamic> json) => ServicesApi(
        idVehicle: json["id_vehicle_fk"],
        idService: json["id_vehicle_services"],
        serviceDate: json["service_date"] == null
            ? null
            : DateTime.parse(json["service_date"]),
        completed: json["completed"],
        vehicle: VehicleApi.fromJson(jsonEncode(json['vehicle'])),
        servicex: Services.fromJson(jsonEncode(json['service'])),
      );

  Map<String, dynamic> toMap() => {
        "service": servicex.toMap(),
        "service_date": serviceDate?.toIso8601String(),
        "id_vehicle_services": idService,
        "id_vehicle_fk": idVehicle,
        "completed": completed,
        "vehicle": vehicle.toMap(),
      };
}
