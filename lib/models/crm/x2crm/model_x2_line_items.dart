// To parse this JSON data, do
//
//     final modelX2LineItems = modelX2LineItemsFromMap(jsonString);

import 'dart:convert';

class ModelX2LineItems {
  int? id;
  String? name;
  double? price;
  double? total;
  int? quoteId;
  String? currency;
  double? quantity;
  double? adjustment;
  dynamic createDate;

  ModelX2LineItems({
    this.id,
    this.name,
    this.price,
    this.total,
    this.quoteId,
    this.currency,
    this.quantity,
    this.adjustment,
    this.createDate,
  });

  factory ModelX2LineItems.fromJson(String str) => ModelX2LineItems.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelX2LineItems.fromMap(Map<String, dynamic> json) => ModelX2LineItems(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        total: json["total"],
        quoteId: json["quoteId"],
        currency: json["currency"],
        quantity: json["quantity"],
        adjustment: json["adjustment"] ?? 0,
        createDate: json["createDate"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "total": total,
        "quoteId": quoteId,
        "currency": currency,
        "quantity": quantity,
        "adjustment": adjustment,
        "createDate": createDate,
      };
}
