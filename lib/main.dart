import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> main() async {
  final HttpLink httpLink = HttpLink(
    uri: 'http://localhost:3101/graphql',
    // uri: 'http://api.react.mobi/graphql',
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
        home: MyHomePage(title: 'Flutter D222'),
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({ Key key, this.title }) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  String readRepositories = """
    query DynamicList(\$first: Int, \$skip: Int, \$topic: String, \$user: String) {
      list: dynamics(first: \$first, skip: \$skip, topic: \$topic, user: \$user) {
        __typename
        createdAt
        _id
        content
        pictures
        zanCount
        zanStatus
        commentCount
        topics {
          _id
          title
          number
        }
        user {
          nickname
          avatarUrl
        }
      }
      meta: _dynamicsMeta {
        count
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Query(
              options: QueryOptions(
                document: readRepositories, // this is the query string you just created
                // variables: {
                  // 'nRepositories': 50,
                // },
                // pollInterval: 10,
              ),
              // Just like in apollo refetch() could be used to manually trigger a refetch
              builder: (QueryResult result, { VoidCallback refetch }) {

                if (result.errors != null) {
                  return Text(result.errors.toString());
                }

                if (result.loading) {
                  return Text('Loading');
                }

                // it can be either Map or List
                List dynamics = result.data['list'];

                return ListView.builder(
                  itemCount: dynamics.length,
                  itemBuilder: (_, int index) {

                    final dynamic0 = dynamics[index];
  
                    return ListTile(
                      title: new Text(dynamic0['user']['nickname']) ,
                      subtitle: new Text(dynamic0['content']),
                    );
                  },
                );
              },
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
