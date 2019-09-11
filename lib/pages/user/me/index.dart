import 'dart:convert';
import 'dart:math';
import 'dart:ui' show ImageFilter;
import 'package:flutter/cupertino.dart';
import 'package:eight/blocs/counter_bloc.dart';
import 'package:eight/blocs/theme_bloc.dart';
import 'package:eight/blocs/user_bloc/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/components/Avatar/index.dart';
import 'package:eight/components/Icons/Taobao.dart';
import 'package:eight/components/Icons/Eva.dart';

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final CupertinoTabBar child;

  StickyTabBarDelegate({@required this.child});

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
              child: nickname,
              color: Color(0xFFFFFFFF),
            ),
            //   ),
            // ),
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 80 * (1 - progress * 0.5),
            height: 80 * (1 - progress * 0.5),
            child: avatar,
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
                  userBloc.dispatch(LoginWithCode(context: context));
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
                SliverPersistentHeader(
                  // floating: true,
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    minHeight: 80,
                    maxHeight: 248,
                    nickname: Center(
                      child: Text(
                        state.userInfo['nickname'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    avatar: Avatar(
                      src: state.userInfo['avatarUrl'],
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(64),
                        border: Border.all(
                          style: BorderStyle.solid,
                          color: Color(0xFFFFFFFF),
                          width: 2,
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
                SliverSafeArea(
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFdddddd), width: 0.5),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Avatar(src: state.userInfo['avatarUrl'], size: 80),
                          // Padding(padding: EdgeInsets.all(8)),
                          Text(
                            state.userInfo['nickname'],
                            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Text(
                            '用户Id：970568830',
                            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(color: Color(0xFF999999)),
                          ),
                          Padding(padding: EdgeInsets.all(2)),
                          Text(
                            // state.userInfo['sign'],
                            '不因过去而悲伤',
                            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(color: Color(0xFF666666)),
                          ),
                          Padding(padding: EdgeInsets.all(8)),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text('90后', style: TextStyle(color: Color(0xFF999999))),
                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Color(0xffeeeeee),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(4)),
                              Container(
                                child: Text('技术宅', style: TextStyle(color: Color(0xFF999999))),
                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Color(0xffeeeeee),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(4)),
                              Container(
                                child: Text('北京市', style: TextStyle(color: Color(0xFF999999))),
                                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Color(0xffeeeeee),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(16)),

                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('1', style: TextStyle(color: Color(0xFF333333), fontSize: 30)),
                                    Padding(padding: EdgeInsets.all(4)),
                                    Text('动态', style: TextStyle(fontSize: 14, color: Color(0xFF999999))),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('0', style: TextStyle(color: Color(0xFF333333), fontSize: 28)),
                                    Padding(padding: EdgeInsets.all(4)),
                                    Text('粉丝', style: TextStyle(fontSize: 14, color: Color(0xFF999999))),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('2', style: TextStyle(color: Color(0xFF333333), fontSize: 28)),
                                    Padding(padding: EdgeInsets.all(4)),
                                    Text('关注', style: TextStyle(fontSize: 14, color: Color(0xFF999999))),
                                  ],
                                ),
                              ),
                              Expanded(
                                // margin: EdgeInsets.only(right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('G5FGHF', style: TextStyle(color: Color(0xFF333333), fontSize: 28, letterSpacing: -1, fontFamily: "Helvetica Neue")),
                                    Padding(padding: EdgeInsets.all(4)),
                                    Text('邀请码', style: TextStyle(fontSize: 14, color: Color(0xFF999999))),
                                  ],
                                ),
                              ),
                              Icon(TaobaoIcons.qr_code, size: 40, color: Color(0xFF666666)),
                              // Text('11')
                            ],
                          ),

                          // Padding(padding: EdgeInsets.all(8)),

                          // CupertinoButton(
                          //   child: Text('退出登录'),
                          //   onPressed: () {
                          //     userBloc.dispatch(LoggedOut(context: context));
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  // floating: true,
                  pinned: true,
                  delegate: StickyTabBarDelegate(
                    child: CupertinoTabBar(
                      items: [
                        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home, size: 36)),
                        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home, size: 36)),
                        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home, size: 36)),
                        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home, size: 36)),
                        BottomNavigationBarItem(icon: Icon(CupertinoIcons.home, size: 36)),
                      ],
                    ),
                  ),
                ),
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        color: Color(0xFFf8f8f8),
                        child: Center(
                          child: Text('loading'),
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
