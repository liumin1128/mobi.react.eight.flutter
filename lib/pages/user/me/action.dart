import 'package:fish_redux/fish_redux.dart';

enum PageAction { update, onTest } //action类型

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
}
