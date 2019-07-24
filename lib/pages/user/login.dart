import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  UserLogin({ Key key, this.title }) : super(key: key);
  final String title;
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动态'),
      ),
      body: Container(
        child: Text('Login')
      ),
    );
  }
}


