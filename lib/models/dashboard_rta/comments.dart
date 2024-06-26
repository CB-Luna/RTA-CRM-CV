// import 'dart:convert';

// class CommentCircuit {
//   int? id;
//   String? userfk;
//   int? circuitID;
//   DateTime? sended;
//   String? comment;

//   CommentCircuit({
//     this.id,
//     this.userfk,
//     this.circuitID,
//     this.sended,
//     this.comment,
//   });

//   factory CommentCircuit.fromJson(String str) =>
//       CommentCircuit.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory CommentCircuit.fromMap(Map<String, dynamic> json) => CommentCircuit(
//         id: json["id"],
//         userfk: json["userfk"],
//         circuitID: json["circuitID"],
//         sended: json["sended"] == null ? null : DateTime.parse(json["sended"]),
//         comment: json["comment"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "userfk": userfk,
//         "circuitID": circuitID,
//         "sended": sended?.toIso8601String(),
//         "comment": comment,
//       };
// }

import 'dart:convert';

class CommentCircuit {
  Usercomment? usercomment;
  int? id;
  DateTime? createdAt;
  int? idCircuit;
  String? userFk;
  String? comment;
  DateTime? sended;

  CommentCircuit({
    this.usercomment,
    this.id,
    this.createdAt,
    this.idCircuit,
    this.userFk,
    this.comment,
    this.sended,
  });

  factory CommentCircuit.fromJson(String str) =>
      CommentCircuit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommentCircuit.fromMap(Map<String, dynamic> json) => CommentCircuit(
        usercomment: json["usercomment"] == null
            ? null
            : Usercomment.fromMap(json["usercomment"]),
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        idCircuit: json["id_circuit"],
        userFk: json["user_fk"],
        comment: json["comment"],
        sended: json["sended"] == null ? null : DateTime.parse(json["sended"]),
      );

  Map<String, dynamic> toMap() => {
        "usercomment": usercomment?.toMap(),
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "id_circuit": idCircuit,
        "user_fk": userFk,
        "comment": comment,
        "sended": sended?.toIso8601String(),
      };
}

class Usercomment {
  String? name;
  String? lastName;
  int? sequentialId;
  String? userProfileId;

  Usercomment({
    this.name,
    this.lastName,
    this.sequentialId,
    this.userProfileId,
  });

  factory Usercomment.fromJson(String str) =>
      Usercomment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usercomment.fromMap(Map<String, dynamic> json) => Usercomment(
        name: json["name"],
        lastName: json["last_name"],
        sequentialId: json["sequential_id"],
        userProfileId: json["user_profile_id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "last_name": lastName,
        "sequential_id": sequentialId,
        "user_profile_id": userProfileId,
      };
}
