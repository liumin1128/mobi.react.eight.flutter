import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginWithCode extends UserEvent {
  final BuildContext context;

  LoginWithCode({@required this.context});
}

class GetUserInfo extends UserEvent {
  final String token;

  GetUserInfo({@required this.token});
}

class AppStarted extends UserEvent {}

class LoggedIn extends UserEvent {}

class LoggedOut extends UserEvent {
  final BuildContext context;

  LoggedOut({@required this.context});
}
