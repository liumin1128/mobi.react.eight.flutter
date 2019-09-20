import 'package:flutter/cupertino.dart';
import 'package:eight/utils/common.dart';
import 'package:eight/components/Avatar/index.dart';
import 'package:eight/components/LikeBtn/index.dart';
import 'package:eight/components/MultiPicturesView/index.dart';

text2html(str) {
  return str;
  // .replaceAll(RegExp(r"(.*?)\[(.*?)_(.*?)]"), '\$1<img src="https://imgs.react.mobi/emoticon/\$2/\$3.gif" class="emoji" alt="[\$2_\$3]">');
  // .replace(/(.*?)\[(.*?)_(.*?)]/ig, )
  // .replace(/(.*?)\n(.*?)/ig, '$1<div>$2</div>');
}

class BxgifItem extends StatelessWidget {
  BxgifItem({this.data});
  final data;

  @override
  Widget build(BuildContext context) {
    final createdAt = RelativeDateFormat.format(DateTime.fromMicrosecondsSinceEpoch(int.parse(data['createdAt'])));
    return Container(
      decoration: BoxDecoration(color: CupertinoColors.white),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 用户信息
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Avatar(src: data['user'] != null ? data['user']['avatarUrl'] : '', size: 40),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data['user'] != null ? data['user']['nickname'] : '消失在虚空的用户',
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
          data['content'] != null && data['content'] != ''
              ? GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushNamed('/dynamic/detail');
                    // Navigator.pushNamed(context, "/news");
                    Navigator.of(context, rootNavigator: true).pushNamed(
                      '/dynamic/detail',
                      arguments: {'session': data['_id']},
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    // color: Color(0xFF666666),
                    child: Text(
                      data['content'],
                      textAlign: TextAlign.left,
                      style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontSize: 18, color: Color(0xFF666666)),
                    ),
                  ),
                )
              : Container(),

          // 图片组件
          data['pictures'].length > 0
              ? Container(
                  // width: 300,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
                  child: multiPictureView(data['pictures']),
                )
              // ? Container(
              //     alignment: Alignment.topLeft,
              //     padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              //     child: Wrap(
              //       spacing: 4, //主轴上子控件的间距
              //       runSpacing: 4,
              //       children: multiPictureView(data['pictures']), //要显示的子控件集合 //交叉轴上子控件之间的间距
              //     ),
              //   )
              : Container(),

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
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(
                            '/dynamic/detail',
                            arguments: {'session': data['_id']},
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(),
                          child: Text(
                            data['commentCount'].toString(),
                            style: CupertinoTheme.of(context).textTheme.actionTextStyle.copyWith(color: Color(0xFF999999), fontSize: 16, fontWeight: FontWeight.w100),
                          ),
                        ),
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
