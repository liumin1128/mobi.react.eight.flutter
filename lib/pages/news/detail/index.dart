import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_html/flutter_html.dart';
// import '../../../components/ListViewPro/index.dart';
// import '../../../components/Graphql/Query/index.dart';
import '../../../graphql/schema/news.dart';
// import '../../../utils/common.dart';

class NewsDetail extends StatefulWidget {
  NewsDetail({ Key key, this.id }) : super(key: key);
  final String id;
  
  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Query(
          options: QueryOptions(
            document: newsDetailSchema, // this is the query string you just created
            variables: {
              '_id': widget.id
            },
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
            // List data = result.data['data'];
            print(result);
            print(result.data['data']['title']);

            final data = result.data['data'];

            // return Html(data: data['html']);

            return Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(data['title']),
                    Html(data: data['html'])
            ],),));
          },
        )
      )
    );
  }

}