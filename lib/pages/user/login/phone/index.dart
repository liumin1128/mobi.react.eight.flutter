import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eight/graphql/schema/user.dart';
import 'package:eight/utils/common.dart';
import 'package:eight/utils/action.dart';
import 'getPhoneCode.dart';
import 'showCountryCodePicker.dart';

import 'package:eight/blocs/counter_bloc.dart';
import 'package:eight/blocs/user_bloc/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  FocusNode focusNodePhone = FocusNode();
  FocusNode focusNodeCode = FocusNode();

  String _countryCode;

  @override
  void initState() {
    super.initState();
    _phone = TextEditingController(text: '');
    _code = TextEditingController(text: '');
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

  Future<void> _loginWithCode(BuildContext context, String countryCode, String purePhoneNumber, String code) async {
    if (countryCode == '') return;
    if (purePhoneNumber == '') {
      return;
    }
    if (code == '') return;
    final QueryResult res = await widget.client.mutate(MutationOptions(
      document: userLoginByPhonenumberCode,
      variables: {
        'countryCode': countryCode,
        'purePhoneNumber': purePhoneNumber,
        'code': code,
      },
    ));

    if (res.hasErrors) return;

    final data = res.data['result'];

    if (data['status'] == 200) {
      print('登录成功');
      print(data['token']);

      _userLogin(context, data['token']);
    } else if (data['status'] == 403) {
      print('用户名密码错误');
    } else {
      print(data['message']);
    }
  }

  Future<void> _userLogin(BuildContext context, String token) async {
    Navigator.of(context, rootNavigator: true).popAndPushNamed('/');

    final userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.dispatch(GetUserInfo(token: token));
    return;
  }

  @override
  Widget build(BuildContext context) {
    // final counterBloc = BlocProvider.of<CounterBloc>(context);
    // final userBloc = BlocProvider.of<UserBloc>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 输入手机号
              CupertinoTextField(
                controller: _phone,
                placeholder: '手机号',
                // autofocus: true,
                focusNode: focusNodePhone,
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

                // 设置国家
                prefix: GestureDetector(
                  onTap: () {
                    showCountryCodePicker(context, (val) {
                      setState(() {
                        _countryCode = val;
                      });
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      _countryCode,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.all(16)),

              // 输入验证码
              CupertinoTextField(
                placeholder: "验证码",
                controller: _code,
                // autofocus: true,
                focusNode: focusNodeCode,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly, //只输入数字
                  LengthLimitingTextInputFormatter(6) //限制长度
                ],
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
                suffix: GetPhoneCodeButton(
                  enabled: isPhoneNumber(_phone.text),
                  onPress: () {
                    setState(() {
                      _getPhoneCode(_phone.text, _countryCode);
                      focusNodePhone.unfocus();
                      FocusScope.of(context).requestFocus(focusNodeCode);
                    });
                  },
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
                  // onPressed: isPhoneNumber(_phone.text) && _code.text != ''
                  onPressed: () {
                    print('phone.text111111');
                    print(_phone.text);
                    print(_code.text);
                    print(_countryCode);

                    // _userLogin(context, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiNWJlOTQ0MTRhZWI2NzgwMjZjMGEwNmNiIiwiaWF0IjoxNTY2NTQ0MDgyLCJleHAiOjE1NjcxNDg4ODJ9.jjxfsENlqWMGn9z70Yap3YXPJCEZUgkvqKRyhJ8eCl8');
                    // counterBloc.dispatch(CounterEvent.increment);
                    // userBloc.dispatch(GetUserInfo(token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiNWJlOTQ0MTRhZWI2NzgwMjZjMGEwNmNiIiwiaWF0IjoxNTY2NjYwMzE0LCJleHAiOjE1NjcyNjUxMTR9.RJukMemk7wSiiMNktKBbmrwz75H32-ai8sh2YMVMBAs'));
                    // return;

                    if (!isPhoneNumber(_phone.text)) {
                      alert(
                        context: context,
                        title: '电话号码错误',
                        content: '电话号码格式不正确，请重新输入',
                      );
                      return;
                    }

                    if (_code.text == '' || _code.text.length != 6) {
                      alert(
                        context: context,
                        title: '验证码错误',
                        content: '验证码格式不正确，请重新输入',
                      );
                      return;
                    }

                    _loginWithCode(context, _countryCode, _phone.text, _code.text);
                  },
                ),
              ),
              CupertinoButton(
                child: Text('账号密码登录'),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pushNamed('/user/login/password');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
