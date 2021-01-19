import 'package:flutter/material.dart';
import 'package:neostore/model/login_request_model.dart';

abstract class LoginEvents {}

class LoginUserEvent extends LoginEvents {
  LoginRequestModel loginRequestModel;
  LoginUserEvent({@required this.loginRequestModel})
      : assert(loginRequestModel != null);
  @override
  List<Object> get props => [loginRequestModel];
}
