// To parse this JSON data, do
//
//     final modelX2QuotesView = modelX2QuotesViewFromJson(jsonString);

import 'dart:convert';

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
  int? idvendor;
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
    this.idvendor,
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

  factory ModelX2QuotesView.fromRawJson(String str) => ModelX2QuotesView.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelX2QuotesView.fromJson(Map<String, dynamic> json) => ModelX2QuotesView(
        quoteid: json["quoteid"],
        quote: json["quote"],
        x2Quoteid: json["x2quoteid"],
        probability: json["probability"],
        idStatus: json["id_status"],
        status: json["status"],
        description: json["description"],
        createdate: json["createdate"] == null ? null : DateTime.parse(json["createdate"]),
        assignedTo: json["assignedTo"],
        lastupdated: json["lastupdated"] == null ? null : DateTime.parse(json["lastupdated"]),
        lastactivity: json["lastactivity"] == null ? null : DateTime.parse(json["lastactivity"]),
        expectedclosedate: json["expectedclosedate"],
        currency: json["currency"],
        total: json["total"],
        subtotal: json["subtotal"],
        margin: json["margin"],
        idvendor: json["idvendor"],
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
        circuitInfo: json["circuit_info"] == null ? null : CircuitInfo.fromJson(json["circuit_info"]),
        orderInfo: json["order_info"] == null ? null : OrderInfo.fromJson(json["order_info"]),
        customerInfo: json["customer_info"] == null ? null : CustomerInfo.fromJson(json["customer_info"]),
        totals: json["totals"] == null ? null : Totals.fromJson(json["totals"]),
        comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
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
        "idvendor": idvendor,
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
        "circuit_info": circuitInfo?.toJson(),
        "order_info": orderInfo?.toJson(),
        "customer_info": customerInfo?.toJson(),
        "totals": totals?.toJson(),
        "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class CircuitInfo {
  String? cir;

  String? ipType;
  String? bgpType;
  bool? ddosType;
  bool? multicast;
  String? portSize;
  String? subnetType;
  String? circuitType;
  String? evcCircuitId;
  String? interfaceType;
  String? location;

  CircuitInfo({
    this.cir,
    this.ipType,
    this.bgpType,
    this.ddosType,
    this.multicast,
    this.portSize,
    this.subnetType,
    this.circuitType,
    this.evcCircuitId,
    this.interfaceType,
    this.location,
  });

  factory CircuitInfo.fromRawJson(String str) => CircuitInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CircuitInfo.fromJson(Map<String, dynamic> json) => CircuitInfo(
        cir: json["cir"],
        ipType: json["ip_type"],
        bgpType: json["bgp_type"],
        ddosType: json["ddos_type"],
        multicast: json["multicast"],
        portSize: json["port_size"],
        subnetType: json["subnet_type"],
        circuitType: json["circuit_type"],
        evcCircuitId: json["evc_circuit_id"],
        interfaceType: json["interface_type"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "cir": cir,
        "ip_type": ipType,
        "bgp_type": bgpType,
        "ddos_type": ddosType,
        "multicast": multicast,
        "port_size": portSize,
        "subnet_type": subnetType,
        "circuit_type": circuitType,
        "evc_circuit_id": evcCircuitId,
        "interface_type": interfaceType,
        "location": location,
      };
}

class Comment {
  String? name;
  String? role;
  DateTime? sended;
  String? comment;

  Comment({
    this.name,
    this.role,
    this.sended,
    this.comment,
  });

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        name: json["name"],
        role: json["role"],
        sended: json["sended"] == null ? null : DateTime.parse(json["sended"]),
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "role": role,
        "sended": sended?.toIso8601String(),
        "comment": comment,
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

  factory CustomerInfo.fromRawJson(String str) => CustomerInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        company: json["company"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "company": company,
      };
}

class Item {
  int? quantity;
  String? lineItem;
  int? unitCost;
  int? unitPrice;
  int? idQuoteItem;

  Item({
    this.quantity,
    this.lineItem,
    this.unitCost,
    this.unitPrice,
    this.idQuoteItem,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        quantity: json["quantity"],
        lineItem: json["line_item"],
        unitCost: json["unit_cost"],
        unitPrice: json["unit_price"],
        idQuoteItem: json["id_quote_item"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "line_item": lineItem,
        "unit_cost": unitCost,
        "unit_price": unitPrice,
        "id_quote_item": idQuoteItem,
      };
}

class OrderInfo {
  String? type;
  String? orderType;
  String? rackLocation;
  String? handoff;
  String? dataCenterType;
  String? demarcationPoint;
  String? existingCircuitId;
  String? dataCenterLocation;
  String? newCircuitId;

  OrderInfo({
    this.type,
    this.orderType,
    this.rackLocation,
    this.handoff,
    this.dataCenterType,
    this.demarcationPoint,
    this.existingCircuitId,
    this.dataCenterLocation,
    this.newCircuitId,
  });

  factory OrderInfo.fromRawJson(String str) => OrderInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
        type: json["type"],
        orderType: json["order_type"],
        rackLocation: json["rack_location"],
        handoff: json["handoff"],
        dataCenterType: json["data_center_type"],
        demarcationPoint: json["demarcation_point"],
        existingCircuitId: json["existing_circuit_id"],
        dataCenterLocation: json["data_center_location"],
        newCircuitId: json["new_circuit_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "order_type": orderType,
        "rack_location": rackLocation,
        "handoff": handoff,
        "data_center_type": dataCenterType,
        "demarcation_point": demarcationPoint,
        "existing_circuit_id": existingCircuitId,
        "data_center_location": dataCenterLocation,
        "new_circuit_id": newCircuitId,
      };
}

class Totals {
  double? tax;
  double? cost;
  int? items;
  double? total;
  double? margin;
  double? subtotal;
  double? totalTax;

  Totals({
    this.tax,
    this.cost,
    this.items,
    this.total,
    this.margin,
    this.subtotal,
    this.totalTax,
  });

  factory Totals.fromRawJson(String str) => Totals.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Totals.fromJson(Map<String, dynamic> json) => Totals(
        tax: json["tax"],
        cost: json["cost"],
        items: json["items"],
        total: json["total"]?.toDouble(),
        margin: json["margin"],
        subtotal: json["subtotal"]?.toDouble(),
        totalTax: json["total_tax"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "tax": tax,
        "cost": cost,
        "items": items,
        "total": total,
        "margin": margin,
        "subtotal": subtotal,
        "total_tax": totalTax,
      };
}
