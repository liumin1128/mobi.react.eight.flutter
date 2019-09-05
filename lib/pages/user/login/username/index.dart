import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/graphql/schema/user.dart';
import 'package:eight/utils/common.dart';
import 'package:eight/utils/action.dart';
import 'package:eight/blocs/user_bloc/index.dart';

class UserPasswordLogin extends StatefulWidget {
  @override
  _UserPasswordLoginState createState() => _UserPasswordLoginState();
}

class _UserPasswordLoginState extends State<UserPasswordLogin> {
  @override
  Widget build(BuildContext context) {
    return GraphQLConsumer(builder: (GraphQLClient client) {
      return UserPasswordLoginWithClient(client: client);
    });
  }
}

class UserPasswordLoginWithClient extends StatefulWidget {
  UserPasswordLoginWithClient({Key key, this.client}) : super(key: key);
  final GraphQLClient client;
  @override
  _UserPasswordLoginWithClientState createState() => _UserPasswordLoginWithClientState();
}

class _UserPasswordLoginWithClientState extends State<UserPasswordLoginWithClient> {
  TextEditingController _username;
  TextEditingController _password;
  FocusNode focusNodePhone = FocusNode();
  FocusNode focusNodeCode = FocusNode();

  @override
  void initState() {
    super.initState();
    _username = TextEditingController(text: '18629974148');
    _password = TextEditingController(text: '123123123');
  }

  Future<void> _loginWithPassword(String username, String password) async {
    final QueryResult res = await widget.client.mutate(MutationOptions(
      document: userLogin,
      variables: {
        'username': username,
        'password': password
      },
    ));

    if (res.hasErrors) return;

    final data = res.data['result'];

    if (data['status'] == 200) {
      print('登录成功');
      print('登录成功');
      print(data['token']);

      Navigator.pop(context, 1);

      _userLogin(context, data['token']);
    } else if (data['status'] == 403) {
      print('用户名密码错误');
    } else {
      print('登录失败');
    }
  }

  Future<void> _userLogin(BuildContext context, String token) async {
    final userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.dispatch(GetUserInfo(token: token));
    return;
  }

  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoTextField(
                controller: _username,
                placeholder: '手机号或邮箱',
                focusNode: focusNodePhone,
                onChanged: (str) {
                  setState(() {
                    _username = TextEditingController.fromValue(
                      TextEditingValue(
                        // 设置内容
                        text: str,
                        // 保持光标在最后
                        selection: TextSelection.fromPosition(
                          TextPosition(
                            affinity: TextAffinity.downstream,
                            offset: str.length,
                          ),
                        ),
                      ),
                    );
                  });
                },
                keyboardType: TextInputType.phone,
                style: TextStyle(
                  fontSize: 22,
                  color: CupertinoColors.black,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      style: BorderStyle.solid,
                      color: CupertinoColors.extraLightBackgroundGray,
                    ),
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.all(16)),

              // 输入验证码
              CupertinoTextField(
                placeholder: "验证码",
                controller: _password,
                // autofocus: true,
                focusNode: focusNodeCode,

                onChanged: (str) {
                  setState(() {
                    _password = TextEditingController.fromValue(
                      TextEditingValue(
                        // 设置内容
                        text: str,
                        // 保持光标在最后
                        selection: TextSelection.fromPosition(
                          TextPosition(
                            affinity: TextAffinity.downstream,
                            offset: str.length,
                          ),
                        ),
                      ),
                    );
                  });
                },
                // keyboardType: TextInputType.phone,
                style: TextStyle(
                  fontSize: 22,
                  color: CupertinoColors.black,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      style: BorderStyle.solid,
                      color: CupertinoColors.extraLightBackgroundGray,
                    ),
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.all(16)),

              // 全宽按钮
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  child: Text('立即登录'),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  color: CupertinoTheme.of(context).primaryColor,
                  // onPressed: isPhoneNumber(_username.text) && _password.text != ''
                  onPressed: () {
                    print('phone.text111111');
                    print(_username.text);
                    print(_password.text);

                    // _userLogin(context, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiNWJlOTQ0MTRhZWI2NzgwMjZjMGEwNmNiIiwiaWF0IjoxNTY2NTQ0MDgyLCJleHAiOjE1NjcxNDg4ODJ9.jjxfsENlqWMGn9z70Yap3YXPJCEZUgkvqKRyhJ8eCl8');
                    // counterBloc.dispatch(CounterEvent.increment);
                    // userBloc.dispatch(GetUserInfo(token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiNWJlOTQ0MTRhZWI2NzgwMjZjMGEwNmNiIiwiaWF0IjoxNTY2NjYwMzE0LCJleHAiOjE1NjcyNjUxMTR9.RJukMemk7wSiiMNktKBbmrwz75H32-ai8sh2YMVMBAs'));
                    // return;

                    if (!isPhoneNumber(_username.text)) {
                      alert(
                        context: context,
                        title: '电话号码错误',
                        content: '电话号码格式不正确，请重新输入',
                      );
                      return;
                    }

                    if (_password.text == '') {
                      alert(
                        context: context,
                        title: '验证码错误',
                        content: '验证码格式不正确，请重新输入',
                      );
                      return;
                    }

                    _loginWithPassword(_username.text, _password.text);
                  },
                ),
              ),
              CupertinoButton(
                child: Text('手机号登录'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pushNamed('/user/login/phone');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
