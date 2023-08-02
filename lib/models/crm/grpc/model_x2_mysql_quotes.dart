// To parse this JSON data, do
//
//     final modelX2MysqlQuotes = modelX2MysqlQuotesFromMap(jsonString);

import 'dart:convert';

class ModelX2MysqlQuotes {
  int? id;
  String? name;
  double? total;
  String? nameId;
  String? status;
  Account? account;
  String? currency;
  List<Product>? products;
  double? subtotal;
  String? createdBy;
  String? updatedBy;
  String? assignedTo;
  DateTime? createDate;
  dynamic leadSource;
  String? description;
  DateTime? lastUpdated;
  double? probability;
  DateTime? expirationDate;
  dynamic expectedCloseDate;

  ModelX2MysqlQuotes({
    this.id,
    this.name,
    this.total,
    this.nameId,
    this.status,
    this.account,
    this.currency,
    this.products,
    this.subtotal,
    this.createdBy,
    this.updatedBy,
    this.assignedTo,
    this.createDate,
    this.leadSource,
    this.description,
    this.lastUpdated,
    this.probability,
    this.expirationDate,
    this.expectedCloseDate,
  });

  factory ModelX2MysqlQuotes.fromJson(String str) => ModelX2MysqlQuotes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelX2MysqlQuotes.fromMap(Map<String, dynamic> json) => ModelX2MysqlQuotes(
        id: json["id"],
        name: json["name"],
        total: json["total"],
        nameId: json["nameId"],
        status: json["status"],
        account: json["account"] == null ? null : Account.fromMap(json["account"]),
        currency: json["currency"],
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromMap(x))),
        subtotal: json["subtotal"],
        createdBy: json["createdBy"],
        updatedBy: json["updatedBy"],
        assignedTo: json["assignedTo"],
        createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
        leadSource: json["leadSource"],
        description: json["description"],
        lastUpdated: json["lastUpdated"] == null ? null : DateTime.parse(json["lastUpdated"]),
        probability: json["probability"],
        expirationDate: json["expirationDate"] == null ? null : DateTime.parse(json["expirationDate"]),
        expectedCloseDate: json["expectedCloseDate"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "total": total,
        "nameId": nameId,
        "status": status,
        "account": account?.toMap(),
        "currency": currency,
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toMap())),
        "subtotal": subtotal,
        "createdBy": createdBy,
        "updatedBy": updatedBy,
        "assignedTo": assignedTo,
        "createDate": createDate?.toIso8601String(),
        "leadSource": leadSource,
        "description": description,
        "lastUpdated": lastUpdated?.toIso8601String(),
        "probability": probability,
        "expirationDate": expirationDate?.toIso8601String(),
        "expectedCloseDate": expectedCloseDate,
      };
}

class Account {
  String? city;
  String? name;
  String? email;
  String? phone;
  String? state;
  String? nameId;
  dynamic phone2;
  String? address;
  dynamic company;
  String? country;
  String? website;
  String? zipcode;
  dynamic address2;
  dynamic lastName;
  dynamic firstName;
  dynamic businessEmail;
  dynamic preferredEmail;

  Account({
    this.city,
    this.name,
    this.email,
    this.phone,
    this.state,
    this.nameId,
    this.phone2,
    this.address,
    this.company,
    this.country,
    this.website,
    this.zipcode,
    this.address2,
    this.lastName,
    this.firstName,
    this.businessEmail,
    this.preferredEmail,
  });

  factory Account.fromJson(String str) => Account.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Account.fromMap(Map<String, dynamic> json) => Account(
        city: json["city"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        state: json["state"],
        nameId: json["nameId"],
        phone2: json["phone2"],
        address: json["address"],
        company: json["company"],
        country: json["country"],
        website: json["website"],
        zipcode: json["zipcode"],
        address2: json["address2"],
        lastName: json["lastName"],
        firstName: json["firstName"],
        businessEmail: json["businessEmail"],
        preferredEmail: json["preferredEmail"],
      );

  Map<String, dynamic> toMap() => {
        "city": city,
        "name": name,
        "email": email,
        "phone": phone,
        "state": state,
        "nameId": nameId,
        "phone2": phone2,
        "address": address,
        "company": company,
        "country": country,
        "website": website,
        "zipcode": zipcode,
        "address2": address2,
        "lastName": lastName,
        "firstName": firstName,
        "businessEmail": businessEmail,
        "preferredEmail": preferredEmail,
      };
}

class Product {
  int? id;
  String? name;
  dynamic type;
  double? price;
  double? total;
  int? quoteId;
  String? currency;
  double? quantity;
  int? lineNumber;
  String? description;

  Product({
    this.id,
    this.name,
    this.type,
    this.price,
    this.total,
    this.quoteId,
    this.currency,
    this.quantity,
    this.lineNumber,
    this.description,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        price: json["price"],
        total: json["total"],
        quoteId: json["quoteId"],
        currency: json["currency"],
        quantity: json["quantity"],
        lineNumber: json["lineNumber"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "type": type,
        "price": price,
        "total": total,
        "quoteId": quoteId,
        "currency": currency,
        "quantity": quantity,
        "lineNumber": lineNumber,
        "description": description,
      };
}
