// To parse this JSON data, do
//
//     final myOrderModel = myOrderModelFromJson(jsonString);

import 'dart:convert';

MyOrderModel myOrderModelFromJson(String str) =>
    MyOrderModel.fromJson(json.decode(str));

String myOrderModelToJson(MyOrderModel data) => json.encode(data.toJson());

class MyOrderModel {
  MyOrderModel({
    this.status,
    this.data,
    this.message,
    this.userMsg,
  });

  int status;
  List<Datum> data;
  String message;
  String userMsg;

  factory MyOrderModel.fromJson(Map<String, dynamic> json) => MyOrderModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
        userMsg: json["user_msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "user_msg": userMsg,
      };
}

class Datum {
  Datum({
    this.id,
    this.cost,
    this.created,
  });

  int id;
  int cost;
  String created;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        cost: json["cost"],
        created: json["created"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cost": cost,
        "created": created,
      };
}
