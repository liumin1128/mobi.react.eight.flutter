import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  
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
      navigationBar: CupertinoNavigationBar(
        middle: Text("资讯"),
      ),
      child: Center(
        child: NewsList(),
      ),
    ),
    
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home,),title: Text("动态")),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.news,),title: Text("资讯")),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.person,),title: Text("设置")),
          ],
          currentIndex: 1,
          activeColor: Theme.of(context).accentColor,
          // inactiveColor: Color(0xff333333),
          // backgroundColor: Color(0xfff1f1f1),
          // iconSize: 25.0,
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) {
              return _widgetOptions[index];
            },
          );
        }
    );


    // return Scaffold(
    //   // appBar: AppBar(
    //   //   title: const Text('BottomNavigationBar Sample'),
    //   // ),
    //   body: Center(
    //     child: _widgetOptions[_selectedIndex],
    //   ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     items: const <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(icon: Icon(Icons.explore), title: Text('动态')),
    //       BottomNavigationBarItem(icon: Icon(Icons.business),title: Text('资讯')),
    //       BottomNavigationBarItem(icon: Icon(Icons.account_circle),title: Text('我的')),
    //     ],
    //     currentIndex: _selectedIndex,
    //     selectedItemColor: Colors.amber[800],
    //     onTap: _onItemTapped,
    //   ),
    // );
  }
}


