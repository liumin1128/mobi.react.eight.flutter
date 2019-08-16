import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'action.dart';

/// another style of writing
Effect<PageState> buildEffect() {
  return combineEffects(<Object, Effect<PageState>>{
    Lifecycle.initState: _initState,
    'onShare': _onShare,
    PageAction.onTest: _onTest,
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

// class MessageComponent extends Component<String> {
//     MessageComponent(): super(
//             view: buildMessageView,
//             effect: buildEffect(),
//         );
// }
