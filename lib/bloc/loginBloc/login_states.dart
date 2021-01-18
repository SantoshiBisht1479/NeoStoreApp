import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/login_error_model.dart';

abstract class LoginStates {}

class InitialloginState extends LoginStates {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginStates {
  String accessToken;
  String userName;
  //LoginResponseModel loginResponseModel;
  LoginSuccessState({@required this.accessToken, @required this.userName})
      : assert(accessToken != null && userName != null);
  @override
  List<Object> get props => [accessToken, userName];
}

class LoginfailureState extends LoginStates {
  LoginErrorModel loginErrorModel;
  LoginfailureState({@required this.loginErrorModel})
      : assert(loginErrorModel != null);

  @override
  List<Object> get props => [];
}

class LoginForgotPasswordState extends LoginStates {
  @override
  List<Object> get props => [];
}

class LoginRegisterState extends LoginStates {
  @override
  List<Object> get props => [];
}
