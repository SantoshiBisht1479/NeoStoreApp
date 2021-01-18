// To parse this JSON data, do
//
//     final forgotPassResponsetModel = forgotPassResponsetModelFromJson(jsonString);

import 'dart:convert';

ForgotPassResponsetModel forgotPassResponsetModelFromJson(String str) =>
    ForgotPassResponsetModel.fromJson(json.decode(str));

String forgotPassResponsetModelToJson(ForgotPassResponsetModel data) =>
    json.encode(data.toJson());

class ForgotPassResponsetModel {
  ForgotPassResponsetModel({
    this.status,
    this.message,
    this.userMsg,
  });

  int status;
  String message;
  String userMsg;

  factory ForgotPassResponsetModel.fromJson(Map<String, dynamic> json) =>
      ForgotPassResponsetModel(
        status: json["status"],
        message: json["message"],
        userMsg: json["user_msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user_msg": userMsg,
      };
}
