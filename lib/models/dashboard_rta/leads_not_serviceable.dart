import 'dart:convert';

class LeadsNotServiceable {
    int idLeadsNotServiceable;
    DateTime createdAt;
    String name;
    String lastName;
    String phone;
    String email;
    String address;
    String latitude;
    String longitude;
    int companyFk;
    int sourceFk;

    LeadsNotServiceable({
        required this.idLeadsNotServiceable,
        required this.createdAt,
        required this.name,
        required this.lastName,
        required this.phone,
        required this.email,
        required this.address,
        required this.latitude,
        required this.longitude,
        required this.companyFk,
        required this.sourceFk,
    });

    factory LeadsNotServiceable.fromJson(String str) => LeadsNotServiceable.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory LeadsNotServiceable.fromMap(Map<String, dynamic> json) => LeadsNotServiceable(
        idLeadsNotServiceable: json["id_leads_not_serviceable"],
        createdAt: DateTime.parse(json["created_at"]),
        name: json["name"],
        lastName: json["last_name"],
        phone: json["phone"],
        email: json["email"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        companyFk: json["company_fk"],
        sourceFk: json["source_fk"],
    );

    Map<String, dynamic> toMap() => {
        "id_leads_not_serviceable": idLeadsNotServiceable,
        "created_at": createdAt.toIso8601String(),
        "name": name,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "company_fk": companyFk,
        "source_fk": sourceFk,
    };
}
