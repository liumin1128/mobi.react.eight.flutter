import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reactmobi/graphql/schema/user.dart';
import 'dart:convert';
import 'package:reactmobi/utils/common.dart';
import 'getPhoneCode.dart';

void showCupertinoPicker(BuildContext context, onChange) {
  var val = 0;
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
            if (!snapshot.hasData) return Center(child: Container(width: 16, height: 16, child: CupertinoActivityIndicator()));
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
                    // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new GestureDetector(
                          onTap: () {
                            Navigator.pop(context, 1);
                          },
                          child: new Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            child: new Text(
                              '确认',
                              style: new TextStyle(fontSize: 20, color: CupertinoTheme.of(context).primaryColor),
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
  // TextEditingController _username;
  // TextEditingController _password;
  String _countryCode;

  @override
  void initState() {
    super.initState();
    _phone = TextEditingController(text: '');
    _code = TextEditingController(text: '');

    // _username = TextEditingController(text: '18629974148');
    // _password = TextEditingController(text: '123456');

    _countryCode = '+86';
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
    } else if (data['status'] == 403) {
      print('用户名密码错误');
    } else {
      print('登录失败');
    }
  }

  Future<void> _getPhoneCode(String purePhoneNumber, String countryCode) async {
    print(purePhoneNumber);
    print(countryCode);
    final QueryResult res = await widget.client.mutate(MutationOptions(
      document: getPhoneNumberCode,
      variables: {
        'purePhoneNumber': purePhoneNumber,
        'countryCode': countryCode
      },
    ));

    if (res.hasErrors) return;

    final data = res.data['result'];

    if (data['status'] == 200) {
      // showCupertinoAlert()
      print('获取验证码成功');
    } else {
      print('获取验证码失败');
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
            // 输入手机号
            CupertinoTextField(
              controller: _phone,
              placeholder: '输入手机号',
              autofocus: true,
              onChanged: (str) {
                setState(() {
                  _phone = TextEditingController.fromValue(
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

              style: new TextStyle(
                fontSize: 22,
                color: Colors.black87,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.black12,
                  ),
                ),
              ),

              // 设置国家
              prefix: new GestureDetector(
                onTap: () {
                  showCupertinoPicker(context, (val) {
                    setState(() {
                      _countryCode = val;
                    });
                  });
                },
                child: new Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: new Text(
                    _countryCode,
                    style: new TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(16)),

            // 输入验证码
            CupertinoTextField(
                controller: _code,
                autofocus: true,
                onChanged: (str) {
                  setState(() {
                    _code = TextEditingController.fromValue(
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
                style: new TextStyle(
                  fontSize: 22,
                  color: Colors.black87,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.black12,
                    ),
                  ),
                ),
                suffix: GetPhoneCodeButton(
                  enabled: isPhoneNumber(_phone.text),
                  onPress: () {
                    _getPhoneCode(_phone.text, _countryCode);
                  },
                )

                // suffix: CupertinoButton(
                //   minSize: 20,
                //   padding: const EdgeInsets.all(6),
                //   child: Text('获取验证码'),
                //   // disabledColor: Colors.black12,
                //   // onPressed: () {
                //   //   _getPhoneCode(_phone.text, _countryCode);
                //   // },
                //   onPressed: isPhoneNumber(_phone.text)
                //       ? () {
                //           _getPhoneCode(_phone.text, _countryCode);
                //         }
                //       : null,
                // ),

                // suffix: GestureDetector(
                //   onTap: () {
                //     _getPhoneCode(_phone.text, _countryCode);
                //   },
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(vertical: 4),
                //     // decoration: BoxDecoration(
                //     //   border: Border.all(),
                //     // ),
                //     child: Text(
                //       '获取验证码',
                //       style: new TextStyle(fontSize: 20, color: Colors.black38),
                //     ),
                //   ),
                // ),
                ),

            Padding(padding: EdgeInsets.all(16)),

            // 全宽按钮
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                  child: Text('立即登录'),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  color: CupertinoTheme.of(context).primaryColor,
                  // onPressed: isPhoneNumber(_phone.text) && _code.text != ''
                  onPressed: () {
                    print('phone.text');
                    print(_phone.text);
                    print(_code.text);
                    print(_countryCode);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
