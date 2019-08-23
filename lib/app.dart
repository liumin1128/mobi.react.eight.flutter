import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reactmobi/pages/user/login.dart';
import 'package:reactmobi/pages/home/index.dart';

class MyApp extends StatelessWidget {
  MyApp({this.client, this.store});
  final client;
  final store;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
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
