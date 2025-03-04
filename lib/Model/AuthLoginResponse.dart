// To parse this JSON data, do
//
//     final authLoginResponse = authLoginResponseFromJson(jsonString);

import 'dart:convert';

AuthLoginResponse authLoginResponseFromJson(String str) => AuthLoginResponse.fromJson(json.decode(str));

String authLoginResponseToJson(AuthLoginResponse data) => json.encode(data.toJson());

class AuthLoginResponse {
  String? token;

  AuthLoginResponse({
    this.token,
  });

  factory AuthLoginResponse.fromJson(Map<String, dynamic> json) => AuthLoginResponse(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
