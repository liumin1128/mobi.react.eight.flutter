import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

List<Widget> getPicturesList(pictures) {
  List<Widget> list = [];
  for(var i in pictures) {
    list.add(new Image.network(i));
  }
  print(pictures);
  return list;
}

List<String> getDataList() {
  List<String> list = [];
  for (int i = 0; i < 100; i++) {
    list.add(i.toString());
  }
  return list;
}

List<Widget> getWidgetList() {
  return getDataList().map((item) => getItemContainer(item)).toList();
}

Widget getItemContainer(String item) {
  return Container(
    alignment: Alignment.center,
    child: Text(
      item,
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
    color: Colors.blue,
  );
}




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
  
                    // return ListTile(
                    //   title: new Text(dynamic0['user']['nickname']) ,
                    //   subtitle: new Text(dynamic0['content']),
                    // );

                    return Center(
                      child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(dynamic0['user']['avatarUrl']),
                                ),
                                title: Text(dynamic0['user']['nickname']),
                                subtitle: Text(dynamic0['content']),
                              ),

                              
                                dynamic0.containsKey('pictures') ? Wrap(
                                  spacing: 2, //主轴上子控件的间距
                                  runSpacing: 5,
                                  children: getPicturesList(dynamic0['pictures']), //要显示的子控件集合 //交叉轴上子控件之间的间距
                                ) : Text('xxx'),


                              // Container(
                              //   margin: new EdgeInsets.symmetric(vertical: 20.0),
                              //   height: 200.0,
                              //   child: new ListView(
                              //     scrollDirection: Axis.horizontal,
                              //     children: <Widget>[
                              //       new Container(
                              //         width: 160.0,
                              //         color: Colors.red,
                              //       ),
                              //       new Container(
                              //         width: 160.0,
                              //         color: Colors.blue,
                              //       ),
                              //       new Container(
                              //         width: 160.0,
                              //         color: Colors.green,
                              //       ),
                              //       new Container(
                              //         width: 160.0,
                              //         color: Colors.yellow,
                              //       ),
                              //       new Container(
                              //         width: 160.0,
                              //         color: Colors.orange,
                              //       ),
                              //     ],
                              //   ),
                              // ),


                              // GridView.count(
                              //   //水平子Widget之间间距
                              //   crossAxisSpacing: 10.0,
                              //   //垂直子Widget之间间距
                              //   mainAxisSpacing: 30.0,
                              //   //GridView内边距
                              //   padding: EdgeInsets.all(10.0),
                              //   //一行的Widget数量
                              //   crossAxisCount: 2,
                              //   //子Widget宽高比例
                              //   childAspectRatio: 2.0,
                              //   //子Widget列表
                              //   children: getWidgetList() 
                              // ),

                              
                              // GridView.builder(
                              //   itemCount: dynamics.length,
                              //   itemBuilder: (_, int index2) {
                              //     return CircleAvatar(
                              //       backgroundImage: NetworkImage(dynamic0['user']['avatarUrl']),
                              //     );
                              //   }
                              // ),


                              ButtonTheme.bar(
                                // make buttons use the appropriate styles for cards
                                child: ButtonBar(
                                  children: <Widget>[
                                    FlatButton(
                                      child: const Text('BUY TICKETS'),
                                      onPressed: () {/* ... */},
                                    ),
                                    FlatButton(
                                      child: const Text('LISTEN'),
                                      onPressed: () {/* ... */},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
