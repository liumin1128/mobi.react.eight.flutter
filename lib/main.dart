import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import './pages/user/login.dart';
import './pages/home/index.dart';
import './store/actions.dart';

int counterReducer(int state, dynamic action) {
  if (action == DynamicActions.Increment) {
    return state + 1;
  }
  return state;
}

Future<void> main() async {
  final HttpLink httpLink = HttpLink(
    // uri: 'http://localhost:3101/graphql',
    uri: 'http://api.react.mobi/graphql',
  );

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  );

  final Link link = authLink.concat(httpLink as Link);

  String typenameDataIdFromObject(Object object) {
    if (object is Map<String, Object> &&
        object.containsKey('__typename') &&
        object.containsKey('_id')) {
      return "${object['__typename']}/${object['_id']}";
    }
    return null;
  }

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: NormalizedInMemoryCache(
        dataIdFromObject: typenameDataIdFromObject,
      ),
      // cache: InMemoryCache(),
      link: link,
    ),
  );

  final store = new Store<int>(counterReducer, initialState: 0);

  runApp(MyApp(client: client, store: store));
}

class MyApp extends StatelessWidget {

  MyApp({ this.client, this.store });
  final client;
  final store;

  @override
  Widget build(BuildContext context) {


    return  new StoreProvider<int>(
      store: store,
      child: GraphQLProvider(
        client: client,

        child: CupertinoApp(

          theme: CupertinoThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.pink,
            scaffoldBackgroundColor: Colors.white70,
            // primaryContrastingColor: Colors.pink[400],
          ),

          routes: <String, WidgetBuilder>{
            '/': (BuildContext context) => HomePage(),
            '/login': (BuildContext context) => UserLogin(),
            '/register': (BuildContext context) => UserLogin(),
          },

          initialRoute: '/',


        )
        // child: MaterialApp(

        //   theme: ThemeData(
        //     // primaryColor: Colors.pink,
        //     brightness: Brightness.light,
        //     primaryColor: Colors.pink[400],
        //     accentColor: Colors.pink[400],
        //   ),

        //   initialRoute: '/',

        //   routes: <String, WidgetBuilder>{
        //     '/': (BuildContext context) => HomePage(),
        //     '/login': (BuildContext context) => UserLogin(),
        //     '/register': (BuildContext context) => UserLogin(),
        //   },

        //   // home: UserLogin(),
        // )


      )
    );
  }
}
