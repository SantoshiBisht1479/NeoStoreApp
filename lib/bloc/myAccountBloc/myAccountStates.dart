import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/get_user_detail_model.dart';

abstract class MyAccountState extends Equatable {}

class InitialMyAccountState extends MyAccountState {
  @override
  List<Object> get props => [];
}

class LoadingStateAccountState extends MyAccountState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class LoadedAccountState extends MyAccountState {
  GetUserDetailModel getUserDetailModel;
  LoadedAccountState({@required this.getUserDetailModel});
  @override
  List<Object> get props => [getUserDetailModel];
}

class FailureAccountState extends MyAccountState {
  String errorMessage;
  FailureAccountState({@required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
