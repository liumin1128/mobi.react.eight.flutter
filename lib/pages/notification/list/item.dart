import 'package:flutter/cupertino.dart';
import 'package:eight/components/Lazyload/Image.dart';
import 'package:eight/components/Icons/Taobao.dart';
import 'package:eight/utils/common.dart';
import 'package:eight/components/Avatar/index.dart';

class NotificationListItem extends StatelessWidget {
  NotificationListItem({this.data});
  final data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context, rootNavigator: true).pushNamed(
        //   '/news/detail',
        //   arguments: {'id': data.id},
        // );
      },
      child: Container(
        decoration: BoxDecoration(color: CupertinoColors.white),
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              // padding: EdgeInsets.only(top: 16, left: 12, right: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // 用户头像
                  Container(
                    padding: EdgeInsets.only(right: 12),
                    child: Avatar(src: data.actionor.avatarUrl, size: 48),
                  ),
                  // 用户信息
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data.actionor.nickname,
                          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                        ),
                        Text(
                          // getTimeAgo(data.createdAt),
                          data.actionor.sign,
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
                  // Button(
                  //   borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  //   color: CupertinoTheme.of(context).primaryColor,
                  //   child: Text('关注', style: TextStyle(color: CupertinoTheme.of(context).primaryColor)),
                  //   padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  //   minSize: 12,
                  //   onPressed: () {},
                  // ),
                ],
              ),
            ),
            Container(
              // color: Color(0xFF333333),
              padding: EdgeInsets.only(left: 60, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.actionShowText + (data.actionorShowText != '' ? (': ' + data.actionorShowText) : ''),
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFaaaaaa),
                    ),
                  ),
                  data.userShowText != ''
                      ? Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(top: 8),
                          color: Color(0xFFeeeeee),
                          child: Text('@' + data.user.nickname + ': ' + data.userShowText),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
