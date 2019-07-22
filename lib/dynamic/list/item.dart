import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

List<Widget> getPicturesList(pictures) {
  List<Widget> list = [];
  for(var i in pictures) {
    list.add(
      new Container(
        width: 100,
        height: 100,
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
          subtitle: Text(data['content']),
        ),
        
        data.containsKey('pictures') ? Container(
          alignment: Alignment.topLeft,
          child: Wrap(
            spacing: 8, //主轴上子控件的间距
            runSpacing: 8,
            children: getPicturesList(data['pictures']), //要显示的子控件集合 //交叉轴上子控件之间的间距
          )
        ) : null,

        ButtonTheme.bar(
          // make buttons use the appropriate styles for cards
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {/* ... */},
              ),
              FlatButton(
                child: const Text('LISTEN'),
                onPressed: () {/* ... */},
              ),
            ],
          ),
        ),
      ],
    );
  }
}


                       