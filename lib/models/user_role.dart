import 'dart:convert';

class UserRole {
  UserRole({
    required this.name,
    required this.lastName,
    required this.email,
  });

  String name;
  String lastName;
  String email;

  factory UserRole.fromJson(String str) => UserRole.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserRole.fromMap(Map<String, dynamic> json) => UserRole(
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "last_name": lastName,
        "email": email,
      };
}
