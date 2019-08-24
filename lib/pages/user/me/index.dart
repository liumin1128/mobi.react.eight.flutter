import 'package:flutter/cupertino.dart';
import 'package:reactmobi/blocs/counter_bloc.dart';
import 'package:reactmobi/blocs/theme_bloc.dart';
import 'package:reactmobi/blocs/user_bloc/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactmobi/components/Ui/Avatar/avatar.dart';


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

    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is Uninitialized) {
        return Center(child: CupertinoActivityIndicator());
      }
      if (state is Unauthenticated) {
        return Center(child: Text('Unauthenticated'));
      }
      if(state is Authenticated) {
        return CupertinoPageScaffold(
            child: CustomScrollView(
              controller: _scrollController,
              physics: ScrollPhysics(),
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: Text('个人中心'),
                  border: Border(top: BorderSide(style: BorderStyle.none)),
                ),
                SliverSafeArea(
                  // top: true, 
                  bottom: true,
                  sliver: SliverToBoxAdapter(

                    child: Column(children: <Widget>[
                      Text(state.userInfo['nickname']),
                      Avatar(src: state.userInfo['avatarUrl'],),
                    ],)
                    
                  ),
                )
              ],
            )
        );
      }
 

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("用户"),
        border: Border(
          top: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            counterBloc.dispatch(CounterEvent.increment);
          },
          child: Icon(CupertinoIcons.bell),
        ),
        trailing: GestureDetector(
          onTap: () {
            userBloc.dispatch(LoginWithCode(context: context));
          },
          child: Icon(CupertinoIcons.bell),
        ),
        // trailing: Icon(CupertinoCupertinoIcons.add)
        // backgroundColor: Colors.white,
      ),
      // child: Center(
      //   child: Text('1111'),
      // ),
      child: Container(
          child: Column(
        children: <Widget>[
          Center(
            child: BlocBuilder<CounterBloc, int>(
              builder: (context, count) {
                return Center(
                  child: Text(
                    '$count',
                    style: TextStyle(fontSize: 24.0),
                  ),
                );
              },
            ),
          ),
          Center(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Center(
                  child: Text(
                    (state is Authenticated) ? state.token : 'no',
                    style: TextStyle(fontSize: 24.0),
                  ),
                );
              },
            ),
          ),
          Center(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Center(
                  child: Text(
                    (state is Authenticated) ? state.userInfo['nickname'] : 'no',
                    style: TextStyle(fontSize: 24.0),
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
