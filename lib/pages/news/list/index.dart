import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../components/ListViewPro/index.dart';
import '../../../components/Graphql/Query/index.dart';
import '../../../graphql/schema/news.dart';
import '../../../utils/common.dart';
import '../detail/index.dart';

class NewsList extends StatefulWidget {

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {

  @override
  Widget build(BuildContext context) {


    return QueryPro(
      document: newsSchema,
      builder: (list, loading, { VoidCallback refetch, VoidCallback fetchMore }) {

        if(list.length == 0 && loading) return Center( child: Container( width: 16, height: 16, child: CupertinoActivityIndicator( ) ) );

        return Container(
          child: ListViewPro(
            
            title: '资讯',
            onRefresh: refetch,
            onScrollToBottom: fetchMore,
            itemCount: list.length,
            itemBuilder: (_, int index) {
 
              var data = list[index];
              var cover = data['cover'] == null ? data['photos'][0] : data['cover'];
              var smallCover = cover == null ? 'https://imgs.react.mobi/FldU5XAVJksEDNDEs7MZiF36DMAz' : getSmallImg(cover, 160, 160);
              var createdAt = RelativeDateFormat.format(new DateTime.fromMicrosecondsSinceEpoch(data['createdAt']));

              return GestureDetector(
                
                onTap: () {
                  Navigator.push(
                    context,
                    new CupertinoPageRoute(
                      builder: (context) => CupertinoPageScaffold(
                        navigationBar: CupertinoNavigationBar(
                          middle: Text(data['title'], 
                            overflow: TextOverflow.ellipsis, 
                            maxLines: 1,
                          ),
                        ),
                        child: NewsDetail(id: data['_id']),
                      ),
                    ),
                  );
                },
                
                child: Container(
                  decoration: new BoxDecoration(),
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
              

                      Container(
                        width: 80,
                        height: 80,
                        
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black12
                            ),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: smallCover,
                            )
                          )
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16,0,0,0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(data['title'], 
                                maxLines: 2,
                                softWrap: true, 
                                overflow: TextOverflow.ellipsis, 
                                style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.normal)
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(data['appName'], style: Theme.of(context).textTheme.caption),
                                  Text(createdAt, style: Theme.of(context).textTheme.caption),
                                ],
                              )
                          ],)
                        )
                      )
                    ]
                  )
                )
              );
            }
          )
        );
      }
    );
  }
}