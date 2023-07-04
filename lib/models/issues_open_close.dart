import 'dart:convert';

class IssueOpenclose {
  IssueOpenclose(
      {required this.nameIssue,
      required this.dateAddedOpen,
      required this.idIssue,
      this.percentage,
      this.dateAddedClose});

  String nameIssue;
  int idIssue;
  DateTime dateAddedOpen;
  DateTime? dateAddedClose;
  String? percentage;

  factory IssueOpenclose.fromJson(String str) =>
      IssueOpenclose.fromMap(json.decode(str));

  factory IssueOpenclose.fromMap(Map<String, dynamic> json) => IssueOpenclose(
      dateAddedOpen: json["date_added"],
      nameIssue: json['nameIssue'],
      idIssue: json["id"],
      dateAddedClose: json["date_added_close"],
      percentage: json["percentage"]);

  Map<String, dynamic> toMap() => {
        "nameIssues": nameIssue,
        "percentage": percentage,
        "id": idIssue,
        "date_added": dateAddedOpen.toIso8601String(), //check out
        "date_added_close": dateAddedClose!.toIso8601String(), //check out
      };
}
