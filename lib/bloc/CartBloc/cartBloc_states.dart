import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/addToCart_ListModel.dart';
import 'package:neostore/model/login_error_model.dart';

abstract class CartBlocStates extends Equatable {}

class InitialCartBlocState extends CartBlocStates {
  @override
  List<Object> get props => [];
}

class LoadingCartBlocState extends CartBlocStates {
  @override
  List<Object> get props => [];
}

class LoadedCartBlocState extends CartBlocStates {
  AddToCartListModel addToCartListModel;

  LoadedCartBlocState({@required this.addToCartListModel})
      : assert(addToCartListModel != null);
  @override
  List<Object> get props => [addToCartListModel];
}

class FailureCartBlocState extends CartBlocStates {
  String errorMessage;
  FailureCartBlocState({@required this.errorMessage})
      : assert(errorMessage != null);
  @override
  // TODO: implement props
  List<Object> get props => [errorMessage];
}

class EmptyCartBlocState extends CartBlocStates {
  LoginErrorModel errorModel;
  EmptyCartBlocState({@required this.errorModel});

  @override
  List<Object> get props => [errorModel];
}
