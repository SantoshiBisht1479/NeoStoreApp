// To parse this JSON data, do
//
//     final ratingSuccessModel = ratingSuccessModelFromJson(jsonString);

import 'dart:convert';

RatingSuccessModel ratingSuccessModelFromJson(String str) =>
    RatingSuccessModel.fromJson(json.decode(str));

String ratingSuccessModelToJson(RatingSuccessModel data) =>
    json.encode(data.toJson());

class RatingSuccessModel {
  RatingSuccessModel({
    this.status,
    this.data,
    this.message,
    this.userMsg,
  });

  int status;
  Data data;
  String message;
  String userMsg;

  factory RatingSuccessModel.fromJson(Map<String, dynamic> json) =>
      RatingSuccessModel(
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
    this.productCategoryId,
    this.name,
    this.producer,
    this.description,
    this.cost,
    this.rating,
    this.viewCount,
    this.created,
    this.modified,
  });

  int id;
  int productCategoryId;
  String name;
  String producer;
  String description;
  int cost;
  dynamic rating;
  int viewCount;
  String created;
  String modified;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        productCategoryId: json["product_category_id"],
        name: json["name"],
        producer: json["producer"],
        description: json["description"],
        cost: json["cost"],
        rating: json["rating"],
        viewCount: json["view_count"],
        created: json["created"],
        modified: json["modified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_category_id": productCategoryId,
        "name": name,
        "producer": producer,
        "description": description,
        "cost": cost,
        "rating": rating,
        "view_count": viewCount,
        "created": created,
        "modified": modified,
      };
}
