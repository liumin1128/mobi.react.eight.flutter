import 'package:flutter/cupertino.dart';

import 'package:eight/pages/dynamic/list/index.dart';
import 'package:eight/pages/news/list/index.dart';
import 'package:eight/pages/notification/list/index.dart';
import 'package:eight/pages/user/me/index.dart';

import 'package:eight/components/Animate/Scale/index.dart';
import 'package:eight/components/Icons/Eva.dart';

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
    NewsListPage(),
    NotificationListPage(),
    UserMe(),
  ];

  Widget _getIcon(int index, IconData icon) {
    return (changed && currentIndex == index)
        ? Scale(
            child: Icon(icon, size: 28),
          )
        : Icon(icon, size: 28);
  }

  _onTap(int idx) {
    // HapticFeedback.selectionClick();

    // if (idx == 2) {
    //   Navigator.of(context, rootNavigator: true).pushNamed('/dynamic/create');
    //   return 0;
    // }

    setState(() {
      currentIndex = idx;
      changed = true;
    });

    return idx;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: currentIndex,
        onTap: _onTap,
        iconSize: 24,
        inactiveColor: Color(0xFF999999),
        border: Border(top: BorderSide(style: BorderStyle.none)),
        items: [
          BottomNavigationBarItem(
            icon: _getIcon(0, EvaIcons.compassOutline),
            title: Text("动态"),
          ),
          BottomNavigationBarItem(
            icon: _getIcon(1, EvaIcons.gridOutline),
            title: Text("资讯"),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(EvaIcons.plusCircleOutline, size: 36),
          // ),
          BottomNavigationBarItem(
            icon: _getIcon(2, EvaIcons.messageSquareOutline),
            title: Text("囧图"),
          ),
          BottomNavigationBarItem(
            icon: _getIcon(4, EvaIcons.personOutline),
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
