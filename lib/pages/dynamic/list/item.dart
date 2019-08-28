import 'package:flutter/cupertino.dart';

// import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:eight/utils/common.dart';
import 'package:eight/components/Icons/Eva.dart';
import 'package:eight/components/Lazyload/Image.dart';
import 'package:eight/components/Ui/Avatar/avatar.dart';

text2html(str) {
  return str;
  // .replaceAll(new RegExp(r"(.*?)\[(.*?)_(.*?)]"), '\$1<img src="https://imgs.react.mobi/emoticon/\$2/\$3.gif" class="emoji" alt="[\$2_\$3]">');
  // .replace(/(.*?)\[(.*?)_(.*?)]/ig, )
  // .replace(/(.*?)\n(.*?)/ig, '$1<div>$2</div>');
}

List<Widget> getPicturesList(pictures) {
  List<Widget> list = [];
  for (var i in pictures) {
    list.add(new LazyloadImage(borderRadius: BorderRadius.circular(4), width: 100, height: 100, color: Color(0x05000000), image: i));
  }
  return list;
}

class DynamicItem extends StatelessWidget {
  DynamicItem({this.data});
  final data;

  @override
  Widget build(BuildContext context) {
    final createdAt = RelativeDateFormat.format(new DateTime.fromMicrosecondsSinceEpoch(int.parse(data['createdAt'])));

    return Container(
        decoration: BoxDecoration(color: CupertinoColors.white),
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
                      child: Avatar(src: data['user']['avatarUrl']),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(data['user']['nickname'], style: CupertinoTheme.of(context).textTheme.actionTextStyle),
                        Text(createdAt, style: CupertinoTheme.of(context).textTheme.actionTextStyle),
                      ],
                    )
                  ],
                )),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                alignment: Alignment.topLeft,
                child: Text(data['content'], style: CupertinoTheme.of(context).textTheme.actionTextStyle
                    // .copyWith(color: CupertinoColors.black87)
                    )),
            data['pictures'].length > 0
                ? Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                    child: Wrap(
                      spacing: 8, //主轴上子控件的间距
                      runSpacing: 8,
                      children: getPicturesList(data['pictures']), //要显示的子控件集合 //交叉轴上子控件之间的间距
                    ))
                : Container(),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
              child: Wrap(children: <Widget>[
                Icon(
                  EvaIcons.heartOutline,
                  color: CupertinoColors.black,
                  size: 16,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                Text(data['zanCount'].toString(), style: CupertinoTheme.of(context).textTheme.actionTextStyle.copyWith(color: CupertinoColors.black, fontSize: 16)),
                Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
                Icon(
                  EvaIcons.messageCircleOutline,
                  color: CupertinoColors.black,
                  size: 16,
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                Text(data['commentCount'].toString(), style: CupertinoTheme.of(context).textTheme.actionTextStyle.copyWith(color: CupertinoColors.black, fontSize: 16)),
              ]),
            ),
            Container(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              height: 1,
              // margin: const EdgeInsets.only(top: 16),
            ),
          ],
        ));
  }
}
