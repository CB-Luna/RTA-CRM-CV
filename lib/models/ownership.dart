import 'dart:convert';

class Ownership {
  Ownership({
    required this.idOwnership,
    required this.ownership,
  });

  final int idOwnership;
  final String ownership;

  factory Ownership.fromJson(String str) => Ownership.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ownership.fromMap(Map<String, dynamic> json) => Ownership(
        idOwnership: json["id_ownership"],
        ownership: json["ownership"],
      );

  Map<String, dynamic> toMap() => {
        "id_ownership": idOwnership,
        "ownership": ownership,
      };
}
