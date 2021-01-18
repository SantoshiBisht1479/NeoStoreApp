import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/login_error_model.dart';

abstract class ResetPasswordStates extends Equatable {}

class InitialResetPassword extends ResetPasswordStates {
  @override
  List<Object> get props => [];
}

class ResetPasswordSuccessState extends ResetPasswordStates {
  LoginErrorModel changePasswordResModel;
  ResetPasswordSuccessState({@required this.changePasswordResModel})
      : assert(changePasswordResModel != null);
  @override
  List<Object> get props => [changePasswordResModel];
}

class ResetpasswordFailureState extends ResetPasswordStates {
  //String errorMessage;
  LoginErrorModel loginErrorModel;
  ResetpasswordFailureState({@required this.loginErrorModel})
      : assert(loginErrorModel != null);
  @override
  List<Object> get props => [loginErrorModel];
}
