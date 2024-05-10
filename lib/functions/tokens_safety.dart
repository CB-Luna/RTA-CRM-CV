import 'dart:convert';
import 'dart:developer';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:rta_crm_cv/models/token_safety.dart';

TokenSafety? parseTokenSafety(String token) {
  try {
    // Verify a token
    final jwt = JWT.verify(token, SecretKey('secret'));
    return TokenSafety.fromJson(json.encode(jwt.payload), token);
  } on JWTExpiredException {
    log('JWT expired');
  } on JWTException catch (ex) {
    log('Error in checkTokenSafety - $ex');
  } on Exception {
    return null;
  }
  return null;
}
