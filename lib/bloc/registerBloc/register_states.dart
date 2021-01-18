import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/login_error_model.dart';
import 'package:neostore/model/signup_response_model.dart';

abstract class RegisterStates extends Equatable {}

class InitialRegisterState extends RegisterStates {
  @override
  List<Object> get props => [];
}

class SuccessRegisterState extends RegisterStates {
  RegisterResponseModel registerResponseModel;

  SuccessRegisterState({@required this.registerResponseModel})
      : assert(registerResponseModel != null);

  @override
  List<Object> get props => [registerResponseModel];
}

class FailureRegisterState extends RegisterStates {
  LoginErrorModel loginErrorModel;

  FailureRegisterState({@required this.loginErrorModel})
      : assert(loginErrorModel != null);

  @override
  List<Object> get props => [loginErrorModel];
}
