import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;

enum PageAction { update, onTest, onShowLoginPage } //action类型

class PageActionCreator {
  //刷新action，在按钮事件中调用，参数传入要刷新的数据
  static Action update(String title, String content) {
    println('action:update');
    return Action(
      PageAction.update, //action类型
      payload: <String, String>{
        'title': title,
        'content': content
      }, //附带数据
    );
  }

  static Action onTest() {
    println('effect:test');
    return Action(PageAction.onTest);
  }

  static Action onShowLoginPage() {
    println('effect:onShowLoginPage');
    return Action(PageAction.onShowLoginPage);
  }
}
