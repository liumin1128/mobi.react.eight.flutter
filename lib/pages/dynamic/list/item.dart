import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../utils/common.dart';


text2html(str) {
  return str;
  // .replaceAll(new RegExp(r"(.*?)\[(.*?)_(.*?)]"), '\$1<img src="https://imgs.react.mobi/emoticon/\$2/\$3.gif" class="emoji" alt="[\$2_\$3]">');
    // .replace(/(.*?)\[(.*?)_(.*?)]/ig, )
    // .replace(/(.*?)\n(.*?)/ig, '$1<div>$2</div>');
}


List<Widget> getPicturesList(pictures) {
  List<Widget> list = [];
  for(var i in pictures) {
    list.add(
      new Container(
        width: 100,
        height: 100,
        color: Colors.black87,
        child: new Image.network(i),
      )
    );
  }
  return list;
}

class DynamicItem extends StatelessWidget {
  DynamicItem({ this.data });
  final data;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(data['user']['avatarUrl']),
          ),
          title: Text(data['user']['nickname']),
          subtitle: Text(RelativeDateFormat.format(new DateTime.fromMicrosecondsSinceEpoch(int.parse(data['createdAt'])))),
        ),

        // new Text(data['content']),

        // Html(data: text2html(data['content'])),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.topLeft,
          // color: Colors.black87,
          child: Text(data['content'], 
            style: Theme.of(context)
            .textTheme
            .body1
            .copyWith(color: Colors.black87)
          )
        ),

        data['pictures'].length > 0 ? Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Wrap(
            spacing: 8, //主轴上子控件的间距
            runSpacing: 8,
            children: getPicturesList(data['pictures']), //要显示的子控件集合 //交叉轴上子控件之间的间距
          )
        ) : Container(),

        Container(
          child: Divider(),
          // color: Colors.black87,
          margin: const EdgeInsets.only(top: 16),
        ),
    
      ],
    );
  }
}


                       