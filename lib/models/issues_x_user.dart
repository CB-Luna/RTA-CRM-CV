// To parse this JSON data, do
//
//     final IssuesXUser = IssuesXUserFromMap(jsonString);

import 'dart:convert';

class IssuesXUser {
  final String userProfileId;
  final int sequentialId;
  final dynamic image;
  final String name;
  final String lastName;
  final String company;
  final int idVehicleFk;
  final int issuesR;
  final int issuesD;
  final int? userID;

  IssuesXUser(
      {required this.userProfileId,
      required this.sequentialId,
      this.image,
      required this.name,
      required this.lastName,
      required this.company,
      required this.idVehicleFk,
      required this.issuesR,
      required this.issuesD,
      this.userID});

  factory IssuesXUser.fromJson(String str) =>
      IssuesXUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IssuesXUser.fromMap(Map<String, dynamic> json) => IssuesXUser(
      userProfileId: json["user_profile_id"],
      sequentialId: json["sequential_id"],
      image: json["image"],
      name: json["name"],
      lastName: json["last_name"],
      company: json["company"],
      idVehicleFk: json["id_vehicle_fk"],
      issuesR: json["issues_r"],
      issuesD: json["issues_d"],
      userID: json["id_user"]);

  Map<String, dynamic> toMap() => {
        "user_profile_id": userProfileId,
        "sequential_id": sequentialId,
        "image": image,
        "name": name,
        "last_name": lastName,
        "company": company,
        "id_vehicle_fk": idVehicleFk,
        "issues_r": issuesR,
        "issues_d": issuesD,
        "id_user": userID
      };
}
