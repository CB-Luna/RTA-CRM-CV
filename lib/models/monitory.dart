import 'dart:convert';

import 'package:rta_crm_cv/models/vehicle.dart';

import 'company_api.dart';
import 'user_profile_api.dart';

class Monitory {
  Monitory(
      {required this.idControlForm,
      required this.idVehicle,
      required this.dateAddedR,
       this.dateAddedD,
      required this.employee,
      required this.vin,
      required this.licesensePlates,
      required this.company,
      required this.gasR,
       this.gasD,
      required this.mileageR,
       this.mileageD,
      required this.vehicle
      });

  int idControlForm;
  int idVehicle;
  DateTime dateAddedR;
  DateTime? dateAddedD;
  Employee employee;
  String vin;
  String licesensePlates;
  CompanyApi company;
  String gasR;
  String? gasD;
  int mileageR;
  int? mileageD;
  Vehicle vehicle;

  factory Monitory.fromJson(String str) => Monitory.fromMap(json.decode(str));

  factory Monitory.fromMap(Map<String, dynamic> json) => Monitory(
      idControlForm: json['id_control_form'],
      idVehicle: json["id_vehicle"],
      dateAddedR: DateTime.parse(json["date_added_r"]),
      dateAddedD: json["date_added_d"] == null ? null: DateTime.parse(json["date_added_d"]),
      employee: Employee.fromJson(jsonEncode(json['employee'])),
      vin: json["vin"],
      licesensePlates: json["license_plates"],
      company: CompanyApi.fromJson(jsonEncode(json['company'])),
      gasR: json['gas_r'],
      gasD: json['gas_d'],
      mileageR: json['mileage_r'],
      mileageD: json['mileage_d'],
      vehicle: Vehicle.fromJson(jsonEncode(json['vehicle'])),
      );

  Map<String, dynamic> toMap() => {
        "id_control_form": idControlForm,
        "id_vehicle": idVehicle,
        "date_added_r": dateAddedR.toIso8601String(),
        "date_added_d": dateAddedD?.toIso8601String(),
        "employee": employee.toMap(),
        "vin": vin,
        "license_plates": licesensePlates,
        "company": company.toMap(),
        "gas_r": gasR,
        "gas_d": gasD,
        "mileage_r": mileageR,
        "mileage_d": mileageD,
        "vehicle": vehicle.toMap(),
      };
}
