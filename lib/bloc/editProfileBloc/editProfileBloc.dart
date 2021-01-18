import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/api/network_services.dart';
import 'package:neostore/bloc/editProfileBloc/editProfile_events.dart';
import 'package:neostore/bloc/editProfileBloc/editProfile_states.dart';
import 'package:neostore/model/login_error_model.dart';
import 'package:neostore/model/update_response_detail_model.dart';

class EditProfileBloc extends Bloc<EditProfileEvents, EditProfileStates> {
  EditProfileBloc() : super(InitialProfileEdit());

  @override
  Stream<EditProfileStates> mapEventToState(EditProfileEvents event) async* {
    if (event is EditUserProfile) {
      try {
        var response = await NetworkServices().updateDetailRequest(
            event.accessToken, event.updateReqUserDetailModel);

        if (response.statusCode == 200) {
          var responsedata = UpdateResponseUserDetailModel.fromJson(
              json.decode(response.data));
          print(responsedata.userMsg);
          yield EditProfileSuccessState(
              updateResponseUserDetailModel: responsedata);
        }
      } on DioError catch (e) {
        var errorData = LoginErrorModel.fromJson(json.decode(e.response.data));
        yield EditProfileFailureState(failureErrorModel: errorData);
      }
    }
  }
}
