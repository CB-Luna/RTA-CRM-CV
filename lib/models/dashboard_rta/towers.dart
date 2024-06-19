import 'dart:convert';

class TowerRta {
  int? id;
  DateTime? createdAt;
  int? companyId;
  String? name;
  int? height;
  String? type;
  String? address;
  String? city;
  String? long;
  String? lat;
  String? leasedOwned;
  String? lessor;
  String? licensed;
  String? use;
  String? make;
  String? model;
  String? numbCustomerServed;
  String? frequency;

  TowerRta({
    this.id,
    this.createdAt,
    this.companyId,
    this.name,
    this.height,
    this.type,
    this.address,
    this.city,
    this.long,
    this.lat,
    this.leasedOwned,
    this.lessor,
    this.licensed,
    this.use,
    this.make,
    this.model,
    this.numbCustomerServed,
    this.frequency,
  });

  factory TowerRta.fromJson(String str) => TowerRta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TowerRta.fromMap(Map<String, dynamic> json) => TowerRta(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        companyId: json["company_id"],
        name: json["name"],
        height: json["height"],
        type: json["type"],
        address: json["address"],
        city: json["city"],
        long: json["long"],
        lat: json["lat"],
        leasedOwned: json["leased_owned"],
        lessor: json["lessor"],
        licensed: json["licensed"],
        use: json["use"],
        make: json["make"],
        model: json["model"],
        numbCustomerServed: json["numb_customer_served"],
        frequency: json["frequency"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "company_id": companyId,
        "name": name,
        "height": height,
        "type": type,
        "address": address,
        "city": city,
        "long": long,
        "lat": lat,
        "leased_owned": leasedOwned,
        "lessor": lessor,
        "licensed": licensed,
        "use": use,
        "make": make,
        "model": model,
        "numb_customer_served": numbCustomerServed,
        "frequency": frequency,
      };
}
