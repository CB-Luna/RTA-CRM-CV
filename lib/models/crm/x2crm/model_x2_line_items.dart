// To parse this JSON data, do
//
//     final modelX2LineItems = modelX2LineItemsFromJson(jsonString);

import 'dart:convert';

class ModelX2LineItems {
  String? description;
  List<Item>? items;

  ModelX2LineItems({
    this.description,
    this.items,
  });

  factory ModelX2LineItems.fromRawJson(String str) => ModelX2LineItems.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelX2LineItems.fromJson(Map<String, dynamic> json) => ModelX2LineItems(
        description: json["description"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  int? id;
  String? name;
  double? price;
  double? total;
  int? quoteId;
  String? currency;
  double? quantity;
  double? adjustment;
  dynamic createDate;

  Item({
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

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        total: json["total"],
        quoteId: json["quoteId"],
        currency: json["currency"],
        quantity: json["quantity"],
        adjustment: json["adjustment"],
        createDate: json["createDate"],
      );

  Map<String, dynamic> toJson() => {
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
