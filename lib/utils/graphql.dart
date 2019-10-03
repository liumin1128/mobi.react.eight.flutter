import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

getClient() {
  final HttpLink httpLink = HttpLink(
    // uri: 'http://192.168.1.242:3101/graphql',
    // uri: 'http://192.168.1.101:3101/graphql',
    uri: 'http://api.react.mobi/graphql',
  );

  final AuthLink authLink = AuthLink(getToken: () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _token = prefs.getString('token');
    return 'Bearer $_token';
  });

  final Link link = authLink.concat(httpLink as Link);

  String typenameDataIdFromObject(Object object) {
    if (object is Map<String, Object> && object.containsKey('__typename') && object.containsKey('_id')) {
      return "${object['__typename']}/${object['_id']}";
    }
    return null;
  }

  final GraphQLClient client = GraphQLClient(
    cache: NormalizedInMemoryCache(
      dataIdFromObject: typenameDataIdFromObject,
    ),
    // cache: InMemoryCache(),
    link: link,
  );

  return client;

  // final ValueNotifier<GraphQLClient> valueNotifier = ValueNotifier(client);

  // return valueNotifier;
}
