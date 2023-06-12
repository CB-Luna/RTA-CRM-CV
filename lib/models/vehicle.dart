import 'dart:convert';

import 'package:rta_crm_cv/models/company_api.dart';
import 'package:rta_crm_cv/models/status_api.dart';

class Vehicle {
  Vehicle({
    required this.idVehicle,
    required this.make,
    required this.model,
    required this.year,
    required this.vin,
    required this.licesensePlates,
    required this.motor,
    this.color,
    required this.image,
    required this.status,
    required this.company,
    required this.dateAdded,
    required this.oilChangeDue,
    required this.registrationDue,
    required this.renewalInsDue,
  });

  int idVehicle;
  String make;
  String model;
  String year;
  String vin;
  String licesensePlates;
  String motor;
  String? color;
  String image;
  DateTime dateAdded;
  DateTime oilChangeDue;
  DateTime registrationDue;
  DateTime renewalInsDue;
  StatusApi status;
  CompanyApi company;

  factory Vehicle.fromJson(String str) => Vehicle.fromMap(json.decode(str));

  factory Vehicle.fromMap(Map<String, dynamic> json) => Vehicle(
      idVehicle: json["id_vehicle"],
      make: json["make"],
      model: json["model"],
      year: json["year"],
      vin: json["vin"],
      licesensePlates: json["license_plates"],
      motor: json["motor"],
      color: json["color"],
      image: json["image"],
      status: StatusApi.fromJson(jsonEncode(json['status'])),
      company: CompanyApi.fromJson(jsonEncode(json['company'])),
      dateAdded: DateTime.parse(json["date_added"]),
      oilChangeDue: DateTime.parse(json["oil_change_due"]),
      registrationDue: DateTime.parse(json["radiator_fluid_change"]),
      renewalInsDue: DateTime.parse(json["transmission_fluid_change"]));

  Map<String, dynamic> toMap() => {
        "id_vehicle": idVehicle,
        "make": make,
        "model": model,
        "year": year,
        "vin": vin,
        "license_plates": licesensePlates,
        "motor": motor,
        "color": color,
        "image": image,
        "status": status.toMap(),
        "company": company.toMap(),
        "date_added": dateAdded.toIso8601String(),
        "oil_change_due": oilChangeDue.toIso8601String(),
        "radiator_fluid_change": registrationDue.toIso8601String(),
        "transmission_fluid_change": renewalInsDue.toIso8601String()
      };
}
