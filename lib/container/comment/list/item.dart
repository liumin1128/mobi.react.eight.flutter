import 'package:flutter/cupertino.dart';
import 'package:eight/utils/common.dart';
import 'package:eight/components/Avatar/index.dart';
import 'package:eight/components/LikeBtn/index.dart';

text2html(str) {
  return str;
  // .replaceAll(new RegExp(r"(.*?)\[(.*?)_(.*?)]"), '\$1<img src="https://imgs.react.mobi/emoticon/\$2/\$3.gif" class="emoji" alt="[\$2_\$3]">');
  // .replace(/(.*?)\[(.*?)_(.*?)]/ig, )
  // .replace(/(.*?)\n(.*?)/ig, '$1<div>$2</div>');
}

class CommentItem extends StatelessWidget {
  CommentItem({this.data});
  final data;

  @override
  Widget build(BuildContext context) {
    final createdAt = RelativeDateFormat.format(new DateTime.fromMicrosecondsSinceEpoch(int.parse(data['createdAt'])));
    return Container(
      decoration: BoxDecoration(color: CupertinoColors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // 用户信息
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Avatar(src: data['user']['avatarUrl'], size: 40),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data['user']['nickname'],
                      style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                    ),
                    Text(
                      createdAt,
                      style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontSize: 16, color: Color(0xFF666666)),
                    ),
                  ],
                )
              ],
            ),
          ),

          // 文本部分
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              data['content'],
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontSize: 18, color: Color(0xFF666666)),
            ),
          ),

          // 用户操作
          Row(
            // alignment: Alignment.centerLeft,
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
            children: <Widget>[
              // Icon(
              //   CupertinoIcons.heart,
              //   color: Color(0xFF999999),
              //   size: 20,
              // ),
              LikeButton(width: 64, duration: Duration(milliseconds: 1000)),

              Transform(
                  transform: Matrix4.translationValues(-8, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        data['zanCount'].toString(),
                        style: CupertinoTheme.of(context).textTheme.actionTextStyle.copyWith(color: Color(0xFF999999), fontSize: 16, fontWeight: FontWeight.w100),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
                      Icon(
                        CupertinoIcons.search,
                        color: Color(0xFF999999),
                        size: 24,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                      Text(
                        data['commentCount'].toString(),
                        style: CupertinoTheme.of(context).textTheme.actionTextStyle.copyWith(color: Color(0xFF999999), fontSize: 16, fontWeight: FontWeight.w100),
                      ),
                    ],
                  )),
            ],
          ),

          Container(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            height: 8,
            // margin: const EdgeInsets.only(top: 16),
          ),
        ],
      ),
    );
  }
}
