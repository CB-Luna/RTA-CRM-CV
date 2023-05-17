import 'dart:convert';

import 'package:rta_crm_cv/models/models.dart';

class Usuario {
  Usuario({
    required this.id,
    required this.sequentialId,
    required this.email,
    required this.name,
    required this.lastName,
    this.image,
    required this.phone,
    required this.country,
    required this.role,
  });

  String id;
  int sequentialId;
  String email;
  String name;
  String lastName;
  String? image;
  String phone;
  Country country;
  Role role;

  String get fullName => '$name $lastName';

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  factory Usuario.fromMap(Map<String, dynamic> json) {
    Usuario usuario = Usuario(
      id: json["id"],
      sequentialId: json['sequential_id'],
      email: json["email"],
      name: json['name'],
      lastName: json['last_name'],
      image: json['image'],
      phone: json['phone'],
      country: Country.fromJson(jsonEncode(json['country'])),
      role: Role.fromJson(jsonEncode(json['role'])),
    );
    return usuario;
  }
}
