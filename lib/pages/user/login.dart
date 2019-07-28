import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
  TextEditingController phone;
  TextEditingController username;
  TextEditingController code;

  @override
  void initState() {
    super.initState();
    phone = TextEditingController(text: 'phone');
    username = TextEditingController(text: 'username');
    code = TextEditingController(text: 'code');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CupertinoTextField(controller: phone),
        CupertinoButton(child: Text('获取验证码'), onPressed: () {}),
        CupertinoTextField(controller: username),
        CupertinoTextField(controller: code),
        CupertinoButton(child: Text('登录'), onPressed: () {}),
      ],
    )));
  }
}
