import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/api/network_services.dart';
import 'package:neostore/bloc/forgotPasswordBloc/forgotPassword_events.dart';
import 'package:neostore/bloc/forgotPasswordBloc/forgotPassword_states.dart';
import 'package:neostore/model/forgot_pass_response_model.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvents, ForgotPasswordStates> {
  ForgotPasswordBloc() : super(InitialForgotPasswordState());

  @override
  Stream<ForgotPasswordStates> mapEventToState(
      ForgotPasswordEvents event) async* {
    if (event is ForgotUserPasswordEvent) {
      try {
        var response = await NetworkServices()
            .forgotPassrequest(event.forgotPassRequestModel);
        if (response.statusCode == 200) {
          print(response.data);
          var responseData =
              ForgotPassResponsetModel.fromJson(json.decode(response.data));
          yield ForgotPasswordSuccessState(
              forgotPassResponsetModel: responseData);
        }
      } on DioError catch (e) {
        var responseData =
            ForgotPassResponsetModel.fromJson(json.decode(e.response.data));

        yield ForgotPasswordFailureState(
            forgotPassResponsetModel: responseData);
      }
    }
  }
}
