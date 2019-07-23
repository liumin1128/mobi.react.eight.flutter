
import 'package:flutter/material.dart';

List<Widget> getPicturesList(pictures) {
  List<Widget> list = [];
  for(var i in pictures) {
    list.add(
      Container(
        width: 100,
        height: 100,
        child: Image.network(i),
      )
    );
  }
  return list;
}

class LongList extends StatelessWidget {
  final List<String> items = new List<String>.generate(10000, (i) => "Item $i");

  @override
  Widget build(BuildContext context) {
    final title = 'Long List';

    return new MaterialApp(
      title: title,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://imgs.react.mobi/Fnz7iDqJJ97DrX_hhQs4lq_FEHkz'),
                  ),
                  title: Text('${items[index]}'),
                  subtitle: Text('xxxxx'),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.topLeft,
                  child: Text('xxxxxxxxxx', 
                      style: Theme.of(context)
                      .textTheme
                      .body1
                      .copyWith(color: Colors.black87, fontSize: 24)
                    )
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Wrap(
                    spacing: 8, //主轴上子控件的间距
                    runSpacing: 8,
                    children: getPicturesList([
                      'https://imgs.react.mobi/Fv-r9Nya5b32jJEy3R12yuYJOTke',
                      'https://imgs.react.mobi/Fv-r9Nya5b32jJEy3R12yuYJOTke',
                      'https://imgs.react.mobi/Fv-r9Nya5b32jJEy3R12yuYJOTke',
                    ]), //要显示的子控件集合 //交叉轴上子控件之间的间距`
                  )
                )
              ]
            );
          }, 
        ),
      ),
    );
  }
}