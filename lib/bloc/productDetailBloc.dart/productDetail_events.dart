import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProductDetailEvents extends Equatable {}

class FetchProductDetails extends ProductDetailEvents {
  String productId;
  FetchProductDetails({@required this.productId}) : assert(productId != null);
  @override
  List<Object> get props => [productId];
}

class SubmitRatingEvent extends ProductDetailEvents {
  //ProductDetailModel productDetailModel;
  String productId;
  var ratings;
  SubmitRatingEvent({@required this.productId, @required this.ratings})
      : assert(productId != null && ratings != null);

  @override
  List<Object> get props => [productId, ratings];
}

class AddQuantityEvent extends ProductDetailEvents {
  String accessToken;
  int productId;
  int quantity;

  AddQuantityEvent(
      {@required this.accessToken,
      @required this.productId,
      @required this.quantity});
  @override
  List<Object> get props => [accessToken, productId, quantity];
}
