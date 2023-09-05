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
  String? website;
  String? type;
  String? title;
  String? visibility;
  String? annualRevenue;
  String? phone;
  String? email;
  String? twitter;
  String? linkedin;
  String? skype;
  String? googleplus;
  String? otherUrl;
  String? company;
  String? modelName;
  String? tickerSymbol;
  String? employees;
  String? address;
  String? address2;
  String? city;
  String? state;
  String? country;
  String? zipcode;
  String? backgroundInfo;
  String? priority;
  String? parentAccount;
  String? primaryContact;
  String? assignedTo;
  String? createDate;
  String? facebook;
  String? timezone;
  String? associatedContacts;
  String? description;
  String? lastUpdated;
  String? lastActivity;
  String? updatedBy;
  String? dupeCheck;
  String? trackingKey;
  String? leadtype;
  String? leadSource;
  String? leadstatus;
  String? leadDate;
  String? leadscore;
  String? interest;
  String? dealvalue;
  String? closedate;
  String? rating;
  String? dealstatus;
  String? expectedCloseDate;
  String? doNotCall;
  String? doNotEmail;
  String? businessEmail;
  String? personalEmail;
  String? alternativeEmail;
  String? preferredEmail;

  ModelX2Accounts({
    this.id,
    this.name,
    this.nameId,
    this.firstName,
    this.lastName,
    this.website,
    this.type,
    this.title,
    this.visibility,
    this.annualRevenue,
    this.phone,
    this.email,
    this.twitter,
    this.linkedin,
    this.skype,
    this.googleplus,
    this.otherUrl,
    this.company,
    this.modelName,
    this.tickerSymbol,
    this.employees,
    this.address,
    this.address2,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.backgroundInfo,
    this.priority,
    this.parentAccount,
    this.primaryContact,
    this.assignedTo,
    this.createDate,
    this.facebook,
    this.timezone,
    this.associatedContacts,
    this.description,
    this.lastUpdated,
    this.lastActivity,
    this.updatedBy,
    this.dupeCheck,
    this.trackingKey,
    this.leadtype,
    this.leadSource,
    this.leadstatus,
    this.leadDate,
    this.leadscore,
    this.interest,
    this.dealvalue,
    this.closedate,
    this.rating,
    this.dealstatus,
    this.expectedCloseDate,
    this.doNotCall,
    this.doNotEmail,
    this.businessEmail,
    this.personalEmail,
    this.alternativeEmail,
    this.preferredEmail,
  });

  factory ModelX2Accounts.fromJson(String str) => ModelX2Accounts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelX2Accounts.fromMap(Map<String, dynamic> json) => ModelX2Accounts(
        id: json["id"],
        name: json["name"],
        nameId: json["nameId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        website: json["website"],
        type: json["type"],
        title: json["title"],
        visibility: json["visibility"],
        annualRevenue: json["annualRevenue"],
        phone: json["phone"],
        email: json["email"],
        twitter: json["twitter"],
        linkedin: json["linkedin"],
        skype: json["skype"],
        googleplus: json["googleplus"],
        otherUrl: json["otherUrl"],
        company: json["company"],
        modelName: json["modelName"],
        tickerSymbol: json["tickerSymbol"],
        employees: json["employees"],
        address: json["address"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipcode: json["zipcode"],
        backgroundInfo: json["backgroundInfo"],
        priority: json["priority"],
        parentAccount: json["parentAccount"],
        primaryContact: json["primaryContact"],
        assignedTo: json["assignedTo"],
        createDate: json["createDate"],
        facebook: json["facebook"],
        timezone: json["timezone"],
        associatedContacts: json["associatedContacts"],
        description: json["description"],
        lastUpdated: json["lastUpdated"],
        lastActivity: json["lastActivity"],
        updatedBy: json["updatedBy"],
        dupeCheck: json["dupeCheck"],
        trackingKey: json["trackingKey"],
        leadtype: json["leadtype"],
        leadSource: json["leadSource"],
        leadstatus: json["leadstatus"],
        leadDate: json["leadDate"],
        leadscore: json["leadscore"],
        interest: json["interest"],
        dealvalue: json["dealvalue"],
        closedate: json["closedate"],
        rating: json["rating"],
        dealstatus: json["dealstatus"],
        expectedCloseDate: json["expectedCloseDate"],
        doNotCall: json["doNotCall"],
        doNotEmail: json["doNotEmail"],
        businessEmail: json["businessEmail"],
        personalEmail: json["personalEmail"],
        alternativeEmail: json["alternativeEmail"],
        preferredEmail: json["preferredEmail"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "nameId": nameId,
        "firstName": firstName,
        "lastName": lastName,
        "website": website,
        "type": type,
        "title": title,
        "visibility": visibility,
        "annualRevenue": annualRevenue,
        "phone": phone,
        "email": email,
        "twitter": twitter,
        "linkedin": linkedin,
        "skype": skype,
        "googleplus": googleplus,
        "otherUrl": otherUrl,
        "company": company,
        "modelName": modelName,
        "tickerSymbol": tickerSymbol,
        "employees": employees,
        "address": address,
        "address2": address2,
        "city": city,
        "state": state,
        "country": country,
        "zipcode": zipcode,
        "backgroundInfo": backgroundInfo,
        "priority": priority,
        "parentAccount": parentAccount,
        "primaryContact": primaryContact,
        "assignedTo": assignedTo,
        "createDate": createDate,
        "facebook": facebook,
        "timezone": timezone,
        "associatedContacts": associatedContacts,
        "description": description,
        "lastUpdated": lastUpdated,
        "lastActivity": lastActivity,
        "updatedBy": updatedBy,
        "dupeCheck": dupeCheck,
        "trackingKey": trackingKey,
        "leadtype": leadtype,
        "leadSource": leadSource,
        "leadstatus": leadstatus,
        "leadDate": leadDate,
        "leadscore": leadscore,
        "interest": interest,
        "dealvalue": dealvalue,
        "closedate": closedate,
        "rating": rating,
        "dealstatus": dealstatus,
        "expectedCloseDate": expectedCloseDate,
        "doNotCall": doNotCall,
        "doNotEmail": doNotEmail,
        "businessEmail": businessEmail,
        "personalEmail": personalEmail,
        "alternativeEmail": alternativeEmail,
        "preferredEmail": preferredEmail,
      };
}
