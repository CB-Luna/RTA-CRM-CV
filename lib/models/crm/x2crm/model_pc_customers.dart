// To parse this JSON data, do
//
//     final PcCustomer = PcCustomerFromMap(jsonString);

import 'dart:convert';

class PcCustomer {
  int? id;
  DateTime? createdAt;
  int? customerId;
  String? customerNamePc;
  String? customerNameX2;
  String? customerStatus;
  String? billingAddress;
  String? physicalAddress;
  String? phoneNumbers;

  PcCustomer({
    this.id,
    this.createdAt,
    this.customerId,
    this.customerNamePc,
    this.customerNameX2,
    this.customerStatus,
    this.billingAddress,
    this.physicalAddress,
    this.phoneNumbers,
  });

  factory PcCustomer.fromJson(String str) => PcCustomer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PcCustomer.fromMap(Map<String, dynamic> json) => PcCustomer(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        customerId: json["customer_id"],
        customerNamePc: json["customer_name_pc"],
        customerNameX2: json["customer_name_x2"],
        customerStatus: json["customer_status"],
        billingAddress: json["billing_address"],
        physicalAddress: json["physical_address"],
        phoneNumbers: json["phone_numbers"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "customer_id": customerId,
        "customer_name_pc": customerNamePc,
        "customer_name_x2": customerNameX2,
        "customer_status": customerStatus,
        "billing_address": billingAddress,
        "physical_address": physicalAddress,
        "phone_numbers": phoneNumbers,
      };
}
