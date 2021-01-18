// To parse this JSON data, do
//
//     final getUserDetailModel = getUserDetailModelFromJson(jsonString);

import 'dart:convert';

GetUserDetailModel getUserDetailModelFromJson(String str) =>
    GetUserDetailModel.fromJson(json.decode(str));

String getUserDetailModelToJson(GetUserDetailModel data) =>
    json.encode(data.toJson());

class GetUserDetailModel {
  GetUserDetailModel({
    this.status,
    this.data,
  });

  int status;
  Data data;

  factory GetUserDetailModel.fromJson(Map<String, dynamic> json) =>
      GetUserDetailModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.userData,
    this.productCategories,
    this.totalCarts,
    this.totalOrders,
  });

  UserData userData;
  List<ProductCategory> productCategories;
  int totalCarts;
  int totalOrders;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userData: UserData.fromJson(json["user_data"]),
        productCategories: List<ProductCategory>.from(
            json["product_categories"].map((x) => ProductCategory.fromJson(x))),
        totalCarts: json["total_carts"],
        totalOrders: json["total_orders"],
      );

  Map<String, dynamic> toJson() => {
        "user_data": userData.toJson(),
        "product_categories":
            List<dynamic>.from(productCategories.map((x) => x.toJson())),
        "total_carts": totalCarts,
        "total_orders": totalOrders,
      };
}

class ProductCategory {
  ProductCategory({
    this.id,
    this.name,
    this.iconImage,
    this.created,
    this.modified,
  });

  int id;
  String name;
  String iconImage;
  String created;
  String modified;

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        id: json["id"],
        name: json["name"],
        iconImage: json["icon_image"],
        created: json["created"],
        modified: json["modified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon_image": iconImage,
        "created": created,
        "modified": modified,
      };
}

class UserData {
  UserData({
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
  String phoneNo;
  dynamic dob;
  bool isActive;
  String created;
  String modified;
  String accessToken;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
