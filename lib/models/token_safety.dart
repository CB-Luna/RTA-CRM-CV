import 'dart:convert';
import 'dart:developer';

class TokenSafety {
  TokenSafety({
    required this.token,
    required this.email,
    required this.documentId,
    required this.creationDate,
    required this.userfk,
  });

  String token;
  String email;
  int documentId;
  String userfk;
  DateTime creationDate;

  factory TokenSafety.fromJson(String str, String token) =>
      TokenSafety.fromMap(json.decode(str), token);

  String toJson() => json.encode(toMap());

  factory TokenSafety.fromMap(Map<String, dynamic> payload, String token) {
    return TokenSafety(
      token: token,
      email: payload["email"],
      documentId: payload['document_id'],
      userfk: payload["user_fk"],
      creationDate: DateTime.parse(payload['creation_date']),
    );
  }

  Map<String, dynamic> toMap() => {
        "email": email,
        "document_id": documentId,
        "creation_date": creationDate,
        "user_fk": userfk,
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
        // final validatedTokenSafety = res[0]['token_$type'];
        // if (token == validatedTokenSafety) return true;
      }
      return true;
    } catch (e) {
      log('Error en validateTokenSafety - $e');
      return false;
    }
  }
}
