import 'dart:async';
import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactmobi/blocs/theme_bloc.dart';
import 'package:reactmobi/pages/home/index.dart';

class App extends StatefulWidget {
  App({this.client});
  final client;
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      builder: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, CupertinoThemeData>(
        builder: (context, theme) {
          return CupertinoApp(
            theme: theme,
            home: BlocProvider(
              builder: (context) => CounterBloc(),
              child: CounterPage(),
            ),
          );
        },
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final counterBloc = BlocProvider.of<CounterBloc>(context);
    final themeBloc = BlocProvider.of<ThemeBloc>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("动态"),
        border: Border(
          top: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        trailing: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          // mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                themeBloc.dispatch(SetTheme(theme: 'dark1'));
              },
              child: Icon(CupertinoIcons.bell),
            ),
          ],
        ),
        // trailing: Icon(CupertinoCupertinoIcons.add)
        // backgroundColor: Colors.white,
      ),
      // child: Center(
      //   child: Text('1111'),
      // ),
      child: Center(
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
    );
  }
}

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 99;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
      case CounterEvent.increment:
        yield currentState + 1;
        break;
    }
  }
}
