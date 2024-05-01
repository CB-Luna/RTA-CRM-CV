import 'dart:convert';

class TeamMembersSafetyModel {
  String? name;
  String? role;
  // String? picString;
  String? pic;
  String? id;

  TeamMembersSafetyModel({this.name, this.role, this.id, this.pic});

  factory TeamMembersSafetyModel.fromJson(String str) =>
      TeamMembersSafetyModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TeamMembersSafetyModel.fromMap(Map<String, dynamic> json) =>
      TeamMembersSafetyModel(
          name: json["name"],
          role: json["role"],
          pic: json["pic"],
          id: json["id"]);

  Map<String, dynamic> toMap() => {
        'name': name,
        'role': role,
        'id': id,
        'pic': pic,
      };
}
