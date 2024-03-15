import 'dart:convert';

class ModelX2V2QuotesView {
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
  DateTime? expectedclosedate;
  String? currency;
  double? total;
  double? subtotal;
  double? margin;
  int? idvendor;
  String? vendor;
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
  String? demarcationUrl;
  String? demarcationName;

  ModelX2V2QuotesView({
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
    this.demarcationUrl,
    this.demarcationName,
  });

  factory ModelX2V2QuotesView.fromJson(String str) => ModelX2V2QuotesView.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelX2V2QuotesView.fromMap(Map<String, dynamic> json) => ModelX2V2QuotesView(
        quoteid: json["quoteid"],
        quote: json["quote"],
        x2Quoteid: json["x2quoteid"],
        probability: json["probability"] == "" || json["probability"] == null ? null : double.parse(json["probability"]),
        idStatus: json["id_status"],
        status: json["status"],
        description: json["description"],
        createdate: json["createdate"] == null ? null : DateTime.parse(json["createdate"]),
        assignedTo: json["assignedTo"],
        lastupdated: json["lastupdated"] == null ? null : DateTime.parse(json["lastupdated"]),
        lastactivity: json["lastactivity"] == null ? null : DateTime.parse(json["lastactivity"]),
        expectedclosedate: json["expectedclosedate"] == null ? null : DateTime.parse(json["expectedclosedate"]),
        currency: json["currency"],
        total: json["total"]?.toDouble(),
        subtotal: json["subtotal"]?.toDouble(),
        margin: json["margin"]?.toDouble(),
        idvendor: json["idvendor"],
        vendor: json["vendor"],
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
        demarcationUrl: json["demarcation_url"],
        demarcationName: json["demarcation_name"],
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
        "expectedclosedate": expectedclosedate?.toIso8601String(),
        "currency": currency,
        "total": total,
        "subtotal": subtotal,
        "margin": margin,
        "idvendor": idvendor,
        "vendor": vendor,
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
        "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toMap())),
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toMap())),
        "demarcation_url": demarcationUrl,
        "demarcation_name": demarcationName,
      };
}

class CircuitInfo {
  String? cir;
  String? ipType;
  String? bgpType;
  String? ipBlock;
  String? peeringType;
  String? location;
  String? bandwidth;
  bool? ddosType;
  bool? multicast;
  String? portSize;
  String? subnetType;
  String? circuitType;
  String? evcCircuitId;
  String? interfaceType;

  CircuitInfo({
    this.cir,
    this.ipType,
    this.bgpType,
    this.ipBlock,
    this.peeringType,
    this.location,
    this.bandwidth,
    this.ddosType,
    this.multicast,
    this.portSize,
    this.subnetType,
    this.circuitType,
    this.evcCircuitId,
    this.interfaceType,
  });

  factory CircuitInfo.fromJson(String str) => CircuitInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CircuitInfo.fromMap(Map<String, dynamic> json) => CircuitInfo(
        cir: json["cir"],
        ipType: json["ip_type"],
        bgpType: json["bgp_type"],
        ipBlock: json["ip_block"],
        peeringType: json["peering_type"],
        location: json["location"],
        bandwidth: json["bandwidth"],
        ddosType: json["ddos_type"],
        multicast: json["multicast"],
        portSize: json["port_size"],
        subnetType: json["subnet_type"],
        circuitType: json["circuit_type"],
        evcCircuitId: json["evc_circuit_id"],
        interfaceType: json["interface_type"],
      );

  Map<String, dynamic> toMap() => {
        "cir": cir,
        "ip_type": ipType,
        "bgp_type": bgpType,
        "ip_block": ipBlock,
        "peering_type": peeringType,
        "location": location,
        "bandwidth": bandwidth,
        "ddos_type": ddosType,
        "multicast": multicast,
        "port_size": portSize,
        "subnet_type": subnetType,
        "circuit_type": circuitType,
        "evc_circuit_id": evcCircuitId,
        "interface_type": interfaceType,
      };
}

class Comment {
  int? id;
  String? name;
  String? role;
  DateTime? sended;
  String? comment;

  Comment({
    this.id,
    this.name,
    this.role,
    this.sended,
    this.comment,
  });

  factory Comment.fromJson(String str) => Comment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        id: json["id"],
        name: json["name"],
        role: json["role"],
        sended: json["sended"] == null ? null : DateTime.parse(json["sended"]),
        comment: json["comment"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
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

class Item {
  int? quantity;
  String? lineItem;
  double? unitCost;
  double? unitPrice;
  int? idQuoteItem;

  Item({
    this.quantity,
    this.lineItem,
    this.unitCost,
    this.unitPrice,
    this.idQuoteItem,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        quantity: json["quantity"],
        lineItem: json["line_item"],
        unitCost: json["unit_cost"]?.toDouble(),
        unitPrice: json["unit_price"]?.toDouble(),
        idQuoteItem: json["id_quote_item"],
      );

  Map<String, dynamic> toMap() => {
        "quantity": quantity,
        "line_item": lineItem,
        "unit_cost": unitCost,
        "unit_price": unitPrice,
        "id_quote_item": idQuoteItem,
      };
}

class OrderInfo {
  String? type;
  String? address;
  String? handoff;
  String? orderType;
  String? rackLocation;
  String? newCircuitId;
  String? dataCenterType;
  String? demarcationPoint;
  String? existingCircuitId;
  String? dataCenterLocation;

  OrderInfo({
    this.type,
    this.address,
    this.handoff,
    this.orderType,
    this.rackLocation,
    this.newCircuitId,
    this.dataCenterType,
    this.demarcationPoint,
    this.existingCircuitId,
    this.dataCenterLocation,
  });

  factory OrderInfo.fromJson(String str) => OrderInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderInfo.fromMap(Map<String, dynamic> json) => OrderInfo(
        type: json["type"],
        address: json["address"],
        handoff: json["handoff"],
        orderType: json["order_type"],
        rackLocation: json["rack_location"],
        newCircuitId: json["new_circuit_id"],
        dataCenterType: json["data_center_type"],
        demarcationPoint: json["demarcation_point"],
        existingCircuitId: json["existing_circuit_id"],
        dataCenterLocation: json["data_center_location"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "address": address,
        "handoff": handoff,
        "order_type": orderType,
        "rack_location": rackLocation,
        "new_circuit_id": newCircuitId,
        "data_center_type": dataCenterType,
        "demarcation_point": demarcationPoint,
        "existing_circuit_id": existingCircuitId,
        "data_center_location": dataCenterLocation,
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

  factory Totals.fromJson(String str) => Totals.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Totals.fromMap(Map<String, dynamic> json) => Totals(
        tax: json["tax"]?.toDouble(),
        cost: json["cost"]?.toDouble(),
        items: json["items"],
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
