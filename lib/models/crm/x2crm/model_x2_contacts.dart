// To parse this JSON data, do
//
//     final modelX2Accounts = modelX2AccountsFromMap(jsonString);

import 'dart:convert';

class ModelX2Accounts {
  int? id;
  String? name;
  String? nameId;
  String? firstName;
  String? lastName;
  String? title;
  String? company;
  String? phone;
  String? phone2;
  String? email;
  String? website;
  String? address;
  String? address2;
  String? city;
  String? state;
  String? zipcode;
  String? country;
  String? visibility;
  String? assignedTo;
  String? backgroundInfo;
  String? twitter;
  String? linkedIn;
  String? skype;
  String? googlePlus;
  String? lastUpdated;
  String? lastActivity;
  String? updatedBy;
  String? priority;
  String? leadSource;
  String? leadDate;
  String? rating;
  String? createDate;
  String? facebook;
  String? otherUrl;
  String? leadType;
  String? closeDate;
  String? expectedCloseDate;
  String? interest;
  String? leadStatus;
  String? dealvalue;
  String? leadscore;
  String? dealstatus;
  String? timezone;
  String? doNotCall;
  String? doNotEmail;
  String? trackingKey;
  String? dupeCheck;
  String? fingerprintId;
  String? accountName;
  String? businessEmail;
  String? personalEmail;
  String? alternativeEmail;
  String? preferredEmail;
  String? reverseIp;

  ModelX2Accounts({
    this.id,
    this.name,
    this.nameId,
    this.firstName,
    this.lastName,
    this.title,
    this.company,
    this.phone,
    this.phone2,
    this.email,
    this.website,
    this.address,
    this.address2,
    this.city,
    this.state,
    this.zipcode,
    this.country,
    this.visibility,
    this.assignedTo,
    this.backgroundInfo,
    this.twitter,
    this.linkedIn,
    this.skype,
    this.googlePlus,
    this.lastUpdated,
    this.lastActivity,
    this.updatedBy,
    this.priority,
    this.leadSource,
    this.leadDate,
    this.rating,
    this.createDate,
    this.facebook,
    this.otherUrl,
    this.leadType,
    this.closeDate,
    this.expectedCloseDate,
    this.interest,
    this.leadStatus,
    this.dealvalue,
    this.leadscore,
    this.dealstatus,
    this.timezone,
    this.doNotCall,
    this.doNotEmail,
    this.trackingKey,
    this.dupeCheck,
    this.fingerprintId,
    this.accountName,
    this.businessEmail,
    this.personalEmail,
    this.alternativeEmail,
    this.preferredEmail,
    this.reverseIp,
  });

  factory ModelX2Accounts.fromJson(String str) => ModelX2Accounts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelX2Accounts.fromMap(Map<String, dynamic> json) => ModelX2Accounts(
        id: json["id"],
        name: json["name"],
        nameId: json["nameId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        title: json["title"],
        company: json["company"],
        phone: json["phone"],
        phone2: json["phone2"],
        email: json["email"],
        website: json["website"],
        address: json["address"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        zipcode: json["zipcode"],
        country: json["country"],
        visibility: json["visibility"],
        assignedTo: json["assignedTo"],
        backgroundInfo: json["backgroundInfo"],
        twitter: json["twitter"],
        linkedIn: json["linkedIn"],
        skype: json["skype"],
        googlePlus: json["googlePlus"],
        lastUpdated: json["lastUpdated"],
        lastActivity: json["lastActivity"],
        updatedBy: json["updatedBy"],
        priority: json["priority"],
        leadSource: json["leadSource"],
        leadDate: json["leadDate"],
        rating: json["rating"],
        createDate: json["createDate"],
        facebook: json["facebook"],
        otherUrl: json["otherUrl"],
        leadType: json["leadType"],
        closeDate: json["closeDate"],
        expectedCloseDate: json["expectedCloseDate"],
        interest: json["interest"],
        leadStatus: json["leadStatus"],
        dealvalue: json["dealvalue"],
        leadscore: json["leadscore"],
        dealstatus: json["dealstatus"],
        timezone: json["timezone"],
        doNotCall: json["doNotCall"],
        doNotEmail: json["doNotEmail"],
        trackingKey: json["trackingKey"],
        dupeCheck: json["dupeCheck"],
        fingerprintId: json["fingerprintId"],
        accountName: json["accountName"],
        businessEmail: json["businessEmail"],
        personalEmail: json["personalEmail"],
        alternativeEmail: json["alternativeEmail"],
        preferredEmail: json["preferredEmail"],
        reverseIp: json["reverseIp"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "nameId": nameId,
        "firstName": firstName,
        "lastName": lastName,
        "title": title,
        "company": company,
        "phone": phone,
        "phone2": phone2,
        "email": email,
        "website": website,
        "address": address,
        "address2": address2,
        "city": city,
        "state": state,
        "zipcode": zipcode,
        "country": country,
        "visibility": visibility,
        "assignedTo": assignedTo,
        "backgroundInfo": backgroundInfo,
        "twitter": twitter,
        "linkedIn": linkedIn,
        "skype": skype,
        "googlePlus": googlePlus,
        "lastUpdated": lastUpdated,
        "lastActivity": lastActivity,
        "updatedBy": updatedBy,
        "priority": priority,
        "leadSource": leadSource,
        "leadDate": leadDate,
        "rating": rating,
        "createDate": createDate,
        "facebook": facebook,
        "otherUrl": otherUrl,
        "leadType": leadType,
        "closeDate": closeDate,
        "expectedCloseDate": expectedCloseDate,
        "interest": interest,
        "leadStatus": leadStatus,
        "dealvalue": dealvalue,
        "leadscore": leadscore,
        "dealstatus": dealstatus,
        "timezone": timezone,
        "doNotCall": doNotCall,
        "doNotEmail": doNotEmail,
        "trackingKey": trackingKey,
        "dupeCheck": dupeCheck,
        "fingerprintId": fingerprintId,
        "accountName": accountName,
        "businessEmail": businessEmail,
        "personalEmail": personalEmail,
        "alternativeEmail": alternativeEmail,
        "preferredEmail": preferredEmail,
        "reverseIp": reverseIp,
      };
}
