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
      body: GraphQLConsumer(
        builder: (GraphQLClient client) {
          return Container(
            child: Center(
              child: Query(
                options: QueryOptions(
                  document: newsSchema, // this is the query string you just created
                  // variables: {
                    // 'nRepositories': 50,
                  // },
                  // fetchPolicy: 
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

                  List dynamics = result.data['list'];

                  Future<Null> _onRefresh() async {
                    print('onRefresh');
                    refetch();
                  }

                  Future<Null> _onScrollToBottom() async {
                    print('_onScrollToBottom');
                    refetch();
                  }

                  // Future<Null> _onScrollToBottom() async {
                  //   print('xxxxxxxxxxxxxxxxxxxxxx');

                  //   // final QueryResult res = await client.mutate(
                  //   //   MutationOptions(
                  //   //     document: newsSchema,
                  //   //     variables: {
                  //   //       'skip': 1 * 16
                  //   //     },
                  //   //   ),
                  //   // );

                  //   // if(res.hasErrors) return;

                  //   // final List<dynamic> updated = List<dynamic>.from(result.data['list'])..addAll(res.data['list']);
                    
                  //   // client.cache.write(typenameDataIdFromObject(updated[3]), updated[3]);
                  //   // client.cache.restore();
                  //   // print(client.cache.read(typenameDataIdFromObject(updated[3]))['title']);
                  //   // client.queryManager.rebroadcastQueries();
                    
                  // }


                  return ListViewPro(
                    onRefresh: _onRefresh,
                    onScrollToBottom: _onScrollToBottom,
                    itemCount: dynamics.length,
                    itemBuilder: (_, int index) {

                      var data = dynamics[index];
                      var cover = data['cover'] == null ? (data['photos'][0] != null ? data['photos'][0] : 'https://imgs.react.mobi/FldU5XAVJksEDNDEs7MZiF36DMAz') : data['cover'];
                      // var createdAt = RelativeDateFormat.format(new DateTime.fromMicrosecondsSinceEpoch(data['createdAt']));

                      return new ListTile(
                        leading: Image.network(cover, width: 100, height: 100, fit: BoxFit.cover),
                        title: Text(data['title']),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(data['_id']),
                          ],
                        )
                      );


                    }
                  );
                },
              ),
            )
          );
        },
      )
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


