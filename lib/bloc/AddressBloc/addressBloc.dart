import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/DatabaseHelper/database_helper.dart';
import 'package:neostore/api/network_services.dart';
import 'package:neostore/bloc/AddressBloc/addressBloc_events.dart';
import 'package:neostore/bloc/AddressBloc/addressBloc_states.dart';
import 'package:neostore/model/forgot_pass_response_model.dart';

class AddressBloc extends Bloc<AddressBlocEvents, AddressBlocState> {
  AddressBloc() : super(InitialAddressBlocState());

  @override
  Stream<AddressBlocState> mapEventToState(AddressBlocEvents event) async* {
    if (event is SaveNewAddressEvent) {
      DatabaseHelper db = DatabaseHelper.instance;
      int result = await db.insertAddress(event.addressModel);
      if (result != null) {
        yield SuccessAddressBlocState();
        print(result);
      } else {
        yield FailureAddressBlocState(errorMessage: 'Failed');
      }
    }
    if (event is AddNewAddressEvent) {
      //yield LoadingAddressBlocState();

      DatabaseHelper db = DatabaseHelper.instance;
      var response = await db.getAddress();
      if (response.length > 0) {}
      yield SuccessAddressBlocState(addressModel: response);
    } else {
      yield FailureAddressBlocState(errorMessage: 'error fetching data');
      print('404');
    }

    if (event is DeleteAddressEvent) {
      DatabaseHelper db = DatabaseHelper.instance;
      var result = await db.deleteAddress(event.id);
      if (result != null) {
        print(result);
      } else {
        print('error deleting data');
      }
    }

    if (event is PlaceOrderEvent) {
      try {
        var response = await NetworkServices()
            .placeOrder(event.accessToken, event.address);
        if (response.statusCode == 200) {
          var responseData =
              ForgotPassResponsetModel.fromJson(json.decode(response.data));

          yield SuccessOrderPlaceState(forgotPassResponsetModel: responseData);
        }
      } on DioError catch (e) {
        yield FailureAddressBlocState(errorMessage: 'Failed to place Order');
      }
    }
  }
}
