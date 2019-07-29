import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reactmobi/graphql/schema/user.dart';

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  @override
  Widget build(BuildContext context) {
    return GraphQLConsumer(builder: (GraphQLClient client) {
      return UserLoginWithClient(client: client);
    });
  }
}

class UserLoginWithClient extends StatefulWidget {
  UserLoginWithClient({Key key, this.client}) : super(key: key);
  final GraphQLClient client;
  @override
  _UserLoginWithClientState createState() => _UserLoginWithClientState();
}

class _UserLoginWithClientState extends State<UserLoginWithClient> {
  TextEditingController _phone;
  TextEditingController _code;
  TextEditingController _username;
  TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _phone = TextEditingController(text: 'phone');
    _code = TextEditingController(text: 'code');

    _username = TextEditingController(text: '18629974148');
    _password = TextEditingController(text: '123456');
  }

  Future<void> loginWithPassword(String username, String password) async {
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
    } else if (data['status'] == 403) {
      print('用户名密码错误');
    } else {
      print('登录失败');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoTextField(controller: _phone),
        CupertinoTextField(controller: _code),
        CupertinoButton(
          child: Text('获取验证码'),
          onPressed: () {
            print('phone.text');
            print(_phone.text);
          },
        ),
        CupertinoTextField(controller: _username),
        CupertinoTextField(controller: _password),
        CupertinoButton(
          child: Text('登录'),
          onPressed: () {
            String username = _username.text;
            String password = _password.text;
            loginWithPassword(username, password);
          },
        ),
      ],
    )));
  }
}
