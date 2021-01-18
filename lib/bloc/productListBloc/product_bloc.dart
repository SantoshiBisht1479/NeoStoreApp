import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/api/network_services.dart';
import 'package:neostore/bloc/productListBloc/productList_events.dart';
import 'package:neostore/bloc/productListBloc/productList_states.dart';
import 'package:neostore/model/login_error_model.dart';
import 'package:neostore/model/product_category_list_model.dart';

class ProductListBloc extends Bloc<ProductListEvents, ProductListStates> {
  ProductListBloc() : super(InitialProductList());

  @override
  Stream<ProductListStates> mapEventToState(ProductListEvents event) async* {
    if (event is ShowProductList) {
      yield LoadingProductListState();
      try {
        var response = await NetworkServices().getProductList(event.productId);
        if (response.statusCode == 200) {
          var responseData =
              ProductCategoryModel.fromJson(json.decode(response.data));
          yield LoadedProductListState(productCategoryModel: responseData);
        }
      } on DioError catch (e) {
        var responseErrordata =
            LoginErrorModel.fromJson(json.decode(e.response.data));
        yield FailureProductListState(loginErrorModel: responseErrordata);
      }
    }
  }
}
