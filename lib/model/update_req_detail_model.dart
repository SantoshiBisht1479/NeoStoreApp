// To parse this JSON data, do
//
//     final updateReqUserDetailModel = updateReqUserDetailModelFromJson(jsonString);

import 'dart:convert';

UpdateReqUserDetailModel updateReqUserDetailModelFromJson(String str) =>
    UpdateReqUserDetailModel.fromJson(json.decode(str));

String updateReqUserDetailModelToJson(UpdateReqUserDetailModel data) =>
    json.encode(data.toJson());

class UpdateReqUserDetailModel {
  UpdateReqUserDetailModel({
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
    this.profilePic,
    this.phoneNo,
  });

  String firstName;
  String lastName;
  String email;
  String dob;
  String profilePic;
  String phoneNo;

  factory UpdateReqUserDetailModel.fromJson(Map<String, dynamic> json) =>
      UpdateReqUserDetailModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        dob: json["dob"],
        profilePic: json["profile_pic"],
        phoneNo: json["phone_no"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "dob": dob,
        "profile_pic": profilePic,
        "phone_no": phoneNo,
      };
}
