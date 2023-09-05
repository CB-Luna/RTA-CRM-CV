import 'dart:convert';

class Role {
  Role({
    required this.id,
    required this.roleName,
    required this.permissions,
  });

  int id;
  String roleName;
  Permissions permissions;

  factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

  factory Role.fromMap(Map<String, dynamic> json) => Role(
        id: json["id"] ?? json['role_id'],
        roleName: json["name"],
        permissions: Permissions.fromMap(json["permissions"]),
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Role && other.roleName == roleName && other.id == id;
  }

  @override
  int get hashCode => Object.hash(roleName, id, permissions);
}

class Permissions {
  Permissions({
    required this.home,
    required this.employees,
    required this.prospects,
    required this.userProfile,
    required this.usersAdministration,
  });

  String? home;
  String? employees;
  String? prospects;
  String? userProfile;
  String? usersAdministration;

  factory Permissions.fromJson(String str) =>
      Permissions.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Permissions.fromMap(Map<String, dynamic> json) => Permissions(
        home: json['Home'],
        employees: json['Employees'],
        prospects: json['Prospects'],
        userProfile: json['User Profile'],
        usersAdministration: json['Users Administration'],
      );

  Map<String, dynamic> toMap() => {
        "Home": home,
        "Employees": employees,
        "Prospects": prospects,
        "User Profile": userProfile,
        "Users Administration": usersAdministration,
      };
}
