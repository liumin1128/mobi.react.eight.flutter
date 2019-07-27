import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';
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

    final createdAt = RelativeDateFormat.format(new DateTime.fromMicrosecondsSinceEpoch(int.parse(data['createdAt'])));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
      // margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(data['user']['avatarUrl']),
                    ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(data['user']['nickname'], style: Theme.of(context).textTheme.body2),
                    Text(createdAt, style: Theme.of(context).textTheme.caption),
                  ],
                )
            ],)
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.topLeft,
            child: Text(data['content'], 
              style: Theme.of(context)
              .textTheme
              .body1
              // .copyWith(color: Colors.black87)
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
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
            child: Wrap(
              children: <Widget>[

                Icon(
                  Icons.thumb_up,
                  color: Colors.black38,
                  size: 16,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                Text(data['zanCount'].toString(),
                    style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.black38, fontSize: 16)
                ),

                Padding(padding: EdgeInsets.symmetric(horizontal: 16)),

                Icon(
                  Icons.mode_comment,
                  color: Colors.black38,
                  size: 16,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                Text(data['commentCount'].toString(),
                    style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Colors.black38, fontSize: 16)
                ),

        
              ]
            ),
          ),



          Container(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            height: 8,
            margin: const EdgeInsets.only(top: 16),
          ),
          
      
        ],
      )
    
  
    );
    
    
  }
}


                       