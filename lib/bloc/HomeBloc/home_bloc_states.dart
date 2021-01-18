import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/get_user_detail_model.dart';
import 'package:neostore/model/login_error_model.dart';

abstract class HomeBlocStates extends Equatable {}

class InitialHomeBloc extends HomeBlocStates {
  @override
  List<Object> get props => [];
}

class HomeBlocLoading extends HomeBlocStates {
  // String userToken;
  // HomeBlocLoading({@required this.userToken}) : assert(userToken != null);
  @override
  List<Object> get props => [];
}

class HomeBlocSuccessState extends HomeBlocStates {
  GetUserDetailModel getUserDetailModel;
  HomeBlocSuccessState({@required this.getUserDetailModel})
      : assert(getUserDetailModel != null);
  @override
  List<Object> get props => [getUserDetailModel];
}

class HomeBlocFailureState extends HomeBlocStates {
  //String errorMessage;
  LoginErrorModel loginErrorModel;
  HomeBlocFailureState({@required this.loginErrorModel})
      : assert(loginErrorModel != null);
  @override
  List<Object> get props => [loginErrorModel];
}
