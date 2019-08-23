import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T> alert<T>({
  @required BuildContext context,
  // @required WidgetBuilder builder,
  String title,
  String content,
  WidgetBuilder contentBuilder,
  bool showConfirm = true,
  bool showCancel = true,
  String confirmText = '确定',
  String cancelText = '取消',
  Function onConfirm,
  Function onCancel,
}) {
  return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: title == null ? null : Text(title),
          content: contentBuilder == null ? (content == null ? null : Text(content)) : contentBuilder,
          actions: <Widget>[
            showCancel
                ? CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('取消'),
                  )
                : null,
            showConfirm
                ? CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('确定'),
                  )
                : null,
          ],
        );
      });
}
