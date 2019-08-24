import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:reactmobi/pages/user/login/phone/index.dart';
// enum UserEvent { toggle }

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

class UserBloc extends Bloc<UserEvent, Map> {
  @override
  Map get initialState => {};

  @override
  Stream<Map> mapEventToState(UserEvent event) async* {
    if (event is SaveToken) {
      yield {
        'token': event.token
      };
    }
    if (event is LoginWithCode) {
      Navigator.of(event.context, rootNavigator: true).push(
        CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: CupertinoColors.white,
              border: Border(
                top: BorderSide(
                  style: BorderStyle.none,
                ),
              ),
              // leading: Icon(CupertinoIcons.back),
              leading: CupertinoNavigationBarBackButton(),
              middle: Text(
                '登录',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: new TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            child: UserPhoneLogin(),
          ),
        ),
      );
    }
  }
}
