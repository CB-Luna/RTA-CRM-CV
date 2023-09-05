// To parse this JSON data, do
//
//     final x2CrmQuote = x2CrmQuoteFromMap(jsonString);

import 'dart:convert';

class X2CrmQuote {
  String? accountName;
  String? assignedTo;
  String? associatedContacts;
  String? createDate;
  String? createdBy;
  String? currency;
  String? description;
  String? email;
  dynamic existingProducts;
  DateTime? expectedCloseDate;
  String? expirationDate;
  String? id;
  DateTime? invoiceCreateDate;
  DateTime? invoiceIssuedDate;
  DateTime? invoicePayedDate;
  dynamic invoiceStatus;
  String? lastActivity;
  String? lastUpdated;
  dynamic leadSource;
  dynamic leadstatus;
  String? locked;
  dynamic modelName;
  String? name;
  String? nameId;
  String? phone;
  String? probability;
  dynamic products;
  dynamic salesStage;
  String? status;
  String? subtotal;
  String? template;
  String? total;
  dynamic type;
  String? updatedBy;

  X2CrmQuote({
    this.accountName,
    this.assignedTo,
    this.associatedContacts,
    this.createDate,
    this.createdBy,
    this.currency,
    this.description,
    this.email,
    this.existingProducts,
    this.expectedCloseDate,
    this.expirationDate,
    this.id,
    this.invoiceCreateDate,
    this.invoiceIssuedDate,
    this.invoicePayedDate,
    this.invoiceStatus,
    this.lastActivity,
    this.lastUpdated,
    this.leadSource,
    this.leadstatus,
    this.locked,
    this.modelName,
    this.name,
    this.nameId,
    this.phone,
    this.probability,
    this.products,
    this.salesStage,
    this.status,
    this.subtotal,
    this.template,
    this.total,
    this.type,
    this.updatedBy,
  });

  factory X2CrmQuote.fromJson(String str) => X2CrmQuote.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory X2CrmQuote.fromMap(Map<String, dynamic> json) => X2CrmQuote(
        accountName: json["accountName"],
        assignedTo: json["assignedTo"],
        associatedContacts: json["associatedContacts"],
        createDate: json["createDate"],
        createdBy: json["createdBy"],
        currency: json["currency"],
        description: json["description"],
        email: json["email"],
        existingProducts: json["existingProducts"],
        expectedCloseDate: json["expectedCloseDate"] == null ? null : DateTime.parse(json["expectedCloseDate"]),
        expirationDate: json["expirationDate"],
        id: json["id"],
        invoiceCreateDate: json["invoiceCreateDate"] == null ? null : DateTime.parse(json["invoiceCreateDate"]),
        invoiceIssuedDate: json["invoiceIssuedDate"] == null ? null : DateTime.parse(json["invoiceIssuedDate"]),
        invoicePayedDate: json["invoicePayedDate"] == null ? null : DateTime.parse(json["invoicePayedDate"]),
        invoiceStatus: json["invoiceStatus"],
        lastActivity: json["lastActivity"],
        lastUpdated: json["lastUpdated"],
        leadSource: json["leadSource"],
        leadstatus: json["leadstatus"],
        locked: json["locked"],
        modelName: json["modelName"],
        name: json["name"],
        nameId: json["nameId"],
        phone: json["phone"],
        probability: json["probability"],
        products: json["products"],
        salesStage: json["salesStage"],
        status: json["status"],
        subtotal: json["subtotal"],
        template: json["template"],
        total: json["total"],
        type: json["type"],
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toMap() => {
        "accountName": accountName,
        "assignedTo": assignedTo,
        "associatedContacts": associatedContacts,
        "createDate": createDate,
        "createdBy": createdBy,
        "currency": currency,
        "description": description,
        "email": email,
        "existingProducts": existingProducts,
        "expectedCloseDate": "${expectedCloseDate!.year.toString().padLeft(4, '0')}-${expectedCloseDate!.month.toString().padLeft(2, '0')}-${expectedCloseDate!.day.toString().padLeft(2, '0')}",
        "expirationDate": expirationDate,
        "id": id,
        "invoiceCreateDate": "${invoiceCreateDate!.year.toString().padLeft(4, '0')}-${invoiceCreateDate!.month.toString().padLeft(2, '0')}-${invoiceCreateDate!.day.toString().padLeft(2, '0')}",
        "invoiceIssuedDate": "${invoiceIssuedDate!.year.toString().padLeft(4, '0')}-${invoiceIssuedDate!.month.toString().padLeft(2, '0')}-${invoiceIssuedDate!.day.toString().padLeft(2, '0')}",
        "invoicePayedDate": "${invoicePayedDate!.year.toString().padLeft(4, '0')}-${invoicePayedDate!.month.toString().padLeft(2, '0')}-${invoicePayedDate!.day.toString().padLeft(2, '0')}",
        "invoiceStatus": invoiceStatus,
        "lastActivity": lastActivity,
        "lastUpdated": lastUpdated,
        "leadSource": leadSource,
        "leadstatus": leadstatus,
        "locked": locked,
        "modelName": modelName,
        "name": name,
        "nameId": nameId,
        "phone": phone,
        "probability": probability,
        "products": products,
        "salesStage": salesStage,
        "status": status,
        "subtotal": subtotal,
        "template": template,
        "total": total,
        "type": type,
        "updatedBy": updatedBy,
      };
}
