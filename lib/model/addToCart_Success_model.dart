// To parse this JSON data, do
//
//     final addToCartSuccessModel = addToCartSuccessModelFromJson(jsonString);

import 'dart:convert';

AddToCartSuccessModel addToCartSuccessModelFromJson(String str) =>
    AddToCartSuccessModel.fromJson(json.decode(str));

String addToCartSuccessModelToJson(AddToCartSuccessModel data) =>
    json.encode(data.toJson());

class AddToCartSuccessModel {
  AddToCartSuccessModel({
    this.status,
    this.data,
    this.totalCarts,
    this.message,
    this.userMsg,
  });

  int status;
  bool data;
  int totalCarts;
  String message;
  String userMsg;

  factory AddToCartSuccessModel.fromJson(Map<String, dynamic> json) =>
      AddToCartSuccessModel(
        status: json["status"],
        data: json["data"],
        totalCarts: json["total_carts"],
        message: json["message"],
        userMsg: json["user_msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data,
        "total_carts": totalCarts,
        "message": message,
        "user_msg": userMsg,
      };
}
