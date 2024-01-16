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

  List<String> get userApplications =>
      roles.map((role) => '${role.application} - ${role.roleName}').toList();

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
  bool get isAdmin =>
      currentUser!.isAdminCrm ||
      currentUser!.isAdminCv ||
      currentUser!.isAdminDashboards;

  // CRM
  bool get isCRM =>
      currentUser!.isAdminCrm ||
      currentUser!.isSales ||
      currentUser!.isSenExec ||
      currentUser!.isFinance ||
      currentUser!.isOpperations;

  // bool get isAdminCrm => roles.any((role) => role.id == 4);

  bool get isAdminCrm => currentUser!.currentRole.id == 4;
  bool get isSales => currentUser!.currentRole.id == 6;
  bool get isOpperations => currentUser!.currentRole.id == 7;
  bool get isFinance => currentUser!.currentRole.id == 8;
  bool get isSenExec => currentUser!.currentRole.id == 9;

  // CV
  bool get isCV =>
      currentUser!.isAdminCv ||
      currentUser!.isManager ||
      currentUser!.isEmployee ||
      currentUser!.isTechSupervisor;

  bool get isAdminCv => currentUser!.currentRole.roleName == "Admin FM";
  bool get isManager => currentUser!.currentRole.roleName == 'Manager';
  bool get isEmployee => currentUser!.currentRole.roleName == 'Employee';
  bool get isTechSupervisor =>
      currentUser!.currentRole.roleName == 'Tech Supervisor';

  // bool get isTechSupervisor =>
  //     roles.any((role) => role.roleName == 'Tech Supervisor');

  // Dashboards RTATEL
  bool get isDashboardsRTATEL =>
      isAdminDashboards ||
      isDashboardsOperation1 ||
      isDashboardsOperation2 ||
      isDashboardsFinancial1 ||
      isDashboardsFinancial2 ||
      isDashboardsFinancial3 ||
      isDashboardsSupervisor1 ||
      isDashboardsSupervisor2 ||
      isDashboardsInstaller ||
      isDashboardsCareRep ||
      isDashboardsBank1 ||
      isDashboardsBank2 ||
      isDashboardsBank3;
  bool get isAdminDashboards =>
      currentUser!.currentRole.roleName == 'Admin Dashboards';
  bool get isDashboardsOperation1 =>
      currentUser!.currentRole.roleName == 'Operation 1';
  bool get isDashboardsOperation2 =>
      currentUser!.currentRole.roleName == 'Operation 2';
  bool get isDashboardsSupervisor1 =>
      currentUser!.currentRole.roleName == 'Dashboard Supervisor 1';
  bool get isDashboardsSupervisor2 =>
      currentUser!.currentRole.roleName == 'Dashboard Supervisor 2';
  bool get isDashboardsInstaller =>
      currentUser!.currentRole.roleName == "Installers 1";
  bool get isDashboardsFinancial1 =>
      currentUser!.currentRole.roleName == 'Financial 1';
  bool get isDashboardsFinancial2 =>
      currentUser!.currentRole.roleName == 'Financial 2';
  bool get isDashboardsFinancial3 =>
      currentUser!.currentRole.roleName == 'Financial 3';
  bool get isDashboardsBank1 => currentUser!.currentRole.roleName == 'Bank 1';
  bool get isDashboardsBank2 => currentUser!.currentRole.roleName == 'Bank 2';
  bool get isDashboardsBank3 => currentUser!.currentRole.roleName == 'Bank 3';

  bool get isDashboardsCareRep =>
      currentUser!.currentRole.roleName == 'Care Rep 1';

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
      birthDate:
          json['birthdate'] == null ? null : DateTime.parse(json['birthdate']),
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
