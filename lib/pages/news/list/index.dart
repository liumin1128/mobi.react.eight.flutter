import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:flutter_redux/flutter_redux.dart';
import '../../../graphql/schema/news.dart';
// import '../../../store/actions.dart';
import '../../../utils/common.dart';

class NewsList extends StatefulWidget {
  NewsList({ Key key, this.title }) : super(key: key);
  final String title;
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('动态'),
      ),
      body: Container(
        child: Query(
          options: QueryOptions(
            document: newsSchema, // this is the query string you just created
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

                var data = dynamics[index];
                var cover = data['cover'] == null ? data['photos'][0] : data['cover'];

                return new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Text(data['cover']),
                    new ListTile(
                      leading: Image.network(cover, width: 100, height: 100, fit: BoxFit.cover),
                      title: Text(data['title']),
                      subtitle: Text(RelativeDateFormat.format(new DateTime.fromMicrosecondsSinceEpoch(data['createdAt']))),
                    )
                  ]
                );

              },
            );
          },
        ),
      ),

    );
  }
}


