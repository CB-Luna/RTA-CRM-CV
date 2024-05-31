import 'dart:convert';

class Circuits {
  int? id;
  DateTime? createdAt;
  int? pccid;
  String? rtaCustomer;
  String? cktstatus;
  String? gemap;
  String? carrier;
  String? ckttype;
  String? cktuse;
  String? cktid;
  String? evc;
  String? caracctnum;
  String? carcontid;
  int? contlength;
  String? street;
  String? state;
  String? city;
  int? zip;
  String? latitude;
  String? longitude;
  String? cir;
  String? port;
  String? handoff;
  String? apopstreet;
  String? apopcity;
  int? apopzip;
  String? apopstate;
  String? apoplat;
  String? apoplong;
  String? bpopstreet;
  String? bpopcity;
  String? bpopstate;
  int? bpopzip;
  String? bpoplat;
  String? bpoplong;
  String? notes;
  DateTime? contexp;

  Circuits({
    this.id,
    this.createdAt,
    this.pccid,
    this.rtaCustomer,
    this.cktstatus,
    this.gemap,
    this.carrier,
    this.ckttype,
    this.cktuse,
    this.cktid,
    this.evc,
    this.caracctnum,
    this.carcontid,
    this.contlength,
    this.street,
    this.state,
    this.city,
    this.zip,
    this.latitude,
    this.longitude,
    this.cir,
    this.port,
    this.handoff,
    this.apopstreet,
    this.apopcity,
    this.apopzip,
    this.apopstate,
    this.apoplat,
    this.apoplong,
    this.bpopstreet,
    this.bpopcity,
    this.bpopstate,
    this.bpopzip,
    this.bpoplat,
    this.bpoplong,
    this.notes,
    this.contexp,
  });

  factory Circuits.fromJson(String str) => Circuits.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Circuits.fromMap(Map<String, dynamic> json) => Circuits(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        pccid: json["pccid"],
        rtaCustomer: json["rta_customer"],
        cktstatus: json["cktstatus"],
        gemap: json["gemap"],
        carrier: json["carrier"],
        ckttype: json["ckttype"],
        cktuse: json["cktuse"],
        cktid: json["cktid"],
        evc: json["evc"],
        caracctnum: json["caracctnum"],
        carcontid: json["carcontid"],
        contlength: json["contlength"],
        street: json["street"],
        state: json["state"],
        city: json["city"],
        zip: json["zip"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        cir: json["cir"],
        port: json["port"],
        handoff: json["handoff"],
        apopstreet: json["apopstreet"],
        apopcity: json["apopcity"],
        apopzip: json["apopzip"],
        apopstate: json["apopstate"],
        apoplat: json["apoplat"],
        apoplong: json["apoplong"],
        bpopstreet: json["bpopstreet"],
        bpopcity: json["bpopcity"],
        bpopstate: json["bpopstate"],
        bpopzip: json["bpopzip"],
        bpoplat: json["bpoplat"],
        bpoplong: json["bpoplong"],
        notes: json["notes"],
        contexp:
            json["contexp"] == null ? null : DateTime.parse(json["contexp"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "pccid": pccid,
        "rta_customer": rtaCustomer,
        "cktstatus": cktstatus,
        "gemap": gemap,
        "carrier": carrier,
        "ckttype": ckttype,
        "cktuse": cktuse,
        "cktid": cktid,
        "evc": evc,
        "caracctnum": caracctnum,
        "carcontid": carcontid,
        "contlength": contlength,
        "street": street,
        "state": state,
        "city": city,
        "zip": zip,
        "latitude": latitude,
        "longitude": longitude,
        "cir": cir,
        "port": port,
        "handoff": handoff,
        "apopstreet": apopstreet,
        "apopcity": apopcity,
        "apopzip": apopzip,
        "apopstate": apopstate,
        "apoplat": apoplat,
        "apoplong": apoplong,
        "bpopstreet": bpopstreet,
        "bpopcity": bpopcity,
        "bpopstate": bpopstate,
        "bpopzip": bpopzip,
        "bpoplat": bpoplat,
        "bpoplong": bpoplong,
        "notes": notes,
        "contexp":
            "${contexp!.year.toString().padLeft(4, '0')}-${contexp!.month.toString().padLeft(2, '0')}-${contexp!.day.toString().padLeft(2, '0')}",
      };
}
