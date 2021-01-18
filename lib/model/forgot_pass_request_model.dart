// To parse this JSON data, do
//
//     final forgotPassRequestModel = forgotPassRequestModelFromJson(jsonString);

import 'dart:convert';

ForgotPassRequestModel forgotPassRequestModelFromJson(String str) =>
    ForgotPassRequestModel.fromJson(json.decode(str));

String forgotPassRequestModelToJson(ForgotPassRequestModel data) =>
    json.encode(data.toJson());

class ForgotPassRequestModel {
  ForgotPassRequestModel({
    this.email,
  });

  String email;

  factory ForgotPassRequestModel.fromJson(Map<String, dynamic> json) =>
      ForgotPassRequestModel(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
