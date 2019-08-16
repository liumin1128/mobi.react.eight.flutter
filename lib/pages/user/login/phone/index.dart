import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reactmobi/graphql/schema/user.dart';
import 'dart:convert';

void showCupertinoPicker(BuildContext context, onChange) {
  var val;
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
        ),
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString('assets/config/countries.json'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: Text('loading'));
            if (snapshot.hasError) return Text('error');

            var countries = json.decode(snapshot.data.toString());

            List<Widget> list = [];

            for (var i in countries) {
              list.add(Text(
                i['name'] + ' ' + i['code'],
                style: new TextStyle(fontSize: 20, height: 1.5),
              ));
            }

            return Container(
              child: Column(
                children: <Widget>[
                  // Padding(padding: EdgeInsets.only(top: 8)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new GestureDetector(
                          onTap: () {
                            Navigator.pop(context, 1);
                          },
                          child: new Container(
                            child: new Text(
                              '取消',
                              style: new TextStyle(fontSize: 20, color: Colors.black38),
                            ),
                          ),
                        ),
                        Text(''),
                        new GestureDetector(
                          onTap: () {
                            final value = countries[val]['code'];
                            onChange(value);
                            Navigator.pop(context, 1);
                          },
                          child: new Container(
                            child: new Text(
                              '确认',
                              style: new TextStyle(fontSize: 20, color: Colors.amber),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 245,
                    child: CupertinoPicker(
                      itemExtent: 40,
                      // backgroundColor: Colors.white,
                      onSelectedItemChanged: (position) {
                        print('The position is $position');
                        val = position;
                      },
                      children: list,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

class UserPhoneLogin extends StatefulWidget {
  @override
  _UserPhoneLoginState createState() => _UserPhoneLoginState();
}

class _UserPhoneLoginState extends State<UserPhoneLogin> {
  @override
  Widget build(BuildContext context) {
    return GraphQLConsumer(builder: (GraphQLClient client) {
      return UserPhoneLoginWithClient(client: client);
    });
  }
}

class UserPhoneLoginWithClient extends StatefulWidget {
  UserPhoneLoginWithClient({Key key, this.client}) : super(key: key);
  final GraphQLClient client;
  @override
  _UserPhoneLoginWithClientState createState() => _UserPhoneLoginWithClientState();
}

class _UserPhoneLoginWithClientState extends State<UserPhoneLoginWithClient> {
  TextEditingController _phone;
  TextEditingController _code;
  TextEditingController _username;
  TextEditingController _password;
  String _countryCode;

  @override
  void initState() {
    super.initState();
    _phone = TextEditingController(text: '18629974148');
    _code = TextEditingController(text: 'code');

    _username = TextEditingController(text: '18629974148');
    _password = TextEditingController(text: '123456');

    _countryCode = '+86';
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
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoTextField(
              controller: _phone,
              autofocus: true,
              keyboardType: TextInputType.phone,
              style: new TextStyle(fontSize: 24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.black12,
                  ),
                ),
              ),
              prefix: new GestureDetector(
                onTap: () {
                  showCupertinoPicker(context, (val) {
                    print(val);
                    print(val);
                    print(val);
                    setState(() {
                      _countryCode = val;
                    });
                  });
                },
                child: new Container(
                  // color: Colors.yellow,
                  child: new Text(
                    _countryCode,
                    style: new TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(16)),
            CupertinoTextField(
              controller: _code,
              autofocus: true,
              keyboardType: TextInputType.phone,
              style: new TextStyle(fontSize: 24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.black12,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(16)),

            CupertinoButton(
              child: Text('获取验证码'),
              onPressed: () {
                print('phone.text');
                print(_phone.text);
              },
            ),
            // CupertinoTextField(controller: _username),
            // CupertinoTextField(controller: _password),
            // CupertinoButton(
            //   child: Text('登录'),
            //   onPressed: () {
            //     String username = _username.text;
            //     String password = _password.text;
            //     loginWithPassword(username, password);
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
