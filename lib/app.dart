import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:eight/blocs/theme_bloc.dart';
import 'package:eight/blocs/counter_bloc.dart';
import 'package:eight/blocs/user_bloc/index.dart';
import 'package:eight/pages/home/index.dart';

class App extends StatefulWidget {
  App({this.client});
  final client;
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: widget.client,
      child: GraphQLConsumer(builder: (GraphQLClient client) {
        return BlocProvider<ThemeBloc>(
          builder: (context) => ThemeBloc(),
          child: BlocProvider<CounterBloc>(
            builder: (context) => CounterBloc(),
            child: BlocProvider<UserBloc>(
              builder: (context) => UserBloc(client: client)..dispatch(AppStarted()),
              child: BlocBuilder<ThemeBloc, CupertinoThemeData>(
                builder: (context, theme) {
                  return CupertinoApp(
                    theme: theme,
                    routes: <String, WidgetBuilder>{
                      '/': (BuildContext context) => HomePage(),
                      // '/login': (BuildContext context) => UserLogin(),
                      // '/register': (BuildContext context) => UserLogin(),
                    },
                    initialRoute: '/',
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
