import 'dart:convert';

class IssuesComments {
  IssuesComments({
    required this.nameIssue,
    this.comments,
    this.listImages,
    required this.dateAdded,
  });

  String nameIssue;
  String? comments;
  List<String>? listImages;
  DateTime dateAdded;

  factory IssuesComments.fromJson(String str) =>
      IssuesComments.fromMap(json.decode(str));

  factory IssuesComments.fromMap(Map<String, dynamic> json) => IssuesComments(
        dateAdded: json["date_added"],
        nameIssue: json['nameIssue'],
        comments: json['comments'],
        listImages: json['listImages'],
      );

  Map<String, dynamic> toMap() => {
        "nameIssues": nameIssue,
        "comments": comments,
        "listImages": listImages,
        "date_added": dateAdded.toIso8601String(), //check out
      };
}
