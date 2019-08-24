import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:eight/pages/user/login/phone/index.dart';
import 'package:eight/graphql/schema/user.dart';
import 'index.dart';
import 'package:eight/utils/action.dart';

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
      yield* _mapLoggedOutToState(event);
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

  // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiNWJlOTQ0MTRhZWI2NzgwMjZjMGEwNmNiIiwiaWF0IjoxNTY2NjYwMzE0LCJleHAiOjE1NjcyNjUxMTR9.RJukMemk7wSiiMNktKBbmrwz75H32-ai8sh2YMVMBAs

  Stream<UserState> _mapLoggedInToState(event) async* {
    try {
      // 设置token
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', event.token);

      // 获取用户信息
      final QueryResult res = await client.mutate(MutationOptions(document: userInfo));

      if (res.hasErrors) return;

      var _userInfo = res.data['userInfo'];

      await prefs.setString('userInfo', json.encode(_userInfo));

      yield Authenticated(event.token, _userInfo);
    } catch (_) {
      print('_mapLoggedInToState出错');
      yield Unauthenticated();
    }
  }

  Stream<UserState> _mapLoggedOutToState(event) async* {
    final action = await alert(context: event.context, title: '确认退出登录？', onConfirm: () {});

    if (action == Action.Ok) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      prefs.remove('userInfo');
      yield Unauthenticated();
    }

    if (action == Action.Cancel) {
      print('Cancel');
    }
  }
}
