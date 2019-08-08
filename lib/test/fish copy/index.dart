import 'package:flutter/cupertino.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import './page.dart';

class FishSimpleDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    println('main');
    final AbstractRoutes routes = PageRoutes(
      pages: <String, Page<Object, dynamic>>{
        'main': MainPage(),
      },
    );
    return MaterialApp(
      title: 'Simple',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: routes.buildPage('main', null),
    );
  }
}
