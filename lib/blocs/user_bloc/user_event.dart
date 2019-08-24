import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserEvent extends Equatable {
  UserEvent([List props = const []]) : super(props);
}

class LoginWithCode extends UserEvent {
  final BuildContext context;

  LoginWithCode({@required this.context})
      : super([
          context
        ]);

  @override
  String toString() => 'LoginWithCode';
}

class SaveToken extends UserEvent {
  final String token;

  SaveToken({@required this.token})
      : super([
          token
        ]);

  @override
  String toString() => 'SaveToken { token: $token }';
}

class GetUserInfo extends UserEvent {
  final String token;

  GetUserInfo({@required this.token})
      : super([
          token
        ]);

  @override
  String toString() => 'SaveToken { token: $token }';
}

class SetUserInfo extends UserEvent {
  final Map userInfo;

  SetUserInfo({@required this.userInfo})
      : super([
          userInfo
        ]);

  @override
  String toString() => 'SaveToken { userInfo: $userInfo }';
}
