import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactmobi/pages/user/login.dart';
import 'package:reactmobi/pages/home/index.dart';
import 'package:reactmobi/blocs/theme_bloc.dart';
import 'package:reactmobi/blocs/counter_bloc.dart';

class MyApp extends StatefulWidget {
  MyApp({this.client});
  final client;
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // final CounterBloc _counterBloc = CounterBloc();

  // var themeBloc = ThemeBloc();

  @override
  Widget build(BuildContext context) {
    // final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    final ThemeBloc themeBloc = BlocProvider.of<ThemeBloc>(context);

    print(themeBloc);

    return GraphQLProvider(
      client: widget.client,
      child: CupertinoApp(
        theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFFfd4c86),
        ),
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => HomePage(),
          '/login': (BuildContext context) => UserLogin(),
          '/register': (BuildContext context) => UserLogin(),
        },
        initialRoute: '/',
      ),
    );
  }
}
