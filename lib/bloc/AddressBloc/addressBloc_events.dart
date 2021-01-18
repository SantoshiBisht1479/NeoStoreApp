import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/addressModel.dart';

abstract class AddressBlocEvents extends Equatable {}

class AddNewAddressEvent extends AddressBlocEvents {
  @override
  List<Object> get props => [];
}

class SaveNewAddressEvent extends AddressBlocEvents {
  AddressModel addressModel;
  SaveNewAddressEvent({@required this.addressModel})
      : assert(addressModel != null);
  @override
  List<Object> get props => [addressModel];
}

class DeleteAddressEvent extends AddressBlocEvents {
  int id;
  DeleteAddressEvent({@required this.id});

  @override
  List<Object> get props => [id];
}

class PlaceOrderEvent extends AddressBlocEvents {
  String accessToken;
  String address;
  PlaceOrderEvent({@required this.accessToken, @required this.address});
  @override
  List<Object> get props => [accessToken, address];
}
