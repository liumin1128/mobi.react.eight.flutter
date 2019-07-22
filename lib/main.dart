import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

Future<void> main() async {
  final HttpLink httpLink = HttpLink(
    uri: 'https://api.github.com/graphql',
  );

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  );

  final Link link = authLink.concat(httpLink as Link);

  String typenameDataIdFromObject(Object object) {
    if (object is Map<String, Object> &&
        object.containsKey('__typename') &&
        object.containsKey('id')) {
      return "${object['__typename']}/${object['id']}";
    }
    return null;
  }

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: NormalizedInMemoryCache(
        dataIdFromObject: typenameDataIdFromObject,
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '666',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
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
