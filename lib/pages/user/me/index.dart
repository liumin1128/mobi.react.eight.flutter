import 'package:flutter/cupertino.dart';
import 'package:reactmobi/blocs/counter_bloc.dart';
import 'package:reactmobi/blocs/theme_bloc.dart';
import 'package:reactmobi/blocs/user_bloc/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);

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
            // themeBloc.dispatch(SetTheme(theme: 'dark1'));
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
      child: Center(
          child: Column(
        children: <Widget>[
          Text('1111'),
          Text('1111'),
          Text('1111'),
          Text('1111'),
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
