import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/api/network_services.dart';
import 'package:neostore/bloc/myAccountBloc/myAccountEvents.dart';
import 'package:neostore/bloc/myAccountBloc/myAccountStates.dart';
import 'package:neostore/model/get_user_detail_model.dart';

class MyAccountBloc extends Bloc<MyAccountEvent, MyAccountState> {
  MyAccountBloc() : super(InitialMyAccountState());

  @override
  Stream<MyAccountState> mapEventToState(MyAccountEvent event) async* {
    if (event is GetUserDetailEvent) {
      yield LoadingStateAccountState();
      try {
        var response = await NetworkServices().getUserDetail(event.accessToken);
        if (response.statusCode == 200) {
          var responseData =
              GetUserDetailModel.fromJson(json.decode(response.data));

          yield LoadedAccountState(getUserDetailModel: responseData);
        }
      } on DioError catch (e) {
        // var errorResponse =
        // LoginErrorModel.fromJson(json.decode(e.response.data));
        yield FailureAccountState(errorMessage: 'error Loading data');
      }
    }
  }
}
