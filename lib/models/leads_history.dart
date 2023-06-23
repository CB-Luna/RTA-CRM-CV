import 'dart:convert';

class LeadsHistory {
    final int id;
    final DateTime createdAt;
    final String user;
    final String action;
    final String description;
    final String table;
    final String idTable;
    final String name;

    LeadsHistory({
        required this.id,
        required this.createdAt,
        required this.user,
        required this.action,
        required this.description,
        required this.table,
        required this.idTable,
        required this.name,
    });

    factory LeadsHistory.fromJson(String str) => LeadsHistory.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LeadsHistory.fromMap(Map<String, dynamic> json) => LeadsHistory(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        user: json["user"],
        action: json["action"],
        description: json["description"],
        table: json["table"],
        idTable: json["id_table"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "user": user,
        "action": action,
        "description": description,
        "table": table,
        "id_table": idTable,
        "name": name,
    };
}
