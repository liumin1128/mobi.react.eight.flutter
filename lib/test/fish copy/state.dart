import 'package:fish_redux/fish_redux.dart';

//创建页面状态类，包含标题和内容数据，状态类必须实现Cloneable接口
class PageState implements Cloneable<PageState> {
  String title;
  String content;

  PageState({this.title, this.content});

  @override
  PageState clone() {
    return PageState()
      ..title = title
      ..content = content;
  }
}

//页面状态初始化方法
PageState initState(Map<String, dynamic> args) {
  println('state:initState');
  return PageState(title: 'title', content: 'content');
}
