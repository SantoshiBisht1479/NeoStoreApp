import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/update_req_detail_model.dart';

abstract class EditProfileEvents extends Equatable {}

class EditUserProfile extends EditProfileEvents {
  String accessToken;
  UpdateReqUserDetailModel updateReqUserDetailModel;
  EditUserProfile(
      {@required this.accessToken, @required this.updateReqUserDetailModel});
  @override
  // TODO: implement props
  List<Object> get props => [accessToken, updateReqUserDetailModel];
}
