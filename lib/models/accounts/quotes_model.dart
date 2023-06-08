import 'dart:convert';

class Quotes {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  String updatedBy;
  String status;
  DateTime expCloseDate;
  double subtotal;
  double cost;
  double total;
  double tax;
  double totalPlusTax;
  double margin;
  double probability;
  OrderInfo orderInfo;
  List<Item> items;
  List<Comment> comments;
  String idQuoteOrigin;
  int idLead;
  int idVendor;
  String nameVendor;
  String nameLead;
  String assignedTo;
  int leadProbability;
  DateTime expectedClose;

  Quotes({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.updatedBy,
    required this.status,
    required this.expCloseDate,
    required this.subtotal,
    required this.cost,
    required this.total,
    required this.tax,
    required this.totalPlusTax,
    required this.margin,
    required this.probability,
    required this.orderInfo,
    required this.items,
    required this.comments,
    required this.idQuoteOrigin,
    required this.idLead,
    required this.idVendor,
    required this.nameVendor,
    required this.nameLead,
    required this.assignedTo,
    required this.leadProbability,
    required this.expectedClose,
  });

  factory Quotes.fromJson(String str) => Quotes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Quotes.fromMap(Map<String, dynamic> json) => Quotes(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        status: json["status"],
        expCloseDate: DateTime.parse(json["exp_close_date"]),
        subtotal: json["subtotal"],
        cost: json["cost"]?.toDouble(),
        total: json["total"]?.toDouble(),
        tax: json["tax"]?.toDouble(),
        totalPlusTax: json["total_plus_tax"]?.toDouble(),
        margin: json["margin"]?.toDouble(),
        probability: json["probability"],
        orderInfo: OrderInfo.fromMap(json["order_info"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromMap(x))),
        idQuoteOrigin: json["id_quote_origin"],
        idLead: json["id_lead"],
        idVendor: json["id_vendor"],
        nameVendor: json["vendor_name"],
        nameLead: json["name_lead"],
        assignedTo: json["assigned_to"],
        leadProbability: json["lead_probability"],
        expectedClose: DateTime.parse(json["expected_close"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "created_by": createdBy,
        "updated_by": updatedBy,
        "status": status,
        "exp_close_date": expCloseDate.toIso8601String(),
        "subtotal": subtotal,
        "cost": cost,
        "total": total,
        "tax": tax,
        "total_plus_tax": totalPlusTax,
        "margin": margin,
        "probability": probability,
        "order_info": orderInfo.toMap(),
        "items": List<dynamic>.from(items.map((x) => x.toMap())),
        "comments": comments.isEmpty ? [] : List<dynamic>.from(comments.map((x) => x.toMap())),
        "id_quote_origin": idQuoteOrigin,
        "id_lead": idLead,
        "id_vendor": idVendor,
        "vendor_name": nameVendor,
        "name_lead": nameLead,
        "assigned_to": assignedTo,
        "lead_probability": leadProbability,
        "expected_close": expectedClose.toIso8601String(),
      };
}

class Comment {
  String role;
  String name;
  String comment;
  DateTime sended;

  Comment({
    required this.role,
    required this.name,
    required this.comment,
    required this.sended,
  });

  factory Comment.fromJson(String str) => Comment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        role: json["role"],
        name: json["name"],
        comment: json["comment"],
        sended: DateTime.parse(json["sended"]),
      );

  Map<String, dynamic> toMap() => {
        "role": role,
        "name": name,
        "comment": comment,
        "sended": sended.toIso8601String(),
      };
}

class Item {
  int quantity;
  String lineItem;
  double unitCost;
  double unitPrice;

  Item({
    required this.quantity,
    required this.lineItem,
    required this.unitCost,
    required this.unitPrice,
  });

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        quantity: json["quantity"],
        lineItem: json["line_item"],
        unitCost: json["unit_cost"],
        unitPrice: json["unit_price"],
      );

  Map<String, dynamic> toMap() => {
        "quantity": quantity,
        "line_item": lineItem,
        "unit_cost": unitCost,
        "unit_price": unitPrice,
      };
}

class OrderInfo {
  String type;
  String ipType;
  String bgpType;
  String ddosType;
  String orderType;
  String circuitType;
  String? interfaceType;
  String dataCenterType;
  String dataCenterLocation;
  String? evcodType;
  String? subnetType;
  String? evcCircuitId;
  String? newCircuitId;
  String? existingCircuitId;

  OrderInfo({
    required this.type,
    required this.ipType,
    required this.bgpType,
    required this.ddosType,
    required this.orderType,
    required this.circuitType,
    this.interfaceType,
    required this.dataCenterType,
    required this.dataCenterLocation,
    this.evcodType,
    this.subnetType,
    this.evcCircuitId,
    this.newCircuitId,
    this.existingCircuitId,
  });

  factory OrderInfo.fromJson(String str) => OrderInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderInfo.fromMap(Map<String, dynamic> json) => OrderInfo(
        type: json["type"],
        ipType: json["ip_type"],
        bgpType: json["bgp_type"],
        ddosType: json["ddos_type"],
        orderType: json["order_type"],
        circuitType: json["circuit_type"],
        interfaceType: json["interface_type"],
        dataCenterType: json["data_center_type"],
        dataCenterLocation: json["data_center_location"],
        evcodType: json["evcod_type"],
        subnetType: json["subnet_type"],
        evcCircuitId: json["evc_circuit_id"],
        newCircuitId: json["new_circuit_id"],
        existingCircuitId: json["existing_circuit_id"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "ip_type": ipType,
        "bgp_type": bgpType,
        "ddos_type": ddosType,
        "order_type": orderType,
        "circuit_type": circuitType,
        "interface_type": interfaceType,
        "data_center_type": dataCenterType,
        "data_center_location": dataCenterLocation,
        "evcod_type": evcodType,
        "subnet_type": subnetType,
        "evc_circuit_id": evcCircuitId,
        "new_circuit_id": newCircuitId,
        "existing_circuit_id": existingCircuitId,
      };
}
