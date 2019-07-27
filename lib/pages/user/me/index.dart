import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class UserMe extends StatefulWidget {
  UserMe({ Key key, this.title }) : super(key: key);
  final String title;
  @override
  _UserMeState createState() => _UserMeState();
}

class _UserMeState extends State<UserMe> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text('xxxxxxxxx'),
      ),
    );
  }
}


