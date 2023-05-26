// To parse this JSON data, do
//
//     final employees = employeesFromMap(jsonString);

import 'dart:convert';

class Employees {
  String id;
  String? email;
  String userProfileId;
  String? name;
  String? middleName;
  String? lastName;
  String? homePhone;
  String? mobilePhone;
  String? address;
  dynamic image;
  DateTime dateAdded;
  DateTime birthdate;
  int idCompanyFk;
  int idRoleFk;
  int idTemaFk;
  int sequentialId;
  int stateFk;
  Roles role;
  CompanyEmployees company;
  State state;

  int idTema;

  Employees({
    required this.id,
    this.email,
    required this.userProfileId,
    this.name,
    this.middleName,
    this.lastName,
    this.homePhone,
    this.mobilePhone,
    this.address,
    this.image,
    required this.dateAdded,
    required this.birthdate,
    required this.idCompanyFk,
    required this.idRoleFk,
    required this.idTemaFk,
    required this.sequentialId,
    required this.stateFk,
    required this.role,
    required this.company,
    required this.state,
    required this.idTema,
  });

  factory Employees.fromJson(String str) => Employees.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Employees.fromMap(Map<String, dynamic> json) => Employees(
        id: json["id"],
        email: json["email"],
        userProfileId: json["user_profile_id"],
        name: json["name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        homePhone: json["home_phone"],
        mobilePhone: json["mobile_phone"],
        address: json["address"],
        image: json["image"],
        dateAdded: DateTime.parse(json["date_added"]),
        birthdate: DateTime.parse(json["birthdate"]),
        idCompanyFk: json["id_company_fk"],
        idRoleFk: json["id_role_fk"],
        idTemaFk: json["id_tema_fk"],
        sequentialId: json["sequential_id"],
        stateFk: json["state_fk"],
        role: Roles.fromMap(json["role"]),
        company: CompanyEmployees.fromMap(json["company"]),
        state: State.fromMap(json["state"]),
        idTema: json["id_tema"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "user_profile_id": userProfileId,
        "name": name,
        "middle_name": middleName,
        "last_name": lastName,
        "home_phone": homePhone,
        "mobile_phone": mobilePhone,
        "address": address,
        "image": image,
        "date_added": dateAdded.toIso8601String(),
        "birthdate":
            "${birthdate.year.toString().padLeft(4, '0')}-${birthdate.month.toString().padLeft(2, '0')}-${birthdate.day.toString().padLeft(2, '0')}",
        "id_company_fk": idCompanyFk,
        "id_role_fk": idRoleFk,
        "id_tema_fk": idTemaFk,
        "sequential_id": sequentialId,
        "state_fk": stateFk,
        "role": role.toMap(),
        "company": company.toMap(),
        "state": state.toMap(),
        "id_tema": idTema,
      };
}

class CompanyEmployees {
  int id;
  String company;

  CompanyEmployees({
    required this.id,
    required this.company,
  });

  factory CompanyEmployees.fromJson(String str) =>
      CompanyEmployees.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CompanyEmployees.fromMap(Map<String, dynamic> json) =>
      CompanyEmployees(
        id: json["id"],
        company: json["company"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "company": company,
      };
}

class Roles {
  int id;
  String name;
  Permisos permissions;

  Roles({
    required this.id,
    required this.name,
    required this.permissions,
  });

  factory Roles.fromJson(String str) => Roles.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Roles.fromMap(Map<String, dynamic> json) => Roles(
        id: json["id"],
        name: json["name"],
        permissions: Permisos.fromMap(json["permissions"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "permissions": permissions.toMap(),
      };
}

class Permisos {
  String home;
  String employees;
  String userProfile;
  String usersAdministration;

  Permisos({
    required this.home,
    required this.employees,
    required this.userProfile,
    required this.usersAdministration,
  });

  factory Permisos.fromJson(String str) => Permisos.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Permisos.fromMap(Map<String, dynamic> json) => Permisos(
        home: json["Home"],
        employees: json["Employees"],
        userProfile: json["User Profile"],
        usersAdministration: json["Users Administration"],
      );

  Map<String, dynamic> toMap() => {
        "Home": home,
        "Employees": employees,
        "User Profile": userProfile,
        "Users Administration": usersAdministration,
      };
}

class State {
  int id;
  String name;
  String code;

  State({
    required this.id,
    required this.name,
    required this.code,
  });

  factory State.fromJson(String str) => State.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory State.fromMap(Map<String, dynamic> json) => State(
        id: json["id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "code": code,
      };
}
