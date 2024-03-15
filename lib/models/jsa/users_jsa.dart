import 'dart:convert';

class UsersJsa {
  String? userId;
  String? name;
  String? lastName;
  int? idStatus;
  int? jsaFk;

  UsersJsa({
    this.userId,
    this.name,
    this.lastName,
    this.idStatus,
    this.jsaFk,
  });

  factory UsersJsa.fromJson(String str) => UsersJsa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsersJsa.fromMap(Map<String, dynamic> json) => UsersJsa(
        userId: json["user_id"],
        name: json["name"],
        lastName: json["last_name"],
        idStatus: json["id_status"],
        jsaFk: json["jsa_fk"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "name": name,
        "last_name": lastName,
        "id_status": idStatus,
        "jsa_fk": jsaFk,
      };
}
