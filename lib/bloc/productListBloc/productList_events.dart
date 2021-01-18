import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProductListEvents extends Equatable {}

class ShowProductList extends ProductListEvents {
  String productId;
  ShowProductList({@required this.productId});
  @override
  List<Object> get props => [productId];
}
