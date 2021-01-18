import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/forgot_pass_request_model.dart';

abstract class ForgotPasswordEvents extends Equatable {}

class ForgotUserPasswordEvent extends ForgotPasswordEvents {
  ForgotPassRequestModel forgotPassRequestModel;
  ForgotUserPasswordEvent({@required this.forgotPassRequestModel})
      : assert(forgotPassRequestModel != null);
  @override
  List<Object> get props => [forgotPassRequestModel];
}
