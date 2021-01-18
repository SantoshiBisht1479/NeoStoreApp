import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/api/network_services.dart';
import 'package:neostore/bloc/CartBloc/cartBloc_events.dart';
import 'package:neostore/bloc/CartBloc/cartBloc_states.dart';
import 'package:neostore/model/addToCart_ListModel.dart';
import 'package:neostore/model/addToCart_Success_model.dart';
import 'package:neostore/model/forgot_pass_response_model.dart';
import 'package:neostore/model/login_error_model.dart';

class CartBlocList extends Bloc<CartBlocEvents, CartBlocStates> {
  CartBlocList() : super(InitialCartBlocState());

  @override
  Stream<CartBlocStates> mapEventToState(CartBlocEvents event) async* {
    if (event is ListCartListEvent) {
      //yield LoadingCartBlocState();
      // try {
      //   var response =
      //       await NetworkServices().addToCartList(event.access_token);

      //   if (response.statusCode == 200) {
      //     var responseData =
      //         AddToCartListModel.fromJson(json.decode(response.data));
      //     yield LoadedCartBlocState(addToCartListModel: responseData);
      //   }
      // } on DioError catch (e) {
      //   yield FailureCartBlocState(errorMessage: 'Something went wrong');
      // }
      try {
        var response =
            await NetworkServices().addToCartList(event.access_token);
        if (response.statusCode == 200) {
          var decodedData = json.decode(response.data);
          if (decodedData['data'] != null) {
            print(decodedData['data']);
            var responseData =
                AddToCartListModel.fromJson(json.decode(response.data));
            yield LoadedCartBlocState(addToCartListModel: responseData);
          } else {
            var responsedata =
                LoginErrorModel.fromJson(json.decode(response.data));
            yield EmptyCartBlocState(errorModel: responsedata);
          }
        }
      } on DioError catch (e) {
        yield FailureCartBlocState(errorMessage: 'Something went wrong');
      }
    }

    if (event is DeleteCartItem) {
      //yield LoadingCartBlocState();
      try {
        var response = await NetworkServices()
            .deleteCartItem(event.accessToken, event.product_id);
        if (response.statusCode == 200) {
          var responseData =
              AddToCartSuccessModel.fromJson(json.decode(response.data));

          print(responseData.userMsg);
        }
      } on DioError catch (e) {
        var errorData =
            ForgotPassResponsetModel.fromJson(json.decode(e.response.data));

        print(errorData.userMsg);
      }
    }

    if (event is EditCartItems) {
      //yield LoadingCartBlocState();
      try {
        var response = await NetworkServices()
            .editCartItems(event.accessToken, event.productId, event.quantity);

        if (response.statusCode == 200) {
          var responseData =
              AddToCartSuccessModel.fromJson(json.decode(response.data));
          print(responseData.userMsg);
        }
      } on DioError catch (e) {
        var errorData =
            ForgotPassResponsetModel.fromJson(json.decode(e.response.data));

        print(errorData.userMsg);
      }
    }
  }
}
