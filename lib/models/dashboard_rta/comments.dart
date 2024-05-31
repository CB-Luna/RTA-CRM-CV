import 'dart:convert';

class CommentCircuit {
  int? id;
  String? userfk;
  int? circuitID;
  DateTime? sended;
  String? comment;

  CommentCircuit({
    this.id,
    this.userfk,
    this.circuitID,
    this.sended,
    this.comment,
  });

  factory CommentCircuit.fromJson(String str) =>
      CommentCircuit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommentCircuit.fromMap(Map<String, dynamic> json) => CommentCircuit(
        id: json["id"],
        userfk: json["userfk"],
        circuitID: json["circuitID"],
        sended: json["sended"] == null ? null : DateTime.parse(json["sended"]),
        comment: json["comment"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userfk": userfk,
        "circuitID": circuitID,
        "sended": sended?.toIso8601String(),
        "comment": comment,
      };
}
