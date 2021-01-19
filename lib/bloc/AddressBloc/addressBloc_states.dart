import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/addressModel.dart';
import 'package:neostore/model/forgot_pass_response_model.dart';

abstract class AddressBlocState extends Equatable {}

class InitialAddressBlocState extends AddressBlocState {
  @override
  List<Object> get props => [];
}

class LoadingAddressBlocState extends AddressBlocState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class SuccessAddressBlocState extends AddressBlocState {
  List<AddressModel> addressModel;
  SuccessAddressBlocState({this.addressModel});
  @override
  List<Object> get props => [addressModel];
}

class FailureAddressBlocState extends AddressBlocState {
  String errorMessage;
  FailureAddressBlocState({@required this.errorMessage})
      : assert(errorMessage != null);
  @override
  List<Object> get props => [];
}

class SuccessOrderPlaceState extends AddressBlocState {
  ForgotPassResponsetModel forgotPassResponsetModel;
  SuccessOrderPlaceState({@required this.forgotPassResponsetModel});

  @override
  List<Object> get props => [forgotPassResponsetModel];
}


