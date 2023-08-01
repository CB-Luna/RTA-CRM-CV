import 'dart:convert';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/models.dart';
import 'package:rta_crm_cv/models/vehicle.dart';

class User {
  User(
      {required this.id,
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
      required this.idtema,
      required this.status,
      required this.license,
      required this.certification,
      this.idVehicle,
      this.userID});

  String id;
  int sequentialId;
  String email;
  String name;
  String? middleName;
  String lastName;
  String? homePhone;
  String mobilePhone;
  String address;
  String? image;
  DateTime? birthDate;
  Role role;
  Company company;
  State state;
  int idtema;
  String? status;
  String? license;
  String? certification;
  int? userID;
  int? idVehicle;

  String get fullName => '$name $lastName';

  // Both
  bool get isAdmin => currentUser!.isAdminCrm || currentUser!.isAdminCv;

  // CRM
  bool get isCRM =>
      currentUser!.isAdminCrm ||
      currentUser!.isSales ||
      currentUser!.isSenExec ||
      currentUser!.isFinance ||
      currentUser!.isOpperations;
  bool get isAdminCrm => role.id == 4;
  bool get isSales => role.id == 6;
  bool get isSenExec => role.id == 9;
  bool get isFinance => role.id == 8;
  bool get isOpperations => role.id == 7;

  // CV
  bool get isCV =>
      currentUser!.isAdminCv ||
      currentUser!.isManager ||
      currentUser!.isEmployee;
  bool get isAdminCv => role.roleName == 'Admin CV';
  bool get isManager => role.roleName == 'Manager';
  bool get isEmployee => role.roleName == 'Employee';

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
        birthDate: json['birthdate'] == null
            ? null
            : DateTime.parse(json['birthdate']),
        role: Role.fromJson(jsonEncode(json['role'])),
        company: Company.fromJson(jsonEncode(json['company'])),
        state: State.fromJson(jsonEncode(json['state'])),
        idtema: json["id_tema_fk"],
        status: json["status"],
        license: json["license"],
        certification: json["certification"],
        idVehicle: json["id_vehicle_fk"],
        userID: json["id_user"]);

    return usuario;
  }
}
