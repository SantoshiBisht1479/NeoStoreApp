import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/myOder_model.dart';
import 'package:neostore/model/myOrderDetail_model.dart';

abstract class MyOrderState extends Equatable {}

class InitialOrderState extends MyOrderState {
  @override
  List<Object> get props => [];
}

class LoadingOrderState extends MyOrderState {
  @override
  List<Object> get props => [];
}

class LoadedOrderState extends MyOrderState {
  MyOrderModel myOrderModel;
  LoadedOrderState({@required this.myOrderModel});
  @override
  List<Object> get props => [myOrderModel];
}

class FailureOrderState extends MyOrderState {
  String errorMessage;
  FailureOrderState({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class SuccessOrderDetailState extends MyOrderState {
  MyOrderDetailModel myOrderDetailModel;
  SuccessOrderDetailState({@required this.myOrderDetailModel});

  @override
  List<Object> get props => [myOrderDetailModel];
}

class EmptyOrderState extends MyOrderState {
  //LoginErrorModel errorModel;
  String emptyMessage;
  EmptyOrderState({@required this.emptyMessage});

  @override
  List<Object> get props => [emptyMessage];
}
