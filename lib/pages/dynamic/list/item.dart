import 'package:flutter/cupertino.dart';
import 'package:eight/utils/common.dart';
import 'package:eight/components/Avatar/index.dart';
import 'package:eight/components/MultiPicturesView/index.dart';
import 'package:eight/components/Icons/Taobao.dart';
import 'package:eight/components/Button/index.dart';

actionButton(icon, text) {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: Color(0xFFaaaaaa), size: 22),
        Padding(padding: EdgeInsets.all(2)),
        Text(text, style: TextStyle(fontSize: 14, color: Color(0xFFaaaaaa))),
      ],
    ),
  );
}

class DynamicItem extends StatelessWidget {
  DynamicItem({this.data});
  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: CupertinoColors.white),
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 用户信息

          Container(
            padding: EdgeInsets.only(top: 16, left: 12, right: 12),
            child: Row(
              children: <Widget>[
                // 用户头像
                Container(
                  padding: EdgeInsets.only(right: 12),
                  child: Avatar(src: data.user.avatarUrl, size: 48),
                ),
                // 用户信息
                Expanded(
                  child: Column(
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
                        // getTimeAgo(data.createdAt),
                        data.user.sign,
                        maxLines: 1,
                        // softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                              fontSize: 16,
                              // fontWeight: FontWeight.w300,
                              color: Color(0xFFbbaaaa),
                            ),
                      ),
                    ],
                  ),
                ),
                // 关注按钮
                Button(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  color: CupertinoTheme.of(context).primaryColor,
                  child: Text('关注', style: TextStyle(color: CupertinoTheme.of(context).primaryColor)),
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  minSize: 12,
                  onPressed: () {},
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.only(left: 72, top: 8, right: 16),
            // color: Color(0xFF888888),
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
                          child: Text(
                            data.content,
                            textAlign: TextAlign.left,
                            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                                  fontSize: 20,
                                  color: Color(0xFF333333),
                                  height: 1.5,
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
                        padding: const EdgeInsets.only(top: 12),
                        child: multiPictureView(data.pictures),
                      )
                    : Container(),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    // alignment: Alignment.centerLeft,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
                    children: <Widget>[
                      actionButton(TaobaoIcons.like, '233'),
                      actionButton(TaobaoIcons.comment, '233'),
                      actionButton(TaobaoIcons.forward, '233'),

                      // actionButton(TaobaoIcons.share, '分享'),
                      Text(
                        getTimeAgo(data.createdAt),
                        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                              fontSize: 14,
                              // fontWeight: FontWeight.w300,
                              color: Color(0xFFaaaaaa),
                            ),
                      )
                    ],
                  ),
                )

                // 用户操作
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
