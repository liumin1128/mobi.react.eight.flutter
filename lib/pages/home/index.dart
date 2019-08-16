import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reactmobi/pages/dynamic/list/index.dart';
import 'package:reactmobi/pages/user/me/index.dart';
import 'package:reactmobi/pages/news/list/index.dart';
// import 'package:reactmobi/pages/user/login.dart';
import 'package:reactmobi/pages/user/login/phone/index.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
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
          middle: Text("动态"),
          border: Border(
            top: BorderSide(
              style: BorderStyle.none,
            ),
          ),
          trailing: CupertinoButton(onPressed: () {}, child: Icon(CupertinoIcons.add), padding: const EdgeInsets.all(0))
          // trailing: Icon(CupertinoIcons.add)
          // backgroundColor: Colors.white,
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
    CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        border: Border(
          top: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        middle: Text(
          '登录',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: new TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      child: UserPhoneLogin(),
    ),
    UserMe(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            items: [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("动态")),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.game_controller), title: Text("资讯")),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), title: Text("设置")),
            ],
            currentIndex: 2,
            // 隐藏CupertinoTabBar上边
            border: Border(
              top: BorderSide(
                style: BorderStyle.none,
              ),
            )),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) {
              return _widgetOptions[index];
            },
          );
        });
  }
}
