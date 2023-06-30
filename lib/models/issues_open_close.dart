import 'dart:convert';

class IssueOpenclose {
  IssueOpenclose(
      {required this.nameIssue,
      required this.dateAddedOpen,
      required this.idBucketInspection,
      this.dateAddedClose});

  String nameIssue;
  int idBucketInspection;
  DateTime dateAddedOpen;
  DateTime? dateAddedClose;

  factory IssueOpenclose.fromJson(String str) =>
      IssueOpenclose.fromMap(json.decode(str));

  factory IssueOpenclose.fromMap(Map<String, dynamic> json) => IssueOpenclose(
      dateAddedOpen: json["date_added"],
      nameIssue: json['nameIssue'],
      idBucketInspection: json["id_bucket_inspection"],
      dateAddedClose: json["date_added_close"]);

  Map<String, dynamic> toMap() => {
        "nameIssues": nameIssue,

        "idBucketInspection": idBucketInspection,
        "date_added": dateAddedOpen.toIso8601String(), //check out
        "date_added_close": dateAddedClose!.toIso8601String(), //check out
      };
}
