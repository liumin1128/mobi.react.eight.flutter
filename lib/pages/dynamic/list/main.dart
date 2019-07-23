import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './item.dart';
import '../../../graphql//schema/dynamic.dart';

class DynamicList extends StatefulWidget {
  DynamicList({ Key key, this.title }) : super(key: key);
  final String title;
  @override
  _DynamicListState createState() => _DynamicListState();
}

class _DynamicListState extends State<DynamicList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动态'),
      ),
      body: Center(
        child: Query(
          options: QueryOptions(
            document: dynamics, // this is the query string you just created
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
                return DynamicItem(data: dynamic0);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


