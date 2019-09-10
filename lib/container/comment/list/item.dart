import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:eight/components/Avatar/index.dart';
import 'package:eight/components/LikeBtn/index.dart';

text2html(str) {
  return str;
  // .replaceAll(RegExp(r"(.*?)\[(.*?)_(.*?)]"), '\$1<img src="https://imgs.react.mobi/emoticon/\$2/\$3.gif" class="emoji" alt="[\$2_\$3]">');
  // .replace(/(.*?)\[(.*?)_(.*?)]/ig, )
  // .replace(/(.*?)\n(.*?)/ig, '$1<div>$2</div>');
}

showReplys(replys, onReply) {
  List<Widget> list = [];
  for (var i = 0; i < replys.length; i++) {
    final reply = replys[i];
    final TapGestureRecognizer recognizer = TapGestureRecognizer();

    recognizer.onTap = () {
      onReply(reply);
    };

    list.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: RichText(
              text: TextSpan(
                // text: 'This is ',
                style: TextStyle(color: Color(0xFF000000)),
                children: <TextSpan>[
                  TextSpan(
                    text: reply.user.nickname,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  reply.replyTo != null
                      ? TextSpan(
                          text: ' 回复 ',
                          children: <TextSpan>[
                            TextSpan(
                              text: reply.replyTo.user.nickname,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      : TextSpan(),
                  TextSpan(text: ': '),
                  TextSpan(
                    text: reply.content,
                    recognizer: recognizer,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  return list;
}

class CommentItem extends StatelessWidget {
  CommentItem({@required this.data, this.onPressed});
  final data;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    // final createdAt = RelativeDateFormat.format(DateTime.fromMicrosecondsSinceEpoch(int.parse(data['createdAt'])));
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: CupertinoColors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // 用户信息
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Avatar(src: data.user.avatarUrl, size: 40),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data.user.nickname,
                        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontWeight: FontWeight.bold, color: Color(0xFF333333)),
                      ),
                      Text(
                        '刚刚',
                        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontSize: 16, color: Color(0xFF666666)),
                      ),
                    ],
                  ),
                ),
              ),
              LikeButton(width: 64, duration: Duration(milliseconds: 1000)),
            ],
          ),

          GestureDetector(
            onTap: () {
              onPressed(data, null);
            },
            child: Container(
              decoration: BoxDecoration(),
              padding: const EdgeInsets.only(left: 56, bottom: 16),
              alignment: Alignment.topLeft,
              child: Text(
                data.content,
                style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontSize: 18, color: Color(0xFF666666)),
              ),
            ),
          ),
          // 文本部分

          // 用户操作
          Container(
            padding: const EdgeInsets.only(left: 0),
            alignment: Alignment.topLeft,
            child: Row(
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

                // Transform(
                //   transform: Matrix4.translationValues(-8, 0, 0),
                //   child: Row(
                //     children: <Widget>[
                //       Text(
                //         data['zanCount'].toString(),
                //         style: CupertinoTheme.of(context).textTheme.actionTextStyle.copyWith(color: Color(0xFF999999), fontSize: 16, fontWeight: FontWeight.w100),
                //       ),
                //       Padding(padding: EdgeInsets.symmetric(horizontal: 16)),
                //       Icon(
                //         CupertinoIcons.search,
                //         color: Color(0xFF999999),
                //         size: 24,
                //       ),
                //       Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                //       Text(
                //         data['replyCount'].toString(),
                //         style: CupertinoTheme.of(context).textTheme.actionTextStyle.copyWith(color: Color(0xFF999999), fontSize: 16, fontWeight: FontWeight.w100),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),

          data.replys.length > 0
              ? Container(
                  padding: const EdgeInsets.only(left: 56, right: 16, bottom: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFf8f8f8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: showReplys(data.replys, (reply) {
                        onPressed(data, reply);
                      }),
                    ),
                  ),
                )
              : Container(),

          Container(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            height: 1,
            // margin: const EdgeInsets.only(top: 16),
          ),
        ],
      ),
    );
  }
}
