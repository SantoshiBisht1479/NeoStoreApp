import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/api/network_services.dart';
import 'package:neostore/bloc/myOrdersBloc.dart/myOrderStates.dart';
import 'package:neostore/bloc/myOrdersBloc.dart/myOrders_events.dart';
import 'package:neostore/model/login_error_model.dart';
import 'package:neostore/model/myOder_model.dart';
import 'package:neostore/model/myOrderDetail_model.dart';

class MyOrdersBloc extends Bloc<MyOrderEvents, MyOrderState> {
  MyOrdersBloc() : super(InitialOrderState());

  @override
  Stream<MyOrderState> mapEventToState(MyOrderEvents event) async* {
    if (event is GetMyOrdersEvent) {
      yield LoadingOrderState();
      try {
        var response = await NetworkServices().getMyOrders(event.accessToken);
        if (response.statusCode == 200) {
          var decodedData = json.decode(response.data);
          if (decodedData['data'].length == 0) {
            print('empty');
            print(response.data);
            // var errorResponse =
            //     LoginErrorModel.fromJson(json.decode(response.data));
            yield EmptyOrderState(emptyMessage: 'No orders placed yet !');
          } else {
            print('data present');
            var responsedata =
                MyOrderModel.fromJson(json.decode(response.data));
            yield LoadedOrderState(myOrderModel: responsedata);
          }
        }
      } on DioError catch (e) {
        yield FailureOrderState(errorMessage: 'Error Fetching Data');
      }
    }

    if (event is GetOrderDetailEvent) {
      yield LoadingOrderState();
      try {
        var response = await NetworkServices()
            .getMyOrderDetails(event.accessToken, event.orderId);
        if (response.statusCode == 200) {
          var responseData =
              MyOrderDetailModel.fromJson(json.decode(response.data));
          yield SuccessOrderDetailState(myOrderDetailModel: responseData);
        }
      } catch (e) {
        yield FailureOrderState(errorMessage: 'Error fetching Order Details');
      }
    }
  }
}
