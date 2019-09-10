import 'package:flutter/cupertino.dart';
// import 'package:eight/pages/dynamic/list/index.dart';
import 'package:eight/pages/user/me/index.dart';
import 'package:eight/pages/news/list/index.dart';
import 'package:eight/pages/dynamic/list/index.dart';
// import 'package:eight/pages/dynamic/detail/index.dart';
import 'package:flutter/services.dart';

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
    DynamicListPage(),
    NewsList(),
    UserMe(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: 0,
        onTap: (idx) {
          HapticFeedback.lightImpact();
          return idx;
        },
        border: Border(top: BorderSide(style: BorderStyle.none)),
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("动态")),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.game_controller), title: Text("资讯")),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled, size: 36)),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.news), title: Text("囧图")),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), title: Text("我")),
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
