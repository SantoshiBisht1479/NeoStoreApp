// To parse this JSON data, do
//
//     final changePasswordReqModel = changePasswordReqModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordReqModel changePasswordReqModelFromJson(String str) =>
    ChangePasswordReqModel.fromJson(json.decode(str));

String changePasswordReqModelToJson(ChangePasswordReqModel data) =>
    json.encode(data.toJson());

class ChangePasswordReqModel {
  ChangePasswordReqModel({
    this.oldPassword,
    this.password,
    this.confirmPassword,
  });

  String oldPassword;
  String password;
  String confirmPassword;

  factory ChangePasswordReqModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordReqModel(
        oldPassword: json["old_password"],
        password: json["password"],
        confirmPassword: json["confirm_password"],
      );

  Map<String, dynamic> toJson() => {
        "old_password": oldPassword,
        "password": password,
        "confirm_password": confirmPassword,
      };
}
