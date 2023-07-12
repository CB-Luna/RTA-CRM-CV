import 'dart:convert';

import 'package:rta_crm_cv/models/services.dart';

class ServicesApi {
  ServicesApi({
    required this.idVehicle,
    required this.idService,
    required this.serviceDate,
    required this.servicex,
    //this.vehicle,
  });

  int idService;
  int? idVehicle;
  DateTime serviceDate;
  Services servicex;

  factory ServicesApi.fromJson(String str) =>
      ServicesApi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServicesApi.fromMap(Map<String, dynamic> json) => ServicesApi(
        idVehicle: json["id_vehicle_fk"],
        idService: json["id_vehicle_services"],
        serviceDate: DateTime.parse(json["service_date"]),
        servicex: Services.fromJson(jsonEncode(json['service'])),
      );

  Map<String, dynamic> toMap() => {
        "service": servicex.toMap(),
        "service_date": serviceDate.toIso8601String(),
        "id_vehicle_services": idService,
        "id_vehicle_fk": idVehicle,
      };
}
