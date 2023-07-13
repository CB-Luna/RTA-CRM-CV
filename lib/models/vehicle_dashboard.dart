import 'dart:convert';

class VehicleDash {
  VehicleDash({
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
    required this.lastRadiatorFluidChange,
    required this.lastTransmissionFluidChange,
    required this.mileage,
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
  DateTime lastRadiatorFluidChange;
  DateTime lastTransmissionFluidChange;
  int status;
  int company;
  int mileage;
  factory VehicleDash.fromJson(String str) => VehicleDash.fromMap(json.decode(str));

  factory VehicleDash.fromMap(Map<String, dynamic> json) => VehicleDash(
      idVehicle: json["id_vehicle"],
      make: json["make"],
      model: json["model"],
      year: json["year"],
      vin: json["vin"],
      licesensePlates: json["license_plates"],
      motor: json["motor"],
      color: json["color"],
      image: json["image"],
      status: json['id_status_fk'],
      company: json['id_company_fk'],
      dateAdded: DateTime.parse(json["date_added"]),
      oilChangeDue: DateTime.parse(json["oil_change_due"]),
      lastRadiatorFluidChange: DateTime.parse(json["last_radiator_fluid_change"]),
      lastTransmissionFluidChange: DateTime.parse(json["last_transmission_fluid_change"]),
      mileage: json["mileage"]);

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
        "id_status_fk": status,
        "id_company_fk": company,
        "date_added": dateAdded.toIso8601String(),
        "oil_change_due": oilChangeDue.toIso8601String(),
        "last_radiator_fluid_change": lastRadiatorFluidChange.toIso8601String(),
        "last_transmission_fluid_change": lastTransmissionFluidChange.toIso8601String(),
        "mileage": mileage
      };
}
