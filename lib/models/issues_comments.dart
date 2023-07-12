import 'dart:convert';

class IssuesComments {
  IssuesComments({
    required this.nameIssue,
    this.comments,
    required this.idIssue,
    this.listImages,
    required this.dateAdded,
    this.idControlForm,
    this.typeIssue,
    this.status = false,
  });

  String nameIssue;
  int idIssue;
  bool? typeIssue;
  int? idControlForm;
  String? comments;
  List<String>? listImages;
  DateTime dateAdded;
  bool status;

  factory IssuesComments.fromJson(String str) =>
      IssuesComments.fromMap(json.decode(str));

  factory IssuesComments.fromMap(Map<String, dynamic> json) => IssuesComments(
        dateAdded: json["date_added"],
        nameIssue: json['nameIssue'],
        comments: json['comments'],
        idControlForm: json['id_control_form'],
        typeIssue: json['type_Issue'],
        idIssue: json['idIssue'],
        listImages: json['listImages'],
      );

  Map<String, dynamic> toMap() => {
        "nameIssues": nameIssue,
        "comments": comments,
        "listImages": listImages,
        "type_Issue": typeIssue,
        "id_control_form": idControlForm,
        "idIssue": idIssue,
        "date_added": dateAdded.toIso8601String(), //check out
      };
}
