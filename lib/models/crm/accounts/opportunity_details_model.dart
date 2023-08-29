import 'dart:convert';

class OpportunityDetails {
    final int id;
    final DateTime createdAt;
    final String name;
    final int quoteAmount;
    final int probability;
    final DateTime lastActivity;
    final DateTime expectedClose;
    final String assignedTo;
    final String account;
    final String salesStage;
    final String contact;
    final String leadSource;
    final bool timeLine;
    final bool decisionMaker;
    final bool teachSpec;
    final String status;
    final String description;
    final bool budget;

    OpportunityDetails({
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
        required this.description,
        required this.budget,
    });

    factory OpportunityDetails.fromJson(String str) => OpportunityDetails.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OpportunityDetails.fromMap(Map<String, dynamic> json) => OpportunityDetails(
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
        description: json["description"],
        budget: json["budget"],
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
        "description": description,
        "budget": budget,
    };
}
