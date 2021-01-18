import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/login_error_model.dart';
import 'package:neostore/model/product_detail_model.dart';

abstract class ProductDetailStates extends Equatable {}

class InitialProductDetailstates extends ProductDetailStates {
  @override
  List<Object> get props => [];
}

class LoadingProductDetailsStates extends ProductDetailStates {
  @override
  List<Object> get props => [];
}

class LoadedProductDetailStates extends ProductDetailStates {
  ProductDetailModel productDetailModel;
  LoadedProductDetailStates({@required this.productDetailModel})
      : assert(productDetailModel != null);
  @override
  List<Object> get props => [productDetailModel];
}

class FailureProductDetailStates extends ProductDetailStates {
  LoginErrorModel productDetailerrorModel;
  FailureProductDetailStates({@required this.productDetailerrorModel})
      : assert(productDetailerrorModel != null);

  @override
  List<Object> get props => [productDetailerrorModel];
}
