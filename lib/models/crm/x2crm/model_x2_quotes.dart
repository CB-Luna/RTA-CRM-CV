// To parse this JSON data, do
//
//     final modelX2Quotes = modelX2QuotesFromMap(jsonString);

import 'dart:convert';

class ModelX2Quotes {
  int? id;
  String? name;
  String? nameId;
  String? accountName;
  String? salesStage;
  String? expectedCloseDate;
  String? probability;
  String? leadSource;
  String? email;
  String? phone;
  String? leadStatus;
  String? modelName;
  String? description;
  String? assignedTo;
  String? createDate;
  String? createdBy;
  String? associatedContacts;
  String? lastUpdated;
  String? lastActivity;
  String? updatedBy;
  String? expirationDate;
  String? status;
  String? currency;
  String? locked;
  String? type;
  String? invoiceStatus;
  String? invoiceCreateDate;
  String? invoiceIssuedDate;
  String? invoicePayedDate;
  String? template;
  String? total;
  String? subtotal;

  ModelX2Quotes({
    this.id,
    this.name,
    this.nameId,
    this.accountName,
    this.salesStage,
    this.expectedCloseDate,
    this.probability,
    this.leadSource,
    this.email,
    this.phone,
    this.leadStatus,
    this.modelName,
    this.description,
    this.assignedTo,
    this.createDate,
    this.createdBy,
    this.associatedContacts,
    this.lastUpdated,
    this.lastActivity,
    this.updatedBy,
    this.expirationDate,
    this.status,
    this.currency,
    this.locked,
    this.type,
    this.invoiceStatus,
    this.invoiceCreateDate,
    this.invoiceIssuedDate,
    this.invoicePayedDate,
    this.template,
    this.total,
    this.subtotal,
  });

  factory ModelX2Quotes.fromJson(String str) => ModelX2Quotes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelX2Quotes.fromMap(Map<String, dynamic> json) => ModelX2Quotes(
        id: json["id"],
        name: json["name"],
        nameId: json["nameId"],
        accountName: json["accountName"],
        salesStage: json["salesStage"],
        expectedCloseDate: json["expectedCloseDate"],
        probability: json["probability"],
        leadSource: json["leadSource"],
        email: json["email"],
        phone: json["phone"],
        leadStatus: json["leadStatus"],
        modelName: json["modelName"],
        description: json["description"],
        assignedTo: json["assignedTo"],
        createDate: json["createDate"],
        createdBy: json["createdBy"],
        associatedContacts: json["associatedContacts"],
        lastUpdated: json["lastUpdated"],
        lastActivity: json["lastActivity"],
        updatedBy: json["updatedBy"],
        expirationDate: json["expirationDate"],
        status: json["status"],
        currency: json["currency"],
        locked: json["locked"],
        type: json["type"],
        invoiceStatus: json["invoiceStatus"],
        invoiceCreateDate: json["invoiceCreateDate"],
        invoiceIssuedDate: json["invoiceIssuedDate"],
        invoicePayedDate: json["invoicePayedDate"],
        template: json["template"],
        total: json["total"],
        subtotal: json["subtotal"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "nameId": nameId,
        "accountName": accountName,
        "salesStage": salesStage,
        "expectedCloseDate": expectedCloseDate,
        "probability": probability,
        "leadSource": leadSource,
        "email": email,
        "phone": phone,
        "leadStatus": leadStatus,
        "modelName": modelName,
        "description": description,
        "assignedTo": assignedTo,
        "createDate": createDate,
        "createdBy": createdBy,
        "associatedContacts": associatedContacts,
        "lastUpdated": lastUpdated,
        "lastActivity": lastActivity,
        "updatedBy": updatedBy,
        "expirationDate": expirationDate,
        "status": status,
        "currency": currency,
        "locked": locked,
        "type": type,
        "invoiceStatus": invoiceStatus,
        "invoiceCreateDate": invoiceCreateDate,
        "invoiceIssuedDate": invoiceIssuedDate,
        "invoicePayedDate": invoicePayedDate,
        "template": template,
        "total": total,
        "subtotal": subtotal,
      };
}
