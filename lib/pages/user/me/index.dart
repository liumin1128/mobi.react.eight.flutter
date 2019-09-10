import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:eight/blocs/counter_bloc.dart';
import 'package:eight/blocs/theme_bloc.dart';
import 'package:eight/blocs/user_bloc/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/components/Avatar/index.dart';
import 'package:eight/components/Icons/Taobao.dart';
import 'package:eight/components/Icons/Eva.dart';

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
                // CupertinoSliverNavigationBar(
                //   largeTitle: Text('个人中心'),
                //   border: Border(top: BorderSide(style: BorderStyle.none)),
                // ),
                SliverSafeArea(
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Padding(padding: EdgeInsets.all(16)),
                          Avatar(src: state.userInfo['avatarUrl'], size: 64),
                          Padding(padding: EdgeInsets.all(8)),
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
                          Padding(padding: EdgeInsets.all(24)),

                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('1', style: TextStyle(color: Color(0xFF333333), fontSize: 30)),
                                    Padding(padding: EdgeInsets.all(4)),
                                    Text('动态', style: TextStyle(color: Color(0xFF999999))),
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
                                    Text('粉丝', style: TextStyle(color: Color(0xFF999999))),
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
                                    Text('关注', style: TextStyle(color: Color(0xFF999999))),
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
                                    Text('邀请码', style: TextStyle(color: Color(0xFF999999))),
                                  ],
                                ),
                              ),
                              Icon(TaobaoIcons.qr_code, size: 40, color: Color(0xFF666666)),
                              // Text('11')
                            ],
                          ),

                          Padding(padding: EdgeInsets.all(8)),

                          CupertinoButton(
                            child: Text('退出登录'),
                            onPressed: () {
                              userBloc.dispatch(LoggedOut(context: context));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
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
