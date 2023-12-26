import 'dart:convert';
import 'dart:developer';

class Token {
  Token({
    required this.token,
    required this.userId,
    required this.email,
    required this.creationDate,
  });

  String token;
  String userId;
  String email;
  DateTime creationDate;

  factory Token.fromJson(String str, String token) => Token.fromMap(json.decode(str), token);

  String toJson() => json.encode(toMap());

  factory Token.fromMap(Map<String, dynamic> payload, String token) {
    return Token(
      token: token,
      userId: payload["user_id"],
      email: payload["email"],
      creationDate: DateTime.parse(payload['creation_date']),
    );
  }

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "email": email,
        "creation_date": creationDate,
      };

  Future<bool> validate(String type) async {
    int timeLimit = 5;

    try {
      final minutesPassed = DateTime.now().toUtc().difference(creationDate).inDays;
      if (minutesPassed < timeLimit) {
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
