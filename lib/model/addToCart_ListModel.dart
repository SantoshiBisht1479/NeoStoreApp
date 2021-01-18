// To parse this JSON data, do
//
//     final addToCartListModel = addToCartListModelFromJson(jsonString);

import 'dart:convert';

AddToCartListModel addToCartListModelFromJson(String str) =>
    AddToCartListModel.fromJson(json.decode(str));

String addToCartListModelToJson(AddToCartListModel data) =>
    json.encode(data.toJson());

class AddToCartListModel {
  AddToCartListModel({
    this.status,
    this.data,
    this.count,
    this.total,
  });

  int status;
  List<Datum> data;
  int count;
  int total;

  factory AddToCartListModel.fromJson(Map<String, dynamic> json) =>
      AddToCartListModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        count: json["count"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
        "total": total,
      };
}

class Datum {
  Datum({
    this.id,
    this.productId,
    this.quantity,
    this.product,
  });

  int id;
  int productId;
  int quantity;
  Product product;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "quantity": quantity,
        "product": product.toJson(),
      };
}

class Product {
  Product({
    this.id,
    this.name,
    this.cost,
    this.productCategory,
    this.productImages,
    this.subTotal,
  });

  int id;
  String name;
  int cost;
  String productCategory;
  String productImages;
  int subTotal;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        cost: json["cost"],
        productCategory: json["product_category"],
        productImages: json["product_images"],
        subTotal: json["sub_total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cost": cost,
        "product_category": productCategory,
        "product_images": productImages,
        "sub_total": subTotal,
      };
}
