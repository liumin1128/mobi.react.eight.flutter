import 'package:flutter/cupertino.dart';
import 'package:eight/utils/common.dart';
import 'package:eight/components/Avatar/index.dart';
import 'package:eight/components/LikeBtn/index.dart';
import 'package:eight/components/MultiPicturesView/index.dart';
import 'package:eight/utils/common.dart';

text2html(str) {
  return str;
  // .replaceAll(RegExp(r"(.*?)\[(.*?)_(.*?)]"), '\$1<img src="https://imgs.react.mobi/emoticon/\$2/\$3.gif" class="emoji" alt="[\$2_\$3]">');
  // .replace(/(.*?)\[(.*?)_(.*?)]/ig, )
  // .replace(/(.*?)\n(.*?)/ig, '$1<div>$2</div>');
}

class DynamicItem extends StatelessWidget {
  DynamicItem({this.data});
  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(color: CupertinoColors.white),
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 用户信息
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Avatar(src: data.user.avatarUrl, size: 48),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.user.nickname,
                    style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                  ),
                  Text(
                    getTimeAgo(data.createdAt),
                    style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                          fontSize: 18,
                          color: Color(0xFF666666),
                        ),
                  ),
                ],
              )
            ],
          ),

          Container(
            padding: const EdgeInsets.only(left: 56),
            child: Column(
              children: <Widget>[
                // 文本部分
                data.content != null && data.content != ''
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(
                            '/dynamic/detail',
                            arguments: {'session': data['_id']},
                          );
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          // color: Color(0xFF666666),
                          child: Text(
                            data.content,
                            textAlign: TextAlign.left,
                            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                                  fontSize: 20,
                                  color: Color(0xFF666666),
                                ),
                          ),
                        ),
                      )
                    : Container(),

                // 图片组件
                data.pictures.length > 0
                    ? Container(
                        // width: 300,
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(top: 14, left: 14, right: 14),
                        child: multiPictureView(data.pictures),
                      )
                    : Container(),
              ],
            ),
          ),

          // 用户操作
          // Container(
          //   color: Color.fromRGBO(0, 0, 0, 0.05),
          //   height: 8,
          //   // margin: const EdgeInsets.only(top: 16),
          // ),
        ],
      ),
    );
  }
}
