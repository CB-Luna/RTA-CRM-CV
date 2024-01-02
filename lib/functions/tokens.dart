import 'dart:convert';
import 'dart:developer';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:rta_crm_cv/models/models.dart';

Token? parseToken(String token) {
  try {
    // Verify a token
    final jwt = JWT.verify(token, SecretKey('secret'));
    return Token.fromJson(json.encode(jwt.payload), token);
  } on JWTExpiredException {
    log('JWT expired');
  } on JWTException catch (ex) {
    log('Error in checkToken - $ex');
  } on Exception {
    return null;
  }
  return null;
}
