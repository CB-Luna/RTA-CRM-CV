// To parse this JSON data, do
//
//     final modelX2QuotesView = modelX2QuotesViewFromMap(jsonString);

import 'dart:convert';

import 'package:rta_crm_cv/models/crm/accounts/quotes_model.dart';

class ModelX2QuotesView {
  int? quoteid;
  String? quote;
  String? x2Quoteid;
  double? probability;
  int? idStatus;
  String? status;
  String? description;
  DateTime? createdate;
  String? assignedTo;
  DateTime? lastupdated;
  DateTime? lastactivity;
  String? expectedclosedate;
  String? currency;
  double? total;
  double? subtotal;
  double? margin;
  int? idVendor;
  String? vendor;
  String? dataCenter;
  String? order;
  int? accountid;
  String? account;
  String? x2Accountid;
  String? accountdescription;
  String? accountphone;
  String? accountemail;
  String? company;
  String? accountaddress;
  String? accountcity;
  String? accountzipcode;
  String? accountstate;
  String? accountcountry;
  int? contactid;
  String? contactfirstname;
  String? contactlastname;
  String? x2Contactid;
  String? contactphone;
  String? contactemail;
  int? idOrders;
  CircuitInfo? circuitInfo;
  OrderInfo? orderInfo;
  CustomerInfo? customerInfo;
  Totals? totals;
  List<Comment>? comments;
  List<Item>? items;

  ModelX2QuotesView({
    this.quoteid,
    this.quote,
    this.x2Quoteid,
    this.probability,
    this.idStatus,
    this.status,
    this.description,
    this.createdate,
    this.assignedTo,
    this.lastupdated,
    this.lastactivity,
    this.expectedclosedate,
    this.currency,
    this.total,
    this.subtotal,
    this.margin,
    this.idVendor,
    this.vendor,
    this.dataCenter,
    this.order,
    this.accountid,
    this.account,
    this.x2Accountid,
    this.accountdescription,
    this.accountphone,
    this.accountemail,
    this.company,
    this.accountaddress,
    this.accountcity,
    this.accountzipcode,
    this.accountstate,
    this.accountcountry,
    this.contactid,
    this.contactfirstname,
    this.contactlastname,
    this.x2Contactid,
    this.contactphone,
    this.contactemail,
    this.idOrders,
    this.circuitInfo,
    this.orderInfo,
    this.customerInfo,
    this.totals,
    this.comments,
    this.items,
  });

  factory ModelX2QuotesView.fromJson(String str) => ModelX2QuotesView.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelX2QuotesView.fromMap(Map<String, dynamic> json) => ModelX2QuotesView(
        quoteid: json["quoteid"],
        quote: json["quote"],
        x2Quoteid: json["x2quoteid"],
        probability: json["probability"]?.toDouble(),
        idStatus: json["id_status"],
        status: json["status"],
        description: json["description"],
        createdate: json["createdate"] == null ? null : DateTime.parse(json["createdate"]),
        assignedTo: json["assignedTo"],
        lastupdated: json["lastupdated"] == null ? null : DateTime.parse(json["lastupdated"]),
        lastactivity: json["lastactivity"] == null ? null : DateTime.parse(json["lastactivity"]),
        expectedclosedate: json["expectedclosedate"],
        currency: json["currency"],
        total: json["total"]?.toDouble(),
        subtotal: json["subtotal"]?.toDouble(),
        margin: json["margin"]?.toDouble(),
        idVendor: json["idvendor"],
        vendor: json["vendor"],
        dataCenter: json["data_center"],
        order: json["order"],
        accountid: json["accountid"],
        account: json["account"],
        x2Accountid: json["x2accountid"],
        accountdescription: json["accountdescription"],
        accountphone: json["accountphone"],
        accountemail: json["accountemail"],
        company: json["company"],
        accountaddress: json["accountaddress"],
        accountcity: json["accountcity"],
        accountzipcode: json["accountzipcode"],
        accountstate: json["accountstate"],
        accountcountry: json["accountcountry"],
        contactid: json["contactid"],
        contactfirstname: json["contactfirstname"],
        contactlastname: json["contactlastname"],
        x2Contactid: json["x2contactid"],
        contactphone: json["contactphone"],
        contactemail: json["contactemail"],
        idOrders: json["id_orders"],
        circuitInfo: json["circuit_info"] == null ? null : CircuitInfo.fromMap(json["circuit_info"]),
        orderInfo: json["order_info"] == null ? null : OrderInfo.fromMap(json["order_info"]),
        customerInfo: json["customer_info"] == null ? null : CustomerInfo.fromMap(json["customer_info"]),
        totals: json["totals"] == null ? null : Totals.fromMap(json["totals"]),
        comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromMap(x))),
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "quoteid": quoteid,
        "quote": quote,
        "x2quoteid": x2Quoteid,
        "probability": probability,
        "id_status": idStatus,
        "status": status,
        "description": description,
        "createdate": createdate?.toIso8601String(),
        "assignedTo": assignedTo,
        "lastupdated": lastupdated?.toIso8601String(),
        "lastactivity": lastactivity?.toIso8601String(),
        "expectedclosedate": expectedclosedate,
        "currency": currency,
        "total": total,
        "subtotal": subtotal,
        "margin": margin,
        "idvendor": idVendor,
        "vendor": vendor,
        "data_center": dataCenter,
        "order": order,
        "accountid": accountid,
        "account": account,
        "x2accountid": x2Accountid,
        "accountdescription": accountdescription,
        "accountphone": accountphone,
        "accountemail": accountemail,
        "company": company,
        "accountaddress": accountaddress,
        "accountcity": accountcity,
        "accountzipcode": accountzipcode,
        "accountstate": accountstate,
        "accountcountry": accountcountry,
        "contactid": contactid,
        "contactfirstname": contactfirstname,
        "contactlastname": contactlastname,
        "x2contactid": x2Contactid,
        "contactphone": contactphone,
        "contactemail": contactemail,
        "id_orders": idOrders,
        "circuit_info": circuitInfo?.toMap(),
        "order_info": orderInfo?.toMap(),
        "customer_info": customerInfo?.toMap(),
        "totals": totals?.toMap(),
        "comments": comments == null ? [] : List<dynamic>.from(items!.map((x) => x.toMap())),
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toMap())),
      };
}

