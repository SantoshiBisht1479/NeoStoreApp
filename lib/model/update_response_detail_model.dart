// To parse this JSON data, do
//
//     final updateResponseUserDetailModel = updateResponseUserDetailModelFromJson(jsonString);

import 'dart:convert';

UpdateResponseUserDetailModel updateResponseUserDetailModelFromJson(
        String str) =>
    UpdateResponseUserDetailModel.fromJson(json.decode(str));

String updateResponseUserDetailModelToJson(
        UpdateResponseUserDetailModel data) =>
    json.encode(data.toJson());

class UpdateResponseUserDetailModel {
  UpdateResponseUserDetailModel({
    this.status,
    this.data,
    this.message,
    this.userMsg,
  });

  int status;
  Data data;
  String message;
  String userMsg;

  factory UpdateResponseUserDetailModel.fromJson(Map<String, dynamic> json) =>
      UpdateResponseUserDetailModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
        userMsg: json["user_msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
        "user_msg": userMsg,
      };
}

class Data {
  Data({
    this.id,
    this.roleId,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.profilePic,
    this.countryId,
    this.gender,
    this.phoneNo,
    this.dob,
    this.isActive,
    this.created,
    this.modified,
    this.accessToken,
  });

  int id;
  int roleId;
  String firstName;
  String lastName;
  String email;
  String username;
  String profilePic;
  dynamic countryId;
  String gender;
  String phoneNo;
  String dob;
  bool isActive;
  String created;
  String modified;
  String accessToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        roleId: json["role_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        username: json["username"],
        profilePic: json["profile_pic"],
        countryId: json["country_id"],
        gender: json["gender"],
        phoneNo: json["phone_no"],
        dob: json["dob"],
        isActive: json["is_active"],
        created: json["created"],
        modified: json["modified"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "username": username,
        "profile_pic": profilePic,
        "country_id": countryId,
        "gender": gender,
        "phone_no": phoneNo,
        "dob": dob,
        "is_active": isActive,
        "created": created,
        "modified": modified,
        "access_token": accessToken,
      };
}
