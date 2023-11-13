import 'dart:convert';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/models.dart';

class User {
  User({
    required this.id,
    required this.sequentialId,
    required this.email,
    required this.name,
    required this.middleName,
    required this.lastName,
    this.homePhone,
    this.mobilePhone,
    required this.address,
    this.image,
    this.birthDate,
    required this.roles,
    required this.company,
    required this.state,
    required this.idtema,
    required this.status,
    required this.license,
    required this.certification,
    this.idVehicle,
    this.licensePlates,
    this.userID,
  });

  String id;
  int sequentialId;
  String email;
  String name;
  String? middleName;
  String lastName;
  String? homePhone;
  String? mobilePhone;
  String address;
  String? image;
  DateTime? birthDate;
  List<Role> roles;
  Company company;
  State state;
  int idtema;
  String? status;
  String? license;
  String? certification;
  int? userID;
  int? idVehicle;
  String? licensePlates;

  late Role currentRole;

  String get fullName => '$name $lastName';

  bool setRole(String role) {
    try {
      currentRole = roles.firstWhere((e) => e.roleName == role);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool checkRoles() {
    return roles.length > 1;
  }

  // Both
  bool get isAdmin => currentUser!.isAdminCrm || currentUser!.isAdminCv;

  // CRM
  bool get isCRM =>
      currentUser!.isAdminCrm ||
      currentUser!.isSales ||
      currentUser!.isSenExec ||
      currentUser!.isFinance ||
      currentUser!.isOpperations;

  bool get isAdminCrm => roles.any((role) => role.id == 4);
  bool get isSales => roles.any((role) => role.id == 6);
  bool get isSenExec => roles.any((role) => role.id == 9);
  bool get isFinance => roles.any((role) => role.id == 8);
  bool get isOpperations => roles.any((role) => role.id == 7);

  // CV
  bool get isCV =>
      currentUser!.isAdminCv || currentUser!.isManager || currentUser!.isEmployee || currentUser!.isTechSupervisor;

  bool get isAdminCv => roles.any((role) => role.roleName == 'Admin CV');
  bool get isManager => roles.any((role) => role.roleName == 'Manager');
  bool get isEmployee => roles.any((role) => role.roleName == 'Employee');
  bool get isTechSupervisor => roles.any((role) => role.roleName == 'Tech Supervisor');

  // Dashboards RTATEL
  bool get isDashboardsRTATEL => currentUser!.isAdminDashboards;
  bool get isAdminDashboards => roles.any((role) => role.roleName == 'Admin Dashboards');

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  factory User.fromMap(Map<String, dynamic> json) {
    User user = User(
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
      birthDate: json['birthdate'] == null ? null : DateTime.parse(json['birthdate']),
      roles: (json['roles'] as List).map((role) => Role.fromMap(role)).toList(),
      company: Company.fromJson(jsonEncode(json['company'])),
      state: State.fromJson(jsonEncode(json['state'])),
      idtema: json["id_tema_fk"],
      status: json["status"],
      license: json["license"],
      certification: json["certification"],
      idVehicle: json["id_vehicle_fk"],
      licensePlates: json['license_plates'],
      userID: json["id_user"],
    );

    user.currentRole = user.roles.first;

    return user;
  }
}
