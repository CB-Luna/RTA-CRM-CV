import 'dart:convert';

class State {
  State({
    required this.id,
    required this.name,
    required this.code,
  });

  int id;
  String name;
  String code;

  factory State.fromJson(String str) => State.fromMap(json.decode(str));

  factory State.fromMap(Map<String, dynamic> json) {
    return State(
      id: json['id'] ?? json['state_id'],
      name: json['name'],
      code: json['code'],
    );
  }
}
