import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class MyAccountEvent extends Equatable {}

class GetUserDetailEvent extends MyAccountEvent {
  String accessToken;
  GetUserDetailEvent({@required this.accessToken});
  @override
  List<Object> get props => throw UnimplementedError();
}
