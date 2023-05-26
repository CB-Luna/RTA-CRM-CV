import 'dart:convert';

class Employee {
  Employee({
    required this.name,
    required this.lastName,
  });

  String name;
  String lastName;

  factory Employee.fromJson(String str) => Employee.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
        name: json["name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "last_name": lastName,
      };
}
