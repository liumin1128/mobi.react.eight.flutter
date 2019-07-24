import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../components/ListViewPro/index.dart';
import '../../../components/Graphql/Query/index.dart';
import '../../../graphql/schema/news.dart';
import '../../../utils/common.dart';

 String typenameDataIdFromObject2(Object object) {
  if (object is Map<String, Object> &&
      object.containsKey('__typename') &&
      object.containsKey('_id')) {
    return "${object['__typename']}/${object['_id']}";
  }
  return null;
}

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
      body: QueryPro(
        builder: (list, loading, { VoidCallback refetch, VoidCallback fetchMore }) {

          if(list.length == 0 && loading) return Text('Loading');

          return Container(
            child: Center(
              child: ListViewPro(
                onRefresh: refetch,
                onScrollToBottom: fetchMore,
                itemCount: list.length,
                itemBuilder: (_, int index) {

                  var data = list[index];
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
              )
            )
          );

        }
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


  //  GraphQLConsumer(
  //       builder: (GraphQLClient client) {
  //         return Container(
  //           child: Center(
  //             child: Query(
  //               options: QueryOptions(
  //                 document: newsSchema, // this is the query string you just created
  //                 variables: {
  //                   'first': 32
  //                   // 'nRepositories': 50,
  //                 },
  //                 // fetchPolicy: 
  //                 pollInterval: 10,
  //               ),
                
  //               // Just like in apollo refetch() could be used to manually trigger a refetch
  //               builder: (QueryResult result, { VoidCallback refetch, VoidCallback fetchMore  }) {

  //                 if (result.errors != null) {
  //                   return Text(result.errors.toString());
  //                 }

  //                 if (result.loading) {
  //                   return Text('Loading');
  //                 }

  //                 List dynamics = result.data['list'];

  //                 Future<Null> _onRefresh() async {
  //                   print('onRefresh');
  //                   refetch();
  //                 }

  //                 Future<Null> _onScrollToBottom() async {
  //                   print('_onScrollToBottom');
  //                   final QueryResult res = await client.mutate(
  //                     MutationOptions(
  //                       document: newsSchema,
  //                       variables: {
  //                         'skip': 1 * 16,
  //                         'first': 32
  //                       },
  //                     ),
  //                   );

  //                   if(res.hasErrors) return;

  //                   // final List<dynamic> updated = List<dynamic>.from(result.data['list'])..addAll(res.data['list']);
  //                   final List<dynamic> updated = res.data['list'];

  //                   // print('updated');
  //                   // print(updated);
  //                   // print(updated[0]);
  //                   // print(typenameDataIdFromObject2(updated[0]));
  //                   // print(updated[0]['title']);

  //                   client.cache.write(typenameDataIdFromObject2(updated[0]), updated[0]);
  //                   client.cache.write(typenameDataIdFromObject2(updated[1]), updated[1]);
  //                   client.cache.write(typenameDataIdFromObject2(updated[2]), updated[2]);
  //                   client.cache.write(typenameDataIdFromObject2(updated[3]), updated[3]);

  //                   // client.cache.restore();
  //                   // client.queryManager.addQueryResult('NewsList', res); 
  //                   // client.queryManager.rebroadcastQueries();
                    



  //                 }

  //                 print('dynamics');
  //                 print(dynamics.length);

  //                 return ListViewPro(
  //                   onRefresh: _onRefresh,
  //                   onScrollToBottom: _onScrollToBottom,
  //                   itemCount: dynamics.length,
  //                   itemBuilder: (_, int index) {


  //                     var data = dynamics[index];
  //                     var cover = data['cover'] == null ? (data['photos'][0] != null ? data['photos'][0] : 'https://imgs.react.mobi/FldU5XAVJksEDNDEs7MZiF36DMAz') : data['cover'];
  //                     // var createdAt = RelativeDateFormat.format(new DateTime.fromMicrosecondsSinceEpoch(data['createdAt']));

  //                     return new ListTile(
  //                       leading: Image.network(cover, width: 100, height: 100, fit: BoxFit.cover),
  //                       title: Text(data['title']),
  //                       subtitle: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: <Widget>[
  //                           Text(data['_id']),
  //                         ],
  //                       )
  //                     );


  //                   }
  //                 );



  //               },
  //             ),
  //           )
  //         );
  //       },
  //     )

      