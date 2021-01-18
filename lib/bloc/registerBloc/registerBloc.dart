import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/api/network_services.dart';
import 'package:neostore/bloc/registerBloc/register_events.dart';
import 'package:neostore/bloc/registerBloc/register_states.dart';
import 'package:neostore/model/login_error_model.dart';
import 'package:neostore/model/signup_response_model.dart';

class RegisterBloc extends Bloc<RegisterEvents, RegisterStates> {
  RegisterBloc() : super(InitialRegisterState());

  @override
  Stream<RegisterStates> mapEventToState(RegisterEvents event) async* {
    if (event is RegisterUserEvent) {
      try {
        var response =
            await NetworkServices().register(event.registerRequestModel);
        if (response.statusCode == 200) {
          var responseData =
              RegisterResponseModel.fromJson(json.decode(response.data));
          print(responseData.data.accessToken);

          yield SuccessRegisterState(registerResponseModel: responseData);
        }
      } on DioError catch (e) {
        var errorResponse =
            LoginErrorModel.fromJson(json.decode(e.response.data));
        yield FailureRegisterState(loginErrorModel: errorResponse);
      }
    }
  }
}
