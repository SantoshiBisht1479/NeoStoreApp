import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/change_PassReq_model.dart';

abstract class ResetPasswordEvents extends Equatable {}

class ResetPassword extends ResetPasswordEvents {
  String accessToken;
  ChangePasswordReqModel changePasswordReqModel;

  ResetPassword(
      {@required this.accessToken, @required this.changePasswordReqModel});
  @override
  // TODO: implement props
  List<Object> get props => [accessToken, changePasswordReqModel];
}
