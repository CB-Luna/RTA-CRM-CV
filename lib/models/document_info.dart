import 'dart:convert';

class DocumentInfo {
    final String? code;
    final String? msg;
    final List<Result>? result;

    DocumentInfo({
        this.code,
        this.msg,
        this.result,
    });

    factory DocumentInfo.fromJson(String str) => DocumentInfo.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DocumentInfo.fromMap(Map<String, dynamic> json) => DocumentInfo(
        code: json["code"],
        msg: json["msg"],
        result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "code": code,
        "msg": msg,
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toMap())),
    };
}

class Result {
    final String? customerId;
    final String? firstName;
    final String? lastName;
    final String? street;
    final String? city;
    final String? state;
    final String? zipcode;
    final String? email;
    final String? mobilePhone;

    Result({
        this.customerId,
        this.firstName,
        this.lastName,
        this.street,
        this.city,
        this.state,
        this.zipcode,
        this.email,
        this.mobilePhone,
    });

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Result.fromMap(Map<String, dynamic> json) => Result(
        customerId: json["customerID"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        street: json["street"],
        city: json["city"],
        state: json["state"],
        zipcode: json["zipcode"],
        email: json["email"],
        mobilePhone:json["mobilePhone"],
    );

    Map<String, dynamic> toMap() => {
        "customerID": customerId,
        "firstName": firstName,
        "lastName": lastName,
        "street": street,
        "city": city,
        "state": state,
        "zipcode": zipcode,
        "email": email,
        "mobilePhone":mobilePhone,
    };
}
