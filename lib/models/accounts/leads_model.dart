import 'dart:convert';

class Leads {
    final int id;
    final DateTime createdAt;
    final String nameLead;
    final int quoteAmount;
    final int probability;
    final DateTime expectedClose;
    final DateTime lastActivity;
    final String assignedTo;
    final String status;
    final String organitationName;
    final String firstName;
    final String lastName;
    final String phoneNumber;
    final String email;
    final String salesStage;
    final String account;
    final String leadSource;
    final String description;

    Leads({
        required this.id,
        required this.createdAt,
        required this.nameLead,
        required this.quoteAmount,
        required this.probability,
        required this.expectedClose,
        required this.lastActivity,
        required this.assignedTo,
        required this.status,
        required this.organitationName,
        required this.firstName,
        required this.lastName,
        required this.phoneNumber,
        required this.email,
        required this.salesStage,
        required this.account,
        required this.leadSource,
        required this.description,
    });

    factory Leads.fromJson(String str) => Leads.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Leads.fromMap(Map<String, dynamic> json) => Leads(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        nameLead: json["name_lead"],
        quoteAmount: json["quote_amount"],
        probability: json["probability"],
        expectedClose: DateTime.parse(json["expected_close"]),
        lastActivity: DateTime.parse(json["last_activity"]),
        assignedTo: json["assigned_to"],
        status: json["status"],
        organitationName: json["organitation_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        salesStage: json["sales_stage"],
        account: json["account"],
        leadSource: json["lead_source"],
        description: json["description"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "name_lead": nameLead,
        "quote_amount": quoteAmount,
        "probability": probability,
        "expected_close": expectedClose.toIso8601String(),
        "last_activity": lastActivity.toIso8601String(),
        "assigned_to": assignedTo,
        "status": status,
        "organitation_name": organitationName,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "email": email,
        "sales_stage": salesStage,
        "account": account,
        "lead_source": leadSource,
        "description": description,
    };
}
