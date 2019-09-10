// // import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:transparent_image/transparent_image.dart';
import 'package:eight/graphql/schema/news.dart';

class NewsDetail extends StatefulWidget {
  NewsDetail({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Query(
      options: QueryOptions(
        document: newsDetailSchema, // this is the query string you just created
        variables: {'_id': widget.id},
        // pollInterval: 10,
      ),
      builder: (QueryResult result, {VoidCallback refetch, FetchMore fetchMore}) {
        if (result.errors != null) {
          return Text(result.errors.toString());
        }

        if (result.loading) {
          return Text('Loading');
        }

        // it can be either Map or List
        // List data = result.data['data'];
        // print(result);
        // print(result.data['data']['title']);
        // print(result.data['data']['html']);

        final data = result.data['data'];

        return CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverSafeArea(
              top: true,
              bottom: true,
              sliver: SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      // 文章主体
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(data['title'], textAlign: TextAlign.left),
                            Html(
                                data: data['html'],
                                // useRichText: false,
                                customRender: (node, children) {
                                  if (node is dom.Element) {
                                    switch (node.localName) {
                                      case 'img':
                                        {
                                          return ClipRRect(
                                              borderRadius: BorderRadius.circular(4),
                                              child: Container(
                                                  decoration: BoxDecoration(color: CupertinoColors.black),
                                                  child: FadeInImage.memoryNetwork(
                                                    placeholder: kTransparentImage,
                                                    image: node.attributes['src'],
                                                  )));
                                        }
                                      // case "video": return Chewie(...);
                                      // case "custom_tag": return CustomWidget(...);
                                    }
                                  }
                                },
                                customTextAlign: (dom.Node node) {
                                  if (node is dom.Element) {
                                    switch (node.localName) {
                                      case "p":
                                        return TextAlign.justify;
                                    }
                                  }
                                },
                                customTextStyle: (dom.Node node, TextStyle baseStyle) {
                                  if (node is dom.Element) {
                                    switch (node.localName) {
                                      case "p":
                                        return baseStyle.merge(TextStyle(height: 1.25, fontSize: 14));
                                    }
                                  }
                                  return baseStyle;
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}
