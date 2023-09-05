import 'dart:convert';

class Company {
  Company({
    required this.id,
    required this.company,
  });

  int id;
  String company;

  factory Company.fromJson(String str) => Company.fromMap(json.decode(str));

  factory Company.fromMap(Map<String, dynamic> json) {
    return Company(
      id: json['id_company'],
      company: json['company'],
    );
  }
}
