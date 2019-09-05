import 'package:flutter/cupertino.dart';

enum Action { Ok, Cancel }

Future alert({
  @required BuildContext context,
  String title,
  String content,
  WidgetBuilder contentBuilder,
  bool showConfirm = true,
  bool showCancel = true,
  String confirmText = '确定',
  String cancelText = '取消',
  Function onConfirm,
  Function onCancel,
}) async {
  final action = await showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: title == null ? null : Text(title),
        content: contentBuilder == null ? (content == null ? null : Text(content)) : contentBuilder,
        actions: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: Color(0xFFdddddd), width: 0.5),
                top: BorderSide(color: Color(0xFFdddddd), width: 0.5),
              ),
            ),
            child: showCancel
                ? CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context, Action.Cancel);
                    },
                    child: Text('取消'),
                  )
                : null,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFFdddddd), width: 0.5),
              ),
            ),
            child: showConfirm
                ? CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context, Action.Ok);
                    },
                    child: Text('确定'),
                  )
                : null,
          )
        ],
      );
    },
  );

  return action;
}
