import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../components/ListViewPro/index.dart';
import '../../../graphql/schema/news.dart';
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

            Future<Null> _onRefresh() async {
              print('onRefresh');
              refetch();
            }

            Future<Null> _onScrollToBottom() async {
              print('_onScrollToBottom');
              refetch();
            }

            return ListViewPro(
              onRefresh: _onRefresh,
              onScrollToBottom: _onScrollToBottom,
              itemCount: dynamics.length,
              itemBuilder: (_, int index) {

                var data = dynamics[index];
                var cover = data['cover'] == null ? (data['photos'][0] != null ? data['photos'][0] : 'https://imgs.react.mobi/FldU5XAVJksEDNDEs7MZiF36DMAz') : data['cover'];
                var createdAt = RelativeDateFormat.format(new DateTime.fromMicrosecondsSinceEpoch(data['createdAt']));

                return new ListTile(
                  leading: Image.network(cover, width: 100, height: 100, fit: BoxFit.cover),
                  title: Text(data['title']),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(data['appName']),
                      Text(createdAt),
                    ],
                  )
                );
              }
            );
          },
        ),
      ),

    );
  }

  //  Future<Null> _getMore() async {
  //   print('_getMore');
  //   final QueryResult r = await graphQLClientClient.mutate(
  //     MutationOptions(
  //       document: uploadMutation,
  //       variables: {
  //         'files': [File(filePath)],
  //       },
  //     )
  //   );
  // }

  
}


