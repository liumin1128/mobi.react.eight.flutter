import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:reactmobi/pages/user/login/phone/index.dart';
import 'index.dart';

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
