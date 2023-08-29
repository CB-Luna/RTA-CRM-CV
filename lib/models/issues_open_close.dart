import 'dart:convert';

class IssueOpenclose {
  IssueOpenclose(
      {required this.nameIssue,
      required this.dateAddedOpen,
      required this.idIssue,
      this.percentage,
      this.category,
      this.comments,
      this.listImages,
      this.dateAddedClose});

  String nameIssue;
  int idIssue;
  String? comments;
  List<String>? listImages;
  DateTime dateAddedOpen;
  DateTime? dateAddedClose;
  String? percentage;
  String? category;

  factory IssueOpenclose.fromJson(String str) =>
      IssueOpenclose.fromMap(json.decode(str));

  factory IssueOpenclose.fromMap(Map<String, dynamic> json) => IssueOpenclose(
      dateAddedOpen: json["date_added"],
      nameIssue: json['nameIssue'],
      idIssue: json["id"],
      comments: json['comments'],
      dateAddedClose: json["date_added_close"],
      listImages: json['listImages'],
      category: json["category"],
      percentage: json["percentage"]);

  Map<String, dynamic> toMap() => {
        "nameIssues": nameIssue,
        "percentage": percentage,
        "id": idIssue,
        "category": category, "comments": comments,
        "listImages": listImages,
        "date_added": dateAddedOpen.toIso8601String(), //check out
        "date_added_close": dateAddedClose?.toIso8601String(), //check out
      };
}
