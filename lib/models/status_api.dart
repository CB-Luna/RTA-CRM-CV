import 'dart:convert';

class StatusApi {
  StatusApi({
    required this.status,
    required this.statusId,
  });

  int statusId;
  String status;

  factory StatusApi.fromJson(String str) => StatusApi.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatusApi.fromMap(Map<String, dynamic> json) => StatusApi(
        status: json["status"],
        statusId: json["id_status"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "id_status": statusId,
      };
}
