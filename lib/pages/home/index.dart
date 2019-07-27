import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../components/Icons/Eva.dart';
import '../dynamic/list/index.dart';
import '../news/list/index.dart';

class HomePage extends StatefulWidget {
  HomePage({ Key key, this.title }) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // int _selectedIndex = 1;
  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  
  static List<Widget> _widgetOptions = <Widget>[

    CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("资讯"),
      ),
      child: Center(
        child: DynamicList(),
      ),
    ),

    CupertinoPageScaffold(
      // navigationBar: CupertinoNavigationBar(
      //   middle: Text("资讯"),
      // ),
      child: Center(
        child: NewsList(),
      ),
    ),

    Text(
      'Index 1: Business',
      // style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),title: Text("动态")),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.game_controller,),title: Text("资讯")),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.person,),title: Text("设置")),
          ],
          currentIndex: 1,
          // 隐藏CupertinoTabBar上边
          border: Border(
            top: BorderSide(
              style: BorderStyle.none,
            ),
          )
        ),

        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) {
              return _widgetOptions[index];
            },
          );
        }
    );


  }
}


