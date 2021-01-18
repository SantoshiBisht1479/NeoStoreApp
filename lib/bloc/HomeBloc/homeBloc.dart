import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/api/network_services.dart';
import 'package:neostore/bloc/HomeBloc/home_bloc_events.dart';
import 'package:neostore/bloc/HomeBloc/home_bloc_states.dart';
import 'package:neostore/model/get_user_detail_model.dart';
import 'package:neostore/model/login_error_model.dart';

class HomeBloc extends Bloc<HomeBlocEvents, HomeBlocStates> {
  HomeBloc() : super(InitialHomeBloc());

  @override
  Stream<HomeBlocStates> mapEventToState(HomeBlocEvents event) async* {
    if (event is HomeBlocData) {
      //yield HomeBlocLoading();
      try {
        var response = await NetworkServices().getUserDetail(event.accessToken);
        if (response.statusCode == 200) {
          var responseData =
              GetUserDetailModel.fromJson(json.decode(response.data));

          yield HomeBlocSuccessState(getUserDetailModel: responseData);
        }
      } on DioError catch (e) {
        var errorResponse =
            LoginErrorModel.fromJson(json.decode(e.response.data));
        yield HomeBlocFailureState(loginErrorModel: errorResponse);
      }
    }
  }
}
