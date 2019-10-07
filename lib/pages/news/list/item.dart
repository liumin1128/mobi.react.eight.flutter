import 'package:flutter/cupertino.dart';
import 'package:eight/components/Lazyload/Image.dart';
import 'package:eight/components/Icons/Taobao.dart';
import 'package:eight/utils/common.dart';

actionButton(icon, text) {
  return Container(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: Color(0xFFaaaaaa), size: 14),
        Padding(padding: EdgeInsets.all(2)),
        Text(text, style: TextStyle(fontSize: 14, color: Color(0xFFaaaaaa))),
      ],
    ),
  );
}

class NewsListItem extends StatelessWidget {
  NewsListItem({this.data});
  final data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
          '/news/detail',
          arguments: {'id': data.id},
        );
      },
      child: Container(
        decoration: BoxDecoration(color: CupertinoColors.white),
        // margin: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          data.title,
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF333333),
                              ),
                        ),
                        Padding(padding: EdgeInsets.all(4)),
                        Container(
                          child: Row(
                            children: <Widget>[
                              actionButton(TaobaoIcons.attention, '233'),
                              // Padding(padding: EdgeInsets.all(4)),
                              // actionButton(TaobaoIcons.comment, '233'),
                              Padding(padding: EdgeInsets.all(4)),
                              Text(data.appName, style: TextStyle(fontSize: 14, color: Color(0xFFaaaaaa))),
                              Padding(padding: EdgeInsets.all(4)),
                              Text(getTimeAgo(data.createdAt), style: TextStyle(fontSize: 14, color: Color(0xFFaaaaaa))),
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(4)),
                        Container(height: 1, color: Color(0xFFefefef))
                      ],
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(8)),
                  LazyloadImage(
                    image: data.cover,
                    width: 108,
                    height: 80,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
