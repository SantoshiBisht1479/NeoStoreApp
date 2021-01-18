// To parse this JSON data, do
//
//     final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) =>
    json.encode(data.toJson());

class RegisterResponseModel {
  RegisterResponseModel({
    this.status,
    this.data,
    this.message,
    this.userMsg,
  });

  int status;
  Data data;
  String message;
  String userMsg;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
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
  dynamic profilePic;
  dynamic countryId;
  String gender;
  int phoneNo;
  dynamic dob;
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
        phoneNo: int.parse(json["phone_no"]),
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

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = this.id;
    map["role_id"] = this.roleId;
    map["first_name"] = this.firstName;
    map["last_name"] = this.lastName;
    map["email"] = this.email;
    map["username"] = this.username;
    map["profile_pic"] = this.profilePic;
    map["country_id"] = this.countryId;
    map["gender"] = this.gender;
    map["phone_no"] = this.phoneNo;
    map["dob"] = this.dob;
    map["is_active"] = this.isActive;
    map["created"] = this.created;
    map["modified"] = this.modified;
    map["access_token"] = this.accessToken;
    return map;
  }

  Data.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.roleId = map["role_id"];
    this.firstName = map["first_name"];
    this.lastName = map["last_name"];
    this.email = map["email"];
    this.username = map["username"];
    this.profilePic = map["profile_pic"];
    this.countryId = map["country_id"];
    this.gender = map["gender"];
    this.phoneNo = map["phone_no"];
    this.dob = map["dob"];
    this.isActive = map["is_active"];
    this.created = map["created"];
    this.modified = map["modified"];
    this.accessToken = map["access_token"];
  }
}
