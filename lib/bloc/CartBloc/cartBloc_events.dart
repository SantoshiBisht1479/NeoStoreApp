import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CartBlocEvents extends Equatable {}

class ListCartListEvent extends CartBlocEvents {
  String access_token;
  ListCartListEvent({@required this.access_token})
      : assert(access_token != null);
  @override
  List<Object> get props => [access_token];
}

class DeleteCartItem extends CartBlocEvents {
  String accessToken;
  int product_id;
  DeleteCartItem({@required this.accessToken, @required this.product_id});

  @override
  List<Object> get props => [accessToken, product_id];
}

class EditCartItems extends CartBlocEvents {
  String accessToken;
  int productId;
  int quantity;
  EditCartItems(
      {@required this.accessToken,
      @required this.productId,
      @required this.quantity})
      : assert(accessToken != null && productId != null && quantity != null);
  @override
  List<Object> get props => [accessToken, productId, quantity];
}
