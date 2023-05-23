import 'dart:convert';

import 'package:rta_crm_cv/models/models.dart';

class Usuario {
  Usuario({
    required this.id,
    required this.sequentialId,
    required this.email,
    required this.name,
    required this.middleName,
    required this.lastName,
    required this.homePhone,
    required this.mobilePhone,
    required this.address,
    this.image,
    required this.birthDate,
    required this.role,
    required this.company,
  });

  String id;
  int sequentialId;
  String email;
  String name;
  String? middleName;
  String lastName;
  String homePhone;
  String mobilePhone;
  String address;
  String? image;
  DateTime birthDate;
  Role role;
  Company company;

  String get fullName => '$name $lastName';

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  factory Usuario.fromMap(Map<String, dynamic> json) {
    Usuario usuario = Usuario(
      id: json["id"],
      sequentialId: json['sequential_id'],
      email: json["email"],
      name: json['name'],
      middleName: json['middle_name'],
      lastName: json['last_name'],
      homePhone: json['home_phone'],
      mobilePhone: json['mobile_phone'],
      address: json['address'],
      image: json['image'],
      birthDate: DateTime.parse(json['birthdate']),
      role: Role.fromJson(jsonEncode(json['role'])),
      company: Company.fromJson(jsonEncode(json['company'])),
    );
    return usuario;
  }
}
