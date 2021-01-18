import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/login_error_model.dart';
import 'package:neostore/model/update_response_detail_model.dart';

abstract class EditProfileStates extends Equatable {}

class InitialProfileEdit extends EditProfileStates {
  @override
  List<Object> get props => [];
}

class EditProfileSuccessState extends EditProfileStates {
  UpdateResponseUserDetailModel updateResponseUserDetailModel;
  EditProfileSuccessState({@required this.updateResponseUserDetailModel})
      : assert(updateResponseUserDetailModel != null);
  @override
  List<Object> get props => [updateResponseUserDetailModel];
}

class EditProfileFailureState extends EditProfileStates {
  LoginErrorModel failureErrorModel;
  EditProfileFailureState({@required this.failureErrorModel})
      : assert(failureErrorModel != null);
  @override
  List<Object> get props => [failureErrorModel];
}
