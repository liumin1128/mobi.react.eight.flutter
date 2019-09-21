import 'package:flutter/cupertino.dart';
import 'package:eight/pages/user/me/index.dart';
import 'package:eight/pages/news/list/index.dart';
import 'package:eight/pages/dynamic/list/index.dart';
import 'package:eight/pages/bxgif/list/index.dart';
import 'package:flutter/services.dart';
import 'package:eight/components/Animate/Scale/index.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  bool changed = false;

  static List<Widget> _widgetOptions = <Widget>[
    DynamicListPage(),
    NewsList(),
    BxgifListPage(),
    BxgifListPage(),
    UserMe(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: currentIndex,
        onTap: (idx) {
          HapticFeedback.selectionClick();

          if (idx == 2) {
            Navigator.of(context, rootNavigator: true).pushNamed('/dynamic/create');
            return 0;
          }

          setState(() {
            currentIndex = idx;
            changed = true;
          });

          return idx;
        },
        border: Border(top: BorderSide(style: BorderStyle.none)),
        items: [
          BottomNavigationBarItem(
            icon: (changed && currentIndex == 0) ? Scale(child: Icon(CupertinoIcons.home)) : Icon(CupertinoIcons.home),
            title: Text("动态"),
          ),
          BottomNavigationBarItem(
            icon: (changed && currentIndex == 1) ? Scale(child: Icon(CupertinoIcons.game_controller)) : Icon(CupertinoIcons.game_controller),
            title: Text("资讯"),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add_circled, size: 36),
          ),
          BottomNavigationBarItem(
            icon: (changed && currentIndex == 3) ? Scale(child: Icon(CupertinoIcons.news)) : Icon(CupertinoIcons.news),
            title: Text("囧图"),
          ),
          BottomNavigationBarItem(
            icon: (changed && currentIndex == 4) ? Scale(child: Icon(CupertinoIcons.person)) : Icon(CupertinoIcons.person),
            title: Text("我"),
          ),
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
