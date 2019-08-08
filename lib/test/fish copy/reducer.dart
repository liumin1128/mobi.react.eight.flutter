import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<PageState> buildReducer() {
  println('Reducer:buildReducer');
  return asReducer<PageState>(<Object, Reducer<PageState>>{
    //这里添加要监听的Action
    PageAction.update: _update, //监听到PageAction.update
  });
}

PageState _update(PageState state, Action action) {
  println('Reducer: _update');
  final Map<String, String> update = action.payload ?? <String, String>{}; //获取action附带的数据
  final PageState newState = state.clone();
  newState.title = update['title'] ?? newState.title;
  newState.content = update['content'] ?? newState.content;
  return newState;
}
