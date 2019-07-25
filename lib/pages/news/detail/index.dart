import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import '../../../components/ListViewPro/index.dart';
// import '../../../components/Graphql/Query/index.dart';
// import '../../../graphql/schema/news.dart';
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
        child: Text(widget.id)
      )
    );
  }

}