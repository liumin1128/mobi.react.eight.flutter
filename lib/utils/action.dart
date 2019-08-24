import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          showCancel
              ? CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context, Action.Cancel);
                  },
                  child: Text('取消'),
                )
              : null,
          showConfirm
              ? CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context, Action.Ok);
                  },
                  child: Text('确定'),
                )
              : null,
        ],
      );
    },
  );

  return action;
}
