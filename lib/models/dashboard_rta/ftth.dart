import 'dart:convert';

class Ftth {
  int? id;
  DateTime? createdAt;
  double? ftthSubsTarget;
  double? ftthSubsToDate;
  double? ftthSubsPercent;
  double? convertedFtthSubsTarget;
  double? convertedFtthSubsTargetToDate;
  double? convertedFtthPercent;
  double? newFtthSubsTarget;
  double? newFtthSubsToDate;
  double? newFtthSubsPercent;

  Ftth({
    this.id,
    this.createdAt,
    this.ftthSubsTarget,
    this.ftthSubsToDate,
    this.ftthSubsPercent,
    this.convertedFtthSubsTarget,
    this.convertedFtthSubsTargetToDate,
    this.convertedFtthPercent,
    this.newFtthSubsTarget,
    this.newFtthSubsToDate,
    this.newFtthSubsPercent,
  });

  factory Ftth.fromJson(String str) => Ftth.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ftth.fromMap(Map<String, dynamic> json) => Ftth(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        ftthSubsTarget: json["ftth_subs_target"].toDouble(),
        ftthSubsToDate: json["ftth_subs_to_date"].toDouble(),
        ftthSubsPercent: json["ftth_subs_percent"].toDouble(),
        convertedFtthSubsTarget: json["converted_ftth_subs_target"].toDouble(),
        convertedFtthSubsTargetToDate:
            json["converted_ftth_subs_target_to_date"].toDouble(),
        convertedFtthPercent: json["converted_ftth_percent"].toDouble(),
        newFtthSubsTarget: json["new_ftth_subs_target"].toDouble(),
        newFtthSubsToDate: json["new_ftth_subs_to_date"].toDouble(),
        newFtthSubsPercent: json["new_ftth_subs_percent"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "ftth_subs_target": ftthSubsTarget,
        "ftth_subs_to_date": ftthSubsToDate,
        "ftth_subs_percent": ftthSubsPercent,
        "converted_ftth_subs_target": convertedFtthSubsTarget,
        "converted_ftth_subs_target_to_date": convertedFtthSubsTargetToDate,
        "converted_ftth_percent": convertedFtthPercent,
        "new_ftth_subs_target": newFtthSubsTarget,
        "new_ftth_subs_to_date": newFtthSubsToDate,
        "new_ftth_subs_percent": newFtthSubsPercent,
      };
}
