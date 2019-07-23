import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './test/LongList.dart';
import './pages/dynamic/list/main.dart';


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

  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {

  MyApp({ this.client });
  final client;

  @override
  Widget build(BuildContext context) {

    print('client');
    print(client);

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DynamicList(),
      )
    );
  }
}
