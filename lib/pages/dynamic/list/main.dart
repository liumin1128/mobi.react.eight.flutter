import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:flutter_redux/flutter_redux.dart';
import './item.dart';
import '../../../graphql/schema/dynamic.dart';
// import '../../../store/actions.dart';

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
      body: Container(
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
                return DynamicItem(data: dynamics[index]);
              },
            );
          },
        ),
      ),


      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {
      //   },
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.


      // floatingActionButton: new StoreConnector<int, VoidCallback>(
      //   converter: (store) {
      //     return () => store.dispatch(DynamicActions.Increment);
      //   },
      //   builder: (context, callback) {
      //     return new FloatingActionButton(
      //       onPressed: callback,
      //       tooltip: 'Increment',
      //       child: new Icon(Icons.add),
      //     );
      //   },
      // ),
    );
  }
}


