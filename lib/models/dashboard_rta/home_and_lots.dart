import 'dart:convert';

class HomeAndLots {
  int? id;
  DateTime? createdAt;
  double? lotsPassedTarget;
  double? lpToDate;
  double? lpPercent;
  double? fiberRouteMilesTarget;
  double? frToDate;
  double? frPercent;
  double? connectedToHome;
  double? chToDate;
  double? chPercent;
  double? conduitRouteMiles;
  double? crToDate;
  double? crPercent;
  double? homesPassedTarget;
  double? hpToDate;
  double? hpPercent;

  HomeAndLots({
    this.id,
    this.createdAt,
    this.lotsPassedTarget,
    this.lpToDate,
    this.lpPercent,
    this.fiberRouteMilesTarget,
    this.frToDate,
    this.frPercent,
    this.connectedToHome,
    this.chToDate,
    this.chPercent,
    this.conduitRouteMiles,
    this.crToDate,
    this.crPercent,
    this.homesPassedTarget,
    this.hpToDate,
    this.hpPercent,
  });

  factory HomeAndLots.fromJson(String str) =>
      HomeAndLots.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HomeAndLots.fromMap(Map<String, dynamic> json) => HomeAndLots(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        lotsPassedTarget: json["lots_passed_target"].toDouble(),
        lpToDate: json["lp_to_date"].toDouble(),
        lpPercent: json["lp_percent"].toDouble(),
        fiberRouteMilesTarget: json["fiber_route_miles_target"]?.toDouble(),
        frToDate: json["fr_to_date"]?.toDouble(),
        frPercent: json["fr_percent"]?.toDouble(),
        connectedToHome: json["connected_to_home"].toDouble(),
        chToDate: json["ch_to_date"].toDouble(),
        chPercent: json["ch_percent"].toDouble(),
        conduitRouteMiles: json["conduit_route_miles"]?.toDouble(),
        crToDate: json["cr_to_date"]?.toDouble(),
        crPercent: json["cr_percent"].toDouble(),
        homesPassedTarget: json["homes_passed_target"].toDouble(),
        hpToDate: json["hp_to_date"].toDouble(),
        hpPercent: json["hp_percent"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "lots_passed_target": lotsPassedTarget,
        "lp_to_date": lpToDate,
        "lp_percent": lpPercent,
        "fiber_route_miles_target": fiberRouteMilesTarget,
        "fr_to_date": frToDate,
        "fr_percent": frPercent,
        "connected_to_home": connectedToHome,
        "ch_to_date": chToDate,
        "ch_percent": chPercent,
        "conduit_route_miles": conduitRouteMiles,
        "cr_to_date": crToDate,
        "cr_percent": crPercent,
        "homes_passed_target": homesPassedTarget,
        "hp_to_date": hpToDate,
        "hp_percent": hpPercent,
      };
}
