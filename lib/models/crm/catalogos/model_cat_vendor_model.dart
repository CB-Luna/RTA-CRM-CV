import 'dart:convert';

class Vendor {
  int? id;
  DateTime? createdAt;
  String? createdBy;
  DateTime? updatedAt;
  String? updatedBy;
  String? vendorName;

  Vendor({
    this.id,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.vendorName,
  });

  factory Vendor.fromJson(String str) => Vendor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Vendor.fromMap(Map<String, dynamic> json) => Vendor(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        updatedAt: DateTime.parse(json["updated_at"]),
        updatedBy: json["updated_by"],
        vendorName: json["vendor_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "created_by": createdBy,
        "updated_at": updatedAt?.toIso8601String(),
        "updated_by": updatedBy,
        "vendor_name": vendorName,
      };
}
