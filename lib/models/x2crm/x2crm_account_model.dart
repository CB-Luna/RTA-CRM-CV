// To parse this JSON data, do
//
//     final x2CrmAccount = x2CrmAccountFromMap(jsonString);

import 'dart:convert';

class X2CrmAccount {
  String? address;
  dynamic address2;
  String? alternativeEmail;
  String? annualRevenue;
  String? assignedTo;
  dynamic backgroundInfo;
  String? businessEmail;
  String? city;
  DateTime? closedate;
  String? country;
  String? createDate;
  String? dealstatus;
  String? dealvalue;
  String? description;
  String? doNotCall;
  String? doNotEmail;
  String? email;
  dynamic employees;
  DateTime? expectedCloseDate;
  dynamic facebook;
  dynamic googleplus;
  String? id;
  String? interest;
  String? lastActivity;
  String? lastUpdated;
  DateTime? leadDate;
  dynamic leadscore;
  String? leadSource;
  String? leadstatus;
  String? leadtype;
  dynamic linkedin;
  dynamic modelName;
  String? name;
  String? nameId;
  String? otherUrl;
  String? parentAccount;
  String? personalEmail;
  String? phone;
  String? phone2;
  dynamic preferredEmail;
  dynamic primaryContact;
  dynamic priority;
  dynamic rating;
  dynamic skype;
  String? state;
  String? tickerSymbol;
  dynamic timezone;
  dynamic title;
  dynamic trackingKey;
  dynamic twitter;
  String? type;
  String? updatedBy;
  String? visibility;
  String? website;
  String? zipcode;

  X2CrmAccount({
    this.address,
    this.address2,
    this.alternativeEmail,
    this.annualRevenue,
    this.assignedTo,
    this.backgroundInfo,
    this.businessEmail,
    this.city,
    this.closedate,
    this.country,
    this.createDate,
    this.dealstatus,
    this.dealvalue,
    this.description,
    this.doNotCall,
    this.doNotEmail,
    this.email,
    this.employees,
    this.expectedCloseDate,
    this.facebook,
    this.googleplus,
    this.id,
    this.interest,
    this.lastActivity,
    this.lastUpdated,
    this.leadDate,
    this.leadscore,
    this.leadSource,
    this.leadstatus,
    this.leadtype,
    this.linkedin,
    this.modelName,
    this.name,
    this.nameId,
    this.otherUrl,
    this.parentAccount,
    this.personalEmail,
    this.phone,
    this.phone2,
    this.preferredEmail,
    this.primaryContact,
    this.priority,
    this.rating,
    this.skype,
    this.state,
    this.tickerSymbol,
    this.timezone,
    this.title,
    this.trackingKey,
    this.twitter,
    this.type,
    this.updatedBy,
    this.visibility,
    this.website,
    this.zipcode,
  });

  factory X2CrmAccount.fromJson(String str) => X2CrmAccount.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory X2CrmAccount.fromMap(Map<String, dynamic> json) => X2CrmAccount(
        address: json["address"],
        address2: json["address2"],
        alternativeEmail: json["alternativeEmail"],
        annualRevenue: json["annualRevenue"],
        assignedTo: json["assignedTo"],
        backgroundInfo: json["backgroundInfo"],
        businessEmail: json["businessEmail"],
        city: json["city"],
        closedate: json["closedate"] == null ? null : DateTime.parse(json["closedate"]),
        country: json["country"],
        createDate: json["createDate"],
        dealstatus: json["dealstatus"],
        dealvalue: json["dealvalue"],
        description: json["description"],
        doNotCall: json["doNotCall"],
        doNotEmail: json["doNotEmail"],
        email: json["email"],
        employees: json["employees"],
        expectedCloseDate: json["expectedCloseDate"] == null ? null : DateTime.parse(json["expectedCloseDate"]),
        facebook: json["facebook"],
        googleplus: json["googleplus"],
        id: json["id"],
        interest: json["interest"],
        lastActivity: json["lastActivity"],
        lastUpdated: json["lastUpdated"],
        leadDate: json["leadDate"] == null ? null : DateTime.parse(json["leadDate"]),
        leadscore: json["leadscore"],
        leadSource: json["leadSource"],
        leadstatus: json["leadstatus"],
        leadtype: json["leadtype"],
        linkedin: json["linkedin"],
        modelName: json["modelName"],
        name: json["name"],
        nameId: json["nameId"],
        otherUrl: json["otherUrl"],
        parentAccount: json["parentAccount"],
        personalEmail: json["personalEmail"],
        phone: json["phone"],
        phone2: json["phone2"],
        preferredEmail: json["preferredEmail"],
        primaryContact: json["primaryContact"],
        priority: json["priority"],
        rating: json["rating"],
        skype: json["skype"],
        state: json["state"],
        tickerSymbol: json["tickerSymbol"],
        timezone: json["timezone"],
        title: json["title"],
        trackingKey: json["trackingKey"],
        twitter: json["twitter"],
        type: json["type"],
        updatedBy: json["updatedBy"],
        visibility: json["visibility"],
        website: json["website"],
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toMap() => {
        "address": address,
        "address2": address2,
        "alternativeEmail": alternativeEmail,
        "annualRevenue": annualRevenue,
        "assignedTo": assignedTo,
        "backgroundInfo": backgroundInfo,
        "businessEmail": businessEmail,
        "city": city,
        "closedate": "${closedate!.year.toString().padLeft(4, '0')}-${closedate!.month.toString().padLeft(2, '0')}-${closedate!.day.toString().padLeft(2, '0')}",
        "country": country,
        "createDate": createDate,
        "dealstatus": dealstatus,
        "dealvalue": dealvalue,
        "description": description,
        "doNotCall": doNotCall,
        "doNotEmail": doNotEmail,
        "email": email,
        "employees": employees,
        "expectedCloseDate": "${expectedCloseDate!.year.toString().padLeft(4, '0')}-${expectedCloseDate!.month.toString().padLeft(2, '0')}-${expectedCloseDate!.day.toString().padLeft(2, '0')}",
        "facebook": facebook,
        "googleplus": googleplus,
        "id": id,
        "interest": interest,
        "lastActivity": lastActivity,
        "lastUpdated": lastUpdated,
        "leadDate": "${leadDate!.year.toString().padLeft(4, '0')}-${leadDate!.month.toString().padLeft(2, '0')}-${leadDate!.day.toString().padLeft(2, '0')}",
        "leadscore": leadscore,
        "leadSource": leadSource,
        "leadstatus": leadstatus,
        "leadtype": leadtype,
        "linkedin": linkedin,
        "modelName": modelName,
        "name": name,
        "nameId": nameId,
        "otherUrl": otherUrl,
        "parentAccount": parentAccount,
        "personalEmail": personalEmail,
        "phone": phone,
        "phone2": phone2,
        "preferredEmail": preferredEmail,
        "primaryContact": primaryContact,
        "priority": priority,
        "rating": rating,
        "skype": skype,
        "state": state,
        "tickerSymbol": tickerSymbol,
        "timezone": timezone,
        "title": title,
        "trackingKey": trackingKey,
        "twitter": twitter,
        "type": type,
        "updatedBy": updatedBy,
        "visibility": visibility,
        "website": website,
        "zipcode": zipcode,
      };
}
