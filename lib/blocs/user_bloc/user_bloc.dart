import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reactmobi/pages/user/login/phone/index.dart';
import 'index.dart';
import 'package:reactmobi/graphql/schema/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GraphQLClient client;

  UserBloc({@required this.client}) : assert(client != null);

  @override
  UserState get initialState => Uninitialized();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    // if (event is SaveToken) {
    //   dispatch(GetUserInfo(token: event.token));
    // }

    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoginWithCode) {
      yield* _mapLoginWithCodeToState(event);
    } else if (event is GetUserInfo) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<UserState> _mapAppStartedToState() async* {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final _token = prefs.getString('token');
      final _userInfo = prefs.getString('userInfo');

      print(_token);
      print(_userInfo);

      if (_token != null && _userInfo != null) {
        yield Authenticated(_token, json.decode(_userInfo));
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<UserState> _mapLoginWithCodeToState(event) async* {
    try {
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
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<UserState> _mapLoggedInToState(event) async* {
    // 设置token
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // 获取用户信息
    final QueryResult res = await client.mutate(MutationOptions(document: userInfo));

    if (res.hasErrors) return;

    var _userInfo = res.data['userInfo'];

    await prefs.setString('token', event.token);
    await prefs.setString('userInfo', json.encode(_userInfo));

    yield Authenticated(event.token, _userInfo);
  }

  Stream<UserState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
  }
}
