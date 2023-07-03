import 'dart:convert';

class Services {
  Services({
    required this.service,
    required this.idService,
  });

  int idService;
  String service;

  factory Services.fromJson(String str) => Services.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Services.fromMap(Map<String, dynamic> json) => Services(
        service: json["service"],
        idService: json["id_service"],
      );

  Map<String, dynamic> toMap() => {
        "service": service,
        "id_service": idService,
      };
}
