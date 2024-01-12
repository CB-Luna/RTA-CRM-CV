import 'dart:convert';

class HouseownerList {
    final int? id;
    final DateTime? createdAt;
    final DateTime? dueDate;
    final int? idStatus;
    final String? document;
    final FormInfo? formInfo;

    HouseownerList({
        this.id,
        this.createdAt,
        this.dueDate,
        this.idStatus,
        this.document,
        this.formInfo,
    });

    factory HouseownerList.fromJson(String str) => HouseownerList.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory HouseownerList.fromMap(Map<String, dynamic> json) => HouseownerList(
        id: json["id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        idStatus: json["id_status"],
        document: json["document"],
        formInfo: json["form_info"] == null ? null : FormInfo.fromMap(json["form_info"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "due_date": dueDate?.toIso8601String(),
        "id_status": idStatus,
        "document": document,
        "form_info": formInfo?.toMap(),
    };
}

class FormInfo {
    final String? acount;
    final String? zipCode;
    final String? email;
    final String? email2;
    final String? representativeName;
    final String? address;
    final String? acountName;
    final String? phone;
    final String? date;

    FormInfo({
        this.acount,
        this.zipCode,
        this.email,
        this.email2,
        this.representativeName,
        this.address,
        this.acountName,
        this.phone,
        this.date,
    });

    factory FormInfo.fromJson(String str) => FormInfo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FormInfo.fromMap(Map<String, dynamic> json) => FormInfo(
        acount: json["acount"],
        zipCode: json["zip_code"],
        email: json["email"],
        email2: json["email2"],
        representativeName: json["representative_name"],
        address: json["address"],
        acountName: json["acountName"],
        phone: json["phone"],
        date: json["date"],
    );

    Map<String, dynamic> toMap() => {
        "acount": acount,
        "zip_code": zipCode,
        "email": email,
        "email2":email2,
        "representative_name": representativeName,
        "address": address,
        "acountName": acountName,
        "phone": phone,
        "date": date,
    };
}
