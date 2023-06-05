import 'dart:convert';

class Leads {
  final int id;
  final DateTime createdAt;
  final String name;
  final int quoteAmount;
  final int probability;
  final dynamic expectedClose;
  final dynamic lastActivity;
  final String assignedTo;
  final dynamic status;

  Leads({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.quoteAmount,
    required this.probability,
    required this.expectedClose,
    required this.lastActivity,
    required this.assignedTo,
    required this.status,
  });

  factory Leads.fromJson(String str) => Leads.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Leads.fromMap(Map<String, dynamic> json) => Leads(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        quoteAmount: json["quote_amount"],
        probability: json["probability"],
        expectedClose: json["expected_close"],
        lastActivity: json["last_activity"],
        assignedTo: json["assigned_to"],
        status: json["status"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "name": name,
        "quote_amount": quoteAmount,
        "probability": probability,
        "expected_close": expectedClose,
        "last_activity": lastActivity,
        "assigned_to": assignedTo,
        "status": status,
      };
}
