import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/login_error_model.dart';
import 'package:neostore/model/product_category_list_model.dart';

abstract class ProductListStates extends Equatable {}

class InitialProductList extends ProductListStates {
  @override
  List<Object> get props => [];
}

class LoadingProductListState extends ProductListStates {
  @override
  List<Object> get props => [];
}

class LoadedProductListState extends ProductListStates {
  ProductCategoryModel productCategoryModel;
  LoadedProductListState({@required this.productCategoryModel});
  @override
  List<Object> get props => [productCategoryModel];
}

class FailureProductListState extends ProductListStates {
  LoginErrorModel loginErrorModel;
  FailureProductListState({@required this.loginErrorModel});
  @override
  List<Object> get props => [loginErrorModel];
}
