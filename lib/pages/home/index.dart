import 'package:flutter/cupertino.dart';
import 'package:reactmobi/pages/dynamic/list/index.dart';
import 'package:reactmobi/pages/user/me/index.dart';
import 'package:reactmobi/pages/news/list/index.dart';

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
        border: Border(top: BorderSide(style: BorderStyle.none)),
      ),
      child: DynamicList(),
    ),
    CupertinoPageScaffold(
      child: NewsList(),
    ),
    UserMe(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: 0,
        border: Border(top: BorderSide(style: BorderStyle.none)),
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("动态")),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.game_controller), title: Text("资讯")),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), title: Text("设置")),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(builder: (context) {
          return _widgetOptions[index];
        });
      },
    );
  }
}
