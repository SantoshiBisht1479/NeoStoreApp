import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class HomeBlocEvents extends Equatable {}

class HomeBlocData extends HomeBlocEvents {
  String accessToken;
  HomeBlocData({@required this.accessToken});

  @override
  List<Object> get props => [accessToken];
}
