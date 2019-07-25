import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../components/ListViewPro/index.dart';
import '../../../components/Graphql/Query/index.dart';
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


    return QueryPro(
      document: newsSchema,
      builder: (list, loading, { VoidCallback refetch, VoidCallback fetchMore }) {

        if(list.length == 0 && loading) return Text('Loading');

        return Container(
          child: ListViewPro(
            onRefresh: refetch,
            onScrollToBottom: fetchMore,
            itemCount: list.length + 1,
            itemBuilder: (_, int index) {

              if(index == list.length) return Container(
                padding: const EdgeInsets.only(top: 16,bottom: 16),
                child: Center(
                  child: Container(
                    width: 16,
                    height: 16,
                    child: CupertinoActivityIndicator(
                      // strokeWidth: 2,
                    )
                  )
                )
              );

              var data = list[index];
              var cover = data['cover'] == null ? data['photos'][0] : data['cover'];
              var smallCover = cover == null ? 'https://imgs.react.mobi/FldU5XAVJksEDNDEs7MZiF36DMAz' : getSmallImg(cover, 160, 160);
              var createdAt = RelativeDateFormat.format(new DateTime.fromMicrosecondsSinceEpoch(data['createdAt']));

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.network(smallCover, width: 80, height: 80, fit: BoxFit.cover),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16,0,0,0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(data['title'], 
                              softWrap: true,
                              overflow: TextOverflow.ellipsis, 
                              maxLines: 2,
                              // style: const TextStyle(
                              //   fontSize: 18.0,
                              //   color: Colors.black87,
                              // )
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(data['appName']
                                // , style: const TextStyle(fontSize: 14.0, color: Colors.black38)
                                ),
                                Text(createdAt, 
                                // style: const TextStyle(fontSize: 14.0, color: Colors.black38)
                                ),
                              ],
                            )
                        ],)
                      )
                    )
                  ]
                )
              );

            }
          )
        );
      }

    );
  }

}