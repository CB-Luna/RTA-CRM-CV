import 'dart:convert';

class VehicleApi {
  VehicleApi({
    required this.licensePlates,
    required this.idVehicle,
  });

  int idVehicle;
  String licensePlates;

  factory VehicleApi.fromJson(String str) =>
      VehicleApi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VehicleApi.fromMap(Map<String, dynamic> json) => VehicleApi(
        licensePlates: json["license Plates"],
        idVehicle: json["id_vehicle"],
      );

  Map<String, dynamic> toMap() => {
        "license Plates": licensePlates,
        "id_vehicle": idVehicle,
      };
}
