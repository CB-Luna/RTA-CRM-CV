import 'dart:convert';

class TeamMembersSafetyModel {
  String? name;
  String? role;
  // String? picString;
  String? pic;
  String? id;
  String? email;

  TeamMembersSafetyModel({this.name, this.role, this.id, this.pic, this.email});

  factory TeamMembersSafetyModel.fromJson(String str) =>
      TeamMembersSafetyModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TeamMembersSafetyModel.fromMap(Map<String, dynamic> json) =>
      TeamMembersSafetyModel(
          name: json["name"],
          role: json["role"],
          pic: json["pic"],
          id: json["id"],
          email: json["email"]);

  Map<String, dynamic> toMap() =>
      {'name': name, 'role': role, 'id': id, 'pic': pic, 'email': email};
}
