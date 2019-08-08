import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(PageState state, Dispatch dispatch, ViewService viewService) {
  println('view: buildView');
  return CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
        middle: Text("我"),
        border: Border(
          top: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        trailing: CupertinoButton(
            onPressed: () {
              dispatch(PageActionCreator.update('Say', 'Hello, fish redux'));
            },
            child: Icon(CupertinoIcons.add),
            padding: const EdgeInsets.all(0))),
    child: Center(
      child: Text(state.content),
    ),
  );
}
