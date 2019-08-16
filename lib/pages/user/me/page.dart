import 'package:fish_redux/fish_redux.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';
import 'effect.dart';

class MainPage extends Page<PageState, Map<String, dynamic>> {
  MainPage()
      : super(
          reducer: buildReducer(),
          effect: buildEffect(),
          initState: initState,
          view: buildView,
        );
}
