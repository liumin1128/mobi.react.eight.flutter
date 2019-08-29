import 'package:flutter/cupertino.dart';
import 'package:eight/blocs/counter_bloc.dart';
import 'package:eight/blocs/theme_bloc.dart';
import 'package:eight/blocs/user_bloc/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/components/Avatar/index.dart';

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
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
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
              physics: ScrollPhysics(),
              slivers: <Widget>[
                // CupertinoSliverNavigationBar(
                //   largeTitle: Text('个人中心'),
                //   border: Border(top: BorderSide(style: BorderStyle.none)),
                // ),
                SliverSafeArea(
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(32),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Avatar(src: state.userInfo['avatarUrl'], size: 64),
                              Padding(padding: EdgeInsets.all(16)),
                              Text(state.userInfo['nickname'], style: CupertinoTheme.of(context).textTheme.textStyle),
                            ],
                          ),
                        ),
                        CupertinoButton(
                          child: Text('退出登录'),
                          onPressed: () {
                            userBloc.dispatch(LoggedOut(context: context));
                          },
                        )
                      ],
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
