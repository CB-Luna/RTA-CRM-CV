import 'dart:convert';

class Opportunity {
    final int id;
    final DateTime createdAt;
    final String name;
    final int quoteAmount;
    final int probability;
    final DateTime lastActivity;
    final DateTime expectedClose;
    final String assignedTo;
    final dynamic account;
    final dynamic salesStage;
    final dynamic contact;
    final dynamic leadSource;
    final dynamic timeLine;
    final dynamic decisionMaker;
    final dynamic teachSpec;
    final String status;

    Opportunity({
        required this.id,
        required this.createdAt,
        required this.name,
        required this.quoteAmount,
        required this.probability,
        required this.lastActivity,
        required this.expectedClose,
        required this.assignedTo,
        required this.account,
        required this.salesStage,
        required this.contact,
        required this.leadSource,
        required this.timeLine,
        required this.decisionMaker,
        required this.teachSpec,
        required this.status,
    });

    factory Opportunity.fromJson(String str) => Opportunity.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Opportunity.fromMap(Map<String, dynamic> json) => Opportunity(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        quoteAmount: json["quote_amount"],
        probability: json["probability"],
        lastActivity: DateTime.parse(json["last_activity"]),
        expectedClose: DateTime.parse(json["expected_close"]),
        assignedTo: json["assigned_to"],
        account: json["account"],
        salesStage: json["sales_stage"],
        contact: json["contact"],
        leadSource: json["lead_source"],
        timeLine: json["time_line"],
        decisionMaker: json["decision_maker"],
        teachSpec: json["teach_spec"],
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "name": name,
        "quote_amount": quoteAmount,
        "probability": probability,
        "last_activity": lastActivity.toIso8601String(),
        "expected_close": expectedClose.toIso8601String(),
        "assigned_to": assignedTo,
        "account": account,
        "sales_stage": salesStage,
        "contact": contact,
        "lead_source": leadSource,
        "time_line": timeLine,
        "decision_maker": decisionMaker,
        "teach_spec": teachSpec,
        "status": status,
    };
}
