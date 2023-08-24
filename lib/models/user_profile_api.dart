import 'dart:convert';

class Worker {
  Worker({
    required this.name,
    required this.lastName,
    required this.role,
  });

  String name;
  String lastName;
  String role;

  factory Worker.fromJson(String str) => Worker.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Worker.fromMap(Map<String, dynamic> json) => Worker(
        name: json["name"],
        lastName: json["last_name"],
        role: json["role"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "last_name": lastName,
        "role": role,
      };
}
