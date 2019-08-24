import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reactmobi/pages/user/login/phone/index.dart';
import 'index.dart';
import 'package:reactmobi/graphql/schema/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    if (event is GetUserInfo) {
      // 设置token
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', event.token);

      // 获取用户信息
      final QueryResult res = await client.mutate(MutationOptions(document: userInfo));

      if (res.hasErrors) return;

      var _userInfo = res.data['userInfo'];

      yield Authenticated(event.token, _userInfo);
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
