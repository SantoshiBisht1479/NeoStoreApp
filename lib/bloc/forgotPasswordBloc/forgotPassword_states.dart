import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/forgot_pass_response_model.dart';

abstract class ForgotPasswordStates extends Equatable {}

class InitialForgotPasswordState extends ForgotPasswordStates {
  @override
  List<Object> get props => [];
}

class ForgotPasswordSuccessState extends ForgotPasswordStates {
  ForgotPassResponsetModel forgotPassResponsetModel;
  ForgotPasswordSuccessState({@required this.forgotPassResponsetModel})
      : assert(forgotPassResponsetModel != null);
  @override
  List<Object> get props => [forgotPassResponsetModel];
}

class ForgotPasswordFailureState extends ForgotPasswordStates {
  ForgotPassResponsetModel forgotPassResponsetModel;
  ForgotPasswordFailureState({@required this.forgotPassResponsetModel})
      : assert(forgotPassResponsetModel != null);

  @override
  List<Object> get props => [forgotPassResponsetModel];
}

class ForgotPasswordRegisterState extends ForgotPasswordStates {
  @override
  List<Object> get props => [];
}
