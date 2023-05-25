import 'dart:convert';

import 'company_api.dart';
import 'user_profile_api.dart';

class Monitory {
  Monitory(
      {required this.idControlForm,
      required this.idVehicle,
      required this.dateAdded,
      required this.employee,
      required this.typeForm,
      required this.vin,
      required this.licesensePlates,
      required this.company,
      required this.gas,
      required this.mileage});

  int idControlForm;
  int idVehicle;
  DateTime dateAdded;
  Employee employee;
  bool typeForm;
  String vin;
  String licesensePlates;
  CompanyApi company;
  String gas;
  int mileage;

  factory Monitory.fromJson(String str) => Monitory.fromMap(json.decode(str));

  factory Monitory.fromMap(Map<String, dynamic> json) => Monitory(
      idControlForm: json['id_control_form'],
      idVehicle: json["id_vehicle"],
      dateAdded: DateTime.parse(json["date_added"]),
      employee: Employee.fromJson(jsonEncode(json['employee'])),
      typeForm: json["type_form"],
      vin: json["vin"],
      licesensePlates: json["license_plates"],
      company: CompanyApi.fromJson(jsonEncode(json['company'])),
      gas: json['gas'],
      mileage: json['mileage']);

  Map<String, dynamic> toMap() => {
        "id_control_form": idControlForm,
        "id_vehicle": idVehicle,
        "date_added": dateAdded.toIso8601String(),
        "employee": employee.toMap(),
        "type_form": typeForm,
        "vin": vin,
        "license_plates": licesensePlates,
        "company": company.toMap(),
        "gas": gas,
        "mileage": mileage,
      };
}
