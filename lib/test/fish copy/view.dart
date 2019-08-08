import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'action.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

Widget buildView(PageState state, Dispatch dispatch, ViewService viewService) {
  println('view: buildView');
  return Scaffold(
    appBar: AppBar(title: Text(state.title)),
    body: Center(
      child: Text(state.content),
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        //点击按钮发送意图
        dispatch(PageActionCreator.update('Say', 'Hello, fish redux'));
      },
      child: Icon(Icons.edit),
    ),
  );
}
