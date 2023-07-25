import 'dart:convert';

class X2QuotesDashboard {
    final int quoteid;
    final String quote;
    final double total;
    final int probability;
    final String company;
    final String description;
    final String status;

    X2QuotesDashboard({
        required this.quoteid,
        required this.quote,
        required this.total,
        required this.probability,
        required this.company,
        required this.description,
        required this.status,
    });

    factory X2QuotesDashboard.fromJson(String str) => X2QuotesDashboard.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory X2QuotesDashboard.fromMap(Map<String, dynamic> json) => X2QuotesDashboard(
        quoteid: json["quoteid"],
        quote: json["quote"],
        total: json["total"].toDouble(),
        probability: json["probability"],
        company: json["company"],
        description: json["description"],
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "quoteid": quoteid,
        "quote": quote,
        "total": total,
        "probability": probability,
        "company": company,
        "description": description,
        "status": status,
    };
}
