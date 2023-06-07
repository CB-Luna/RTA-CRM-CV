import 'dart:convert';

import 'package:rta_crm_cv/models/models.dart';

class User {
  User({
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
    required this.state,
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
  State state;

  String get fullName => '$name $lastName';

  bool get isAdmin => role.roleName == 'Admin';

  bool get isCRM => role.roleName == 'Sales' || role.roleName == 'Finance' || role.roleName == 'Sen. Exec.' || role.roleName == 'Operations' || role.roleName == 'Admin';
  bool get isSales => role.roleName == 'Sales';
  bool get isFinance => role.roleName == 'Finance';
  bool get isSenExec => role.roleName == 'Sen. Exec.';
  bool get isOpperations => role.roleName == 'Operations';

  bool get isCV => role.roleName == 'Admin' || role.roleName == 'Admin';

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  factory User.fromMap(Map<String, dynamic> json) {
    User usuario = User(
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
      state: State.fromJson(jsonEncode(json['state'])),
    );
    return usuario;
  }
}
