import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'state.dart';
import 'action.dart';
import 'package:reactmobi/pages/user/login.dart';

/// another style of writing
Effect<PageState> buildEffect() {
  return combineEffects(<Object, Effect<PageState>>{
    Lifecycle.initState: _initState,
    'onShare': _onShare,
    PageAction.onTest: _onTest,
    PageAction.onShowLoginPage: _onShowLoginPage,
  });
}

void _initState(Action action, Context<PageState> ctx) {
  //do something on initState
}

void _onShare(Action action, Context<PageState> ctx) async {
  //do something on onShare
  await Future<void>.delayed(Duration(milliseconds: 1000));
  println("Effect: _onShare");
  ctx.dispatch(const Action('shared'));
}

void _onTest(Action action, Context<PageState> ctx) async {
  //do something on onShare
  await Future<void>.delayed(Duration(milliseconds: 1000));
  println("Effect111111111: _onTest");
  ctx.dispatch(PageActionCreator.update('_onTest1111', '_onTest2222'));
}

void _onShowLoginPage(Action action, Context<PageState> ctx) async {
  ctx.dispatch(PageActionCreator.update('_onTest1111', '_onTest2222'));

  Navigator.of(ctx.context, rootNavigator: true).push(
    CupertinoPageRoute(
      fullscreenDialog: true,
      builder: (context) => CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          border: Border(
            top: BorderSide(
              style: BorderStyle.none,
            ),
          ),
          // backgroundColor: Colors.white,
          middle: Text(
            '登录',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        child: UserLogin(),
      ),
    ),
  );
}

// class MessageComponent extends Component<String> {
//     MessageComponent(): super(
//             view: buildMessageView,
//             effect: buildEffect(),
//         );
// }
