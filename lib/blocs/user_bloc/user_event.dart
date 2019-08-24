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

class GetUserInfo extends UserEvent {
  final String token;

  GetUserInfo({@required this.token})
      : super([
          token
        ]);

  @override
  String toString() => 'GetUserInfo { token: $token }';
}
