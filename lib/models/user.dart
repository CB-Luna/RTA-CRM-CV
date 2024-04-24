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
    this.homePhone,
    this.mobilePhone,
    required this.address,
    this.image,
    this.companyFk,
    this.birthDate,
    required this.roles,
    required this.companies,
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
  int? companyFk;
  DateTime? birthDate;
  List<Role> roles;
  List<Company> companies;
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

  List<String> get userApplications => roles.map((role) => '${role.application} - ${role.roleName}').toList();

  bool setRole(String role) {
    try {
      currentRole = roles.firstWhere((e) => e.roleName == role);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool checkRoles() => roles.length > 1;

  // Both
  bool get isAdmin => isAdminCrm || isAdminCv || isAdminDashboards || isAdminJSA;

  // CRM
  bool get isCRM => isAdminCrm || isSales || isSenExec || isFinance || isOpperations;

  // bool get isAdminCrm => roles.any((role) => role.id == 4);

  bool get isAdminCrm => currentRole.id == 4;
  bool get isSales => currentRole.id == 6;
  bool get isOpperations => currentRole.id == 7;
  bool get isFinance => currentRole.id == 8;
  bool get isSenExec => currentRole.id == 9;

  // CV
  bool get isCV => isAdminCv || isManager || isEmployee || isTechSupervisor;

  bool get isAdminCv => currentRole.id == 3;
  bool get isManager => currentRole.id == 2;
  bool get isEmployee => currentRole.id == 5;
  bool get isTechSupervisor => currentRole.id == 10;

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

  bool get isAdminDashboards => currentRole.id == 1; // Admin Dashboards
  bool get isDashboardsOperation1 => currentRole.id == 14; // Operation 1
  bool get isDashboardsOperation2 => currentRole.id == 15; // Operation 2
  bool get isDashboardsSupervisor1 => currentRole.id == 16; // Dashboard Supervisor 1
  bool get isDashboardsSupervisor2 => currentRole.id == 17; // Dashboard Supervisor 2
  bool get isDashboardsInstaller => currentRole.id == 22; // Installers 2
  bool get isDashboardsFinancial1 => currentRole.id == 11; // Financial 1
  bool get isDashboardsFinancial2 => currentRole.id == 12; // Financial 2
  bool get isDashboardsFinancial3 => currentRole.id == 13; // Financial 3
  bool get isDashboardsBank1 => currentRole.id == 18; // Bank 1
  bool get isDashboardsBank2 => currentRole.id == 19; // Bank 2
  bool get isDashboardsBank3 => currentRole.id == 20; // Bank 3

  bool get isDashboardsCareRep => currentRole.id == 21; // Care Rep

  // JSA
  bool get isJSA => isAdminJSA || isManagerJSA || isLeadJSA || isTechnicianJSA || isRepresentativeJSA;
  bool get isAdminJSA => currentRole.id == 23;
  bool get isManagerJSA => currentRole.id == 24;
  bool get isLeadJSA => currentRole.id == 25;
  bool get isTechnicianJSA => currentRole.id == 26;
  bool get isRepresentativeJSA => currentRole.id == 27;

  String get currentAppRole =>
      roles.where((role) => role.application == currentRole.application).toList().first.roleName;

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
      companyFk: json["id_company_fk"],
      birthDate: json['birthdate'] == null ? null : DateTime.parse(json['birthdate']),
      roles: (json['roles'] as List).map((role) => Role.fromMap(role)).toList(),
      companies: (json['companies'] as List).map((company) => Company.fromMap(company)).toList(),
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
