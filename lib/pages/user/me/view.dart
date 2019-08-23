import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';
import 'package:reactmobi/pages/user/login.dart';
import 'package:reactmobi/components/LikeBtn/like_button.dart';

Widget buildView(PageState state, Dispatch dispatch, ViewService viewService) {
  println('view: buildView');
  return CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
        middle: Text(state.title),
        border: Border(
          top: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        trailing: LikeButton(
          width: 56.0,
          duration: Duration(milliseconds: 500),
        )
        // trailing: CupertinoButton(
        //     onPressed: () {
        //       dispatch(PageActionCreator.update('Say121212121', 'Hello, fish redux22222'));
        //     },
        //     child: Icon(CupertinoIcons.add),
        //     padding: const EdgeInsets.all(0)),
        ),
    child: Center(
        child: Column(
      children: <Widget>[
        Text(state.content),
        Text(state.content),
        Text(state.content),
        Text(state.content),
        Text(state.content),
        CupertinoButton(
          child: Text('update1'),
          onPressed: () {
            dispatch(PageActionCreator.update('update1', 'update1'));
          },
        ),
        CupertinoButton(
          child: Text('onTest'),
          onPressed: () {
            dispatch(PageActionCreator.onTest());
          },
        ),
        CupertinoButton(
          child: Text('onShowLoginPage'),
          color: Colors.amber,
          onPressed: () {
            dispatch(PageActionCreator.onShowLoginPage());
          },
        ),
      ],
    )),
  );
}
