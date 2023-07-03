import 'dart:convert';
import 'dart:developer';

import 'package:rta_crm_cv/models/services.dart';

class ServicesApi {
  ServicesApi(
      {required this.idVehicle,
      required this.idService,
      required this.serviceDate,
      required this.servicex,
      this.nextDate});

  int idService;
  int? idVehicle;
  DateTime serviceDate;
  DateTime? nextDate;
  Services servicex;

  factory ServicesApi.fromJson(String str) =>
      ServicesApi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ServicesApi.fromMap(Map<String, dynamic> json) => ServicesApi(
        idVehicle: json["id_vehicle_fk"],
        idService: json["id_service"],
        serviceDate: json["service_date"],
        servicex: Services.fromJson(jsonEncode(json['service'])),
        nextDate: json["nextDate"],
      );

  Map<String, dynamic> toMap() => {
        "service": servicex,
        "service_date": serviceDate,
        "next_date": nextDate,
        "id_service": idService,
        "id_vehicle_fk": idVehicle
      };
}
