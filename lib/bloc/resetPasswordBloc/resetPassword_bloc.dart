import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/api/network_services.dart';
import 'package:neostore/bloc/resetPasswordBloc/resetPassword_events.dart';
import 'package:neostore/bloc/resetPasswordBloc/resetPassword_states.dart';
import 'package:neostore/model/login_error_model.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvents, ResetPasswordStates> {
  ResetPasswordBloc() : super(InitialResetPassword());

  @override
  Stream<ResetPasswordStates> mapEventToState(
      ResetPasswordEvents event) async* {
    if (event is ResetPassword) {
      try {
        var response = await NetworkServices()
            .changePassRequest(event.accessToken, event.changePasswordReqModel);

        if (response.statusCode == 200) {
          var responsedata =
              LoginErrorModel.fromJson(json.decode(response.data));
          yield ResetPasswordSuccessState(changePasswordResModel: responsedata);
        }
      } on DioError catch (e) {
        var errorData = LoginErrorModel.fromJson(json.decode(e.response.data));
        yield ResetpasswordFailureState(loginErrorModel: errorData);
      }
    }
  }
}
