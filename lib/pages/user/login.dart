import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin, RouteAware {

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _email = '970568830@qq.com';
  String _password = '123456';
  bool _loading = false;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder (builder: (BuildContext context) {
        return Center(child: Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.all(16),
            child: Column(children: <Widget>[
              Padding(padding: EdgeInsets.all(8),),

              Form(
                key: _formKey,
                child: new Column(children: <Widget>[
                  new TextFormField(
                    initialValue: _email,
                    decoration: new InputDecoration(
                      labelText: 'Email',
                    ),
                    onSaved: (val) {
                      _email = val;
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8),),
                  new TextFormField(
                    initialValue: _password,
                    decoration: new InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (val) {
                      return val.length < 4 ? '密码长度错误': null;
                    },
                    onSaved: (val) {
                      return _password = val;
                    }
                  ),
                ],),
              ),

              Padding(padding: EdgeInsets.all(16),),

              Row(children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      var _form = _formKey.currentState;
                      if(_form.validate()) {
                        _form.save();
                        print(_email);
                        print(_password);

                        setState(() {
                          _loading = true;
                        });

                        // print('_password');
                        
                      }
                    },
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                    // child: Text('登录')
                    child: _loading 
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  <Widget>[
                        SizedBox(width: 16.0,height: 16.0, child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 1.5),),
                        Padding(padding: EdgeInsets.all(4)),
                        Text('登录', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ]
                    ) 
                    : Text('登录', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  )
                )
              ],),

              Row(children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    },
                    child: const Text('注册'),
                  )
                )
              ],),
            ],)
          ),
        ]));
      }),
    );
  }
}