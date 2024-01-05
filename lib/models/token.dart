import 'dart:convert';
import 'dart:developer';

class Token {
  Token({
    required this.token,
    required this.account,
    required this.email,
    required this.documentId,
    required this.creationDate,
  });

  String token;
  String account;
  String email;
  String documentId;
  DateTime creationDate;

  factory Token.fromJson(String str, String token) => Token.fromMap(json.decode(str), token);

  String toJson() => json.encode(toMap());

  factory Token.fromMap(Map<String, dynamic> payload, String token) {
    return Token(
      token: token,
      account: payload["account"],
      email: payload["email"],
      documentId: payload['document_id'],
      creationDate: DateTime.parse(payload['creation_date']),
    );
  }

  Map<String, dynamic> toMap() => {
        "account": account,
        "email": email,
        "document_id": documentId,
        "creation_date": creationDate,
      };

  Future<bool> validate(String type) async {
    int timeLimit = 5;

    try {
      final daysPassed = DateTime.now().toUtc().difference(creationDate).inDays;
      if (daysPassed < timeLimit) {
        // final res = await supabase
        //     .from('token')
        //     .select('token_$type')
        //     .eq('user_id', userId);
        // final validatedToken = res[0]['token_$type'];
        // if (token == validatedToken) return true;
      }
      return true;
    } catch (e) {
      log('Error en validateToken - $e');
      return false;
    }
  }
}
