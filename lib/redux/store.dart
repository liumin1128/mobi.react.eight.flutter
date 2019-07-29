import 'package:redux/redux.dart';

// Define your Actions
class AddItemAction {
  String item;
}

class PerformSearchAction {
  String query;
}

class RemoveItemAction {
  String item;
}

class AppState {
  final List<String> items;
  final String searchQuery;

  AppState(this.items, this.searchQuery);
}

List<String> addItemReducer(List<String> items, AddItemAction action) {
  return new List.from(items)..add(action.item);
}

List<String> removeItemReducer(List<String> items, RemoveItemAction action) {
  return new List.from(items)..remove(action.item);
}

Reducer<List<String>> itemsReducer = combineReducers<List<String>>([
  new TypedReducer<List<String>, AddItemAction>(addItemReducer),
  new TypedReducer<List<String>, RemoveItemAction>(removeItemReducer),
]);

String searchQueryReducer(String searchQuery, action) {
  return action is PerformSearchAction ? action.query : searchQuery;
}

// Use the new itemsReducer just like we did before
AppState appStateReducer(AppState state, action) => new AppState(itemsReducer(state.items, action), searchQueryReducer(state.searchQuery, action));
