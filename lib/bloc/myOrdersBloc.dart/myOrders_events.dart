import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class MyOrderEvents extends Equatable {}

class GetMyOrdersEvent extends MyOrderEvents {
  String accessToken;
  GetMyOrdersEvent({@required this.accessToken});
  @override
  List<Object> get props => [accessToken];
}

class GetOrderDetailEvent extends MyOrderEvents {
  String accessToken;
  int orderId;
  GetOrderDetailEvent({@required this.accessToken, @required this.orderId});

  @override
  List<Object> get props => [accessToken, orderId];
}
