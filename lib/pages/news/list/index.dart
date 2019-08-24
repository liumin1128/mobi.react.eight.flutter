// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:eight/components/ListViewPro/index.dart';
import 'package:eight/components/Graphql/Query/index.dart';
import 'package:eight/graphql/schema/news.dart';
import 'package:eight/utils/common.dart';
import 'package:eight/pages/news/detail/index.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return QueryPro(
        document: newsSchema,
        builder: (list, loading, {VoidCallback refetch, VoidCallback fetchMore}) {
          if (list.length == 0 && loading) return Center(child: Container(width: 16, height: 16, child: CupertinoActivityIndicator()));

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
                    var createdAt = RelativeDateFormat.format(DateTime.fromMicrosecondsSinceEpoch(data['createdAt']));

                    return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                              builder: (context) => CupertinoPageScaffold(
                                navigationBar: CupertinoNavigationBar(
                                  border: Border(
                                    top: BorderSide(
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  // backgroundColor: CupertinoColors.white,
                                  // padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                                  middle: Text(
                                    data['title'],
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
                            decoration: BoxDecoration(),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                            decoration: BoxDecoration(color: CupertinoColors.black),
                                            child: FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              image: smallCover,
                                            ))),
                                  ),
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(data['title'], maxLines: 2, softWrap: true, overflow: TextOverflow.ellipsis, style: CupertinoTheme.of(context).textTheme.navActionTextStyle.copyWith(fontWeight: FontWeight.normal)),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Text(data['appName'], style: CupertinoTheme.of(context).textTheme.actionTextStyle),
                                                  Text(createdAt, style: CupertinoTheme.of(context).textTheme.actionTextStyle),
                                                ],
                                              )
                                            ],
                                          )))
                                ])));
                  }));
        });
  }
}
