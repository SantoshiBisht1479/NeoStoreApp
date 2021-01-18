import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/api/network_services.dart';
import 'package:neostore/bloc/loginBloc/login_events.dart';
import 'package:neostore/bloc/loginBloc/login_states.dart';
import 'package:neostore/model/login_error_model.dart';
import 'package:neostore/model/signup_response_model.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  LoginBloc() : super(InitialloginState());

  @override
  Stream<LoginStates> mapEventToState(LoginEvents event) async* {
    if (event is LoginUserEvent) {
      try {
        var response =
            await NetworkServices().loginRequest(event.loginRequestModel);
        if (response.statusCode == 200) {
          //print(response.data);
          var dataresponse =
              RegisterResponseModel.fromJson(json.decode(response.data));
          print(dataresponse.data.firstName);
          yield LoginSuccessState(
              accessToken: dataresponse.data.accessToken,
              userName: dataresponse.data.username);

          //SharedPrefernceData.storeLoggedUserDetail(dataresponse);
          // try {
          //   var userResponse = await NetworkServices()
          //       .getUserDetail(dataresponse.data.accessToken);
          //   if (userResponse.statusCode == 200) {
          //     var userDataResponse =
          //         GetUserDetailModel.fromJson(json.decode(userResponse.data));

          //     print('****************');

          //     print(userDataResponse.data.userData.firstName);
          //     yield LoginSuccessState(accessToken: userDataResponse.data.userData.accessToken);
          //   }
          // } on DioError catch (e) {
          //   print(e.response);
          // }
        }
      } on DioError catch (e) {
        print(e.response);
        var errordata = LoginErrorModel.fromJson(json.decode(e.response.data));

        yield LoginfailureState(loginErrorModel: errordata);
      }
    }
  }
}
