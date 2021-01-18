// To parse this JSON data, do
//
//     final registerRequestModel = registerRequestModelFromJson(jsonString);

import 'dart:convert';

class RegisterRequestModel {
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;
  String gender;
  int phoneNo;

  RegisterRequestModel(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.confirmPassword,
      this.gender,
      this.phoneNo});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
    gender = json['gender'];
    phoneNo = json['phone_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirm_password'] = this.confirmPassword;
    data['gender'] = this.gender;
    data['phone_no'] = this.phoneNo;
    return data;
  }
}