class CircuitInfo {
  String? cir;
  String? ipType;
  String? bgpType;
  String? ddosType;
  String? portSize;
  String? circuitType;
  String? interfaceType;
  String? evcodType;
  String? evcCircuitId;
  String? subnetType;

  CircuitInfo({
    this.cir,
    this.ipType,
    this.bgpType,
    this.ddosType,
    this.portSize,
    this.circuitType,
    this.interfaceType,
    this.evcodType,
    this.evcCircuitId,
    this.subnetType,
  });

  factory CircuitInfo.fromJson(String str) => CircuitInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CircuitInfo.fromMap(Map<String, dynamic> json) => CircuitInfo(
        cir: json["cir"],
        ipType: json["ip_type"],
        bgpType: json["bgp_type"],
        ddosType: json["ddos_type"],
        portSize: json["port_size"],
        circuitType: json["circuit_type"],
        interfaceType: json["interface_type"],
        evcodType: json["evcod_type"],
        evcCircuitId: json["evc_circuit_id"],
        subnetType: json["subnet_type"],
      );

  Map<String, dynamic> toMap() => {
        "cir": cir,
        "ip_type": ipType,
        "bgp_type": bgpType,
        "ddos_type": ddosType,
        "port_size": portSize,
        "circuit_type": circuitType,
        "interface_type": interfaceType,
        "evcod_type": evcodType,
        "evc_circuit_id": evcCircuitId,
        "subnet_type": subnetType,
      };
}

class CustomerInfo {
  String? name;
  String? email;
  String? phone;
  String? company;

  CustomerInfo({
    this.name,
    this.email,
    this.phone,
    this.company,
  });

  factory CustomerInfo.fromJson(String str) => CustomerInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CustomerInfo.fromMap(Map<String, dynamic> json) => CustomerInfo(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        company: json["company"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "phone": phone,
        "company": company,
      };
}

class OrderInfo {
  String type;
  String orderType;
  String? newCircuitId;
  String dataCenterType;
  String dataCenterLocation;
  String? existingCircuitId;

  OrderInfo({
    required this.type,
    required this.orderType,
    this.newCircuitId,
    required this.dataCenterType,
    required this.dataCenterLocation,
    this.existingCircuitId,
  });

  factory OrderInfo.fromJson(String str) => OrderInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderInfo.fromMap(Map<String, dynamic> json) => OrderInfo(
        type: json["type"],
        orderType: json["order_type"],
        newCircuitId: json["new_circuit_id"],
        dataCenterType: json["data_center_type"],
        dataCenterLocation: json["data_center_location"],
        existingCircuitId: json["existing_circuit_id"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "order_type": orderType,
        "new_circuit_id": newCircuitId,
        "data_center_type": dataCenterType,
        "data_center_location": dataCenterLocation,
        "existing_circuit_id": existingCircuitId,
      };
}

class Item {
  int? id;
  double? quantity;
  String? lineItem;
  double? unitCost;
  double? unitPrice;

  Item({
    this.id,
    this.quantity,
    this.lineItem,
    this.unitCost,
    this.unitPrice,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id_quote_item"],
        quantity: json["quantity"]?.toDouble(),
        lineItem: json["line_item"],
        unitCost: json["unit_cost"]?.toDouble(),
        unitPrice: json["unit_price"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id_quote_item": id,
        "quantity": quantity,
        "line_item": lineItem,
        "unit_cost": unitCost,
        "unit_price": unitPrice,
      };
}

class Totals {
  double tax;
  double cost;
  double items;
  double total;
  double margin;
  double subtotal;
  double totalTax;

  Totals({
    required this.tax,
    required this.cost,
    required this.items,
    required this.total,
    required this.margin,
    required this.subtotal,
    required this.totalTax,
  });

  factory Totals.fromJson(String str) => Totals.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Totals.fromMap(Map<String, dynamic> json) => Totals(
        tax: json["tax"]?.toDouble(),
        cost: json["cost"]?.toDouble(),
        items: json["items"]?.toDouble(),
        total: json["total"]?.toDouble(),
        margin: json["margin"]?.toDouble(),
        subtotal: json["subtotal"]?.toDouble(),
        totalTax: json["total_tax"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "tax": tax,
        "cost": cost,
        "items": items,
        "total": total,
        "margin": margin,
        "subtotal": subtotal,
        "total_tax": totalTax,
      };
}
