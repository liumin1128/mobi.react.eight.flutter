import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:reactmobi/graphql/schema/dynamic.dart';
import './item.dart';

class DynamicList extends StatefulWidget {
  DynamicList({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _DynamicListState createState() => _DynamicListState();
}

class _DynamicListState extends State<DynamicList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Query(
        options: QueryOptions(
          document: dynamics, // this is the query string you just created
          // variables: {
          // 'nRepositories': 50,
          // },
          // pollInterval: 10,
        ),

        // Just like in apollo refetch() could be used to manually trigger a refetch
        builder: (QueryResult result, {VoidCallback refetch}) {
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
              return DynamicItem(data: dynamics[index]);
            },
          );
        },
      ),
    );
  }
}
