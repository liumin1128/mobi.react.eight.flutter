import 'package:flutter/cupertino.dart';

import 'package:eight/utils/common.dart';
import 'package:eight/components/Icons/Eva.dart';
import 'package:eight/components/Avatar/avatar.dart';
import 'pictures.dart';

text2html(str) {
  return str;
  // .replaceAll(new RegExp(r"(.*?)\[(.*?)_(.*?)]"), '\$1<img src="https://imgs.react.mobi/emoticon/\$2/\$3.gif" class="emoji" alt="[\$2_\$3]">');
  // .replace(/(.*?)\[(.*?)_(.*?)]/ig, )
  // .replace(/(.*?)\n(.*?)/ig, '$1<div>$2</div>');
}

class DynamicItem extends StatelessWidget {
  DynamicItem({this.data});
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
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontSize: 18, color: Color(0xFF333333)),
            ),
          ),

          // 图片组件
          data['pictures'].length > 0
              ? Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
                  child: getPicturesList(data['pictures']),
                )
              // ? Container(
              //     alignment: Alignment.topLeft,
              //     padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              //     child: Wrap(
              //       spacing: 4, //主轴上子控件的间距
              //       runSpacing: 4,
              //       children: getPicturesList(data['pictures']), //要显示的子控件集合 //交叉轴上子控件之间的间距
              //     ),
              //   )
              : Container(),

          // 用户操作
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
            height: 8,
            // margin: const EdgeInsets.only(top: 16),
          ),
        ],
      ),
    );
  }
}
