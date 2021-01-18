import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/signup_request_model.dart';

abstract class RegisterEvents extends Equatable {}

class RegisterUserEvent extends RegisterEvents {
  RegisterRequestModel registerRequestModel;
  RegisterUserEvent({@required this.registerRequestModel})
      : assert(registerRequestModel != null);
  @override
  List<Object> get props => [registerRequestModel];
}
