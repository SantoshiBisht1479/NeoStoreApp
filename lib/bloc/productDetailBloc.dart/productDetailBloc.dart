import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/api/network_services.dart';
import 'package:neostore/bloc/productDetailBloc.dart/productDetail_events.dart';
import 'package:neostore/bloc/productDetailBloc.dart/productDetail_states.dart';
import 'package:neostore/model/addToCart_Success_model.dart';
import 'package:neostore/model/login_error_model.dart';
import 'package:neostore/model/product_detail_model.dart';
import 'package:neostore/model/rating_success_model.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvents, ProductDetailStates> {
  ProductDetailBloc() : super(InitialProductDetailstates());

  @override
  Stream<ProductDetailStates> mapEventToState(
      ProductDetailEvents event) async* {
    if (event is FetchProductDetails) {
      //yield InitialProductDetailstates();
      try {
        var response =
            await NetworkServices().getProductDetails(event.productId);
        if (response.statusCode == 200) {
          var responseData =
              ProductDetailModel.fromJson(json.decode(response.data));

          yield LoadedProductDetailStates(productDetailModel: responseData);
        }
      } on DioError catch (e) {
        var errorResponse =
            LoginErrorModel.fromJson(json.decode(e.response.data));
        yield FailureProductDetailStates(
            productDetailerrorModel: errorResponse);
      }
    }

    if (event is SubmitRatingEvent) {
      //yield LoadingProductDetailsStates();
      try {
        var response = await NetworkServices()
            .getProductRatings(event.productId, event.ratings.toInt());

        if (response.statusCode == 200) {
          var responseData =
              RatingSuccessModel.fromJson(json.decode(response.data));
          print(responseData.userMsg);
        }
      } on DioError catch (e) {
        var errorresposeData =
            LoginErrorModel.fromJson(json.decode(e.response.data));
        print(errorresposeData.userMsg);
      }
    }

    if (event is AddQuantityEvent) {
      try {
        var response = await NetworkServices().addProductQuantity(
            event.accessToken, event.productId, event.quantity);

        if (response.statusCode == 200) {
          var responseData =
              AddToCartSuccessModel.fromJson(json.decode(response.data));
          print(responseData.userMsg);
        }
      } on DioError catch (e) {
        var errorresposeData =
            LoginErrorModel.fromJson(json.decode(e.response.data));
        print(errorresposeData.userMsg);
      }
    }
  }
}
