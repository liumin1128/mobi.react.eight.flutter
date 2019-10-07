import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:eight/blocs/user/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/components/Avatar/index.dart';
import 'package:eight/components/Icons/Taobao.dart';
import 'package:eight/components/Icons/Eva.dart';

infoItem(String value, String label) {
  return Container(
    margin: EdgeInsets.only(right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(value, style: TextStyle(color: Color(0xFF333333), fontSize: 24)),
        Padding(padding: EdgeInsets.all(4)),
        Text(label, style: TextStyle(fontSize: 14, color: Color(0xFF999999))),
      ],
    ),
  );
}

tag(String text) {
  return Container(
    child: Text(text, style: TextStyle(color: Color(0xFF999999))),
    margin: EdgeInsets.only(right: 8),
    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
    decoration: BoxDecoration(
      color: Color(0xffeeeeee),
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final CupertinoTabBar child;

  _StickyTabBarDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
    @required this.nickname,
    @required this.avatar,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;
  final Widget nickname;
  final Widget avatar;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double progress = 0;

    if (shrinkOffset < 0) {
    } else {
      progress = (shrinkOffset - 0) / (maxHeight - minHeight);
      progress = progress > 1 ? 1 : progress;
      progress = progress < 0 ? 0 : progress;
    }

    return Stack(
      children: <Widget>[
        Container(
          child: SizedBox.expand(child: child),
          // padding: EdgeInsets.only(bottom: paddingBottom),
        ),
        SizedBox.expand(
          child: Opacity(
            opacity: progress,
            // child: ClipRect(
            //   child: BackdropFilter(
            //     filter: ImageFilter.blur(sigmaX: opacity * 30, sigmaY: opacity * 30),
            child: Container(
              padding: EdgeInsets.only(top: 12),
              child: nickname,
              color: Color(0xFFFFFFFF),
            ),
            //   ),
            // ),
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: SizedBox(
            width: 80 * (1 - progress * 0.6),
            height: 80 * (1 - progress * 0.6),
            child: avatar,
          ),
        ),
        SizedBox.expand(
          child: Opacity(
            opacity: (1 - progress),
            child: Container(
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(24),
              child: Container(
                // width: 100,
                // height: 100,
                // color: Color(0xFFFFFFFF),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(TaobaoIcons.settings),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}

class UserMe extends StatefulWidget {
  @override
  UserMeState createState() => UserMeState();
}

class UserMeState extends State<UserMe> {
  ScrollController _scrollController = ScrollController(); //listview的控制器

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _onScrollToBottom();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<Null> _onScrollToBottom() async {
    print('onScrollToBottom');
    // if(widget.onScrollToBottom != null) {
    // await widget.onScrollToBottom();
    // }
  }

  @override
  Widget build(BuildContext context) {
    // final themeBloc = BlocProvider.of<ThemeBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is Uninitialized) {
          return CupertinoPageScaffold(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        } else if (state is Unauthenticated) {
          return CupertinoPageScaffold(
            child: Center(
                child: Column(children: <Widget>[
              Padding(padding: EdgeInsets.all(32)),
              Text('Unauthenticated'),
              CupertinoButton(
                child: Text('立即登录'),
                onPressed: () {
                  // userBloc.dispatch(LoginWithCode(context: context));
                  Navigator.of(context, rootNavigator: true).pushNamed('/user/login/password');
                },
              )
            ])),
          );
        } else if (state is Authenticated) {
          return CupertinoPageScaffold(
            child: CustomScrollView(
              controller: _scrollController,
              // physics: ScrollPhysics(),
              slivers: <Widget>[
                // 可伸缩头部
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    minHeight: 64,
                    maxHeight: 186,
                    nickname: Center(
                      child: Text(
                        state.userInfo.nickname,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    avatar: Avatar(
                      src: state.userInfo.avatarUrl,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(64),
                        border: Border.all(
                          style: BorderStyle.solid,
                          color: Color(0xFFFFFFFF),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/user_bg.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                // 用户信息
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFdddddd), width: 0.5),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          state.userInfo.nickname,
                          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Padding(padding: EdgeInsets.all(2)),
                        Text(
                          '用户Id：970568830',
                          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(color: Color(0xFF999999)),
                        ),
                        Padding(padding: EdgeInsets.all(2)),
                        Text(
                          state.userInfo.sign,
                          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(color: Color(0xFF666666)),
                        ),
                        Padding(padding: EdgeInsets.all(8)),
                        Row(
                          children: <Widget>[
                            tag("90后"),
                            tag("技术宅"),
                            tag("北京市"),
                          ],
                        ),
                        Padding(padding: EdgeInsets.all(12)),
                        Row(
                          children: <Widget>[
                            infoItem('233', '动态'),
                            infoItem('233', '粉丝'),
                            infoItem('233', '关注'),
                            Expanded(child: Container()),
                            Icon(TaobaoIcons.qr_code, size: 32, color: Color(0xFF666666)),
                            // Text('11')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // 吸顶tabs
                SliverPersistentHeader(
                  // floating: true,
                  pinned: true,
                  delegate: _StickyTabBarDelegate(
                    child: CupertinoTabBar(
                      currentIndex: 0,
                      backgroundColor: Color(0xFFFFFFFF),
                      onTap: (idx) {
                        print(idx);
                        HapticFeedback.lightImpact();
                        return idx;
                      },
                      border: Border(
                        top: BorderSide.none,
                        bottom: BorderSide(
                          color: Color(0xFFdddddd),
                          width: 0.5, // One physical pixel.
                          style: BorderStyle.solid,
                        ),
                      ),
                      items: [
                        BottomNavigationBarItem(icon: Icon(EvaIcons.castOutline, size: 28)),
                        BottomNavigationBarItem(icon: Icon(EvaIcons.shakeOutline, size: 28)),
                        BottomNavigationBarItem(icon: Icon(EvaIcons.arrowCircleRightOutline, size: 28)),
                      ],
                    ),
                  ),
                ),
                //
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        color: Color(0xFFf8f8f8),
                        // margin: EdgeInsets.all(16),
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      );
                    },
                    childCount: 200,
                  ),
                ),
              ],
            ),
          );
        } else {
          return CupertinoPageScaffold(
            child: Center(
              child: Text('Unauthenticated'),
            ),
          );
        }
      },
    );
  }
}
