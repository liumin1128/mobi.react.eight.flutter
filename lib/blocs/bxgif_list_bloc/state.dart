import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'index.dart';

@immutable
abstract class BxgifListState extends Equatable {
  BxgifListState([List props = const []]) : super(props);
}

class Uninitialized extends BxgifListState {
  @override
  String toString() => 'Uninitialized';
}

class BxgifListFetchError extends BxgifListState {
  @override
  String toString() => 'BxgifListFetchError';
}

class BxgifListFetchSuccessed extends BxgifListState {
  final List<Item> list;

  BxgifListFetchSuccessed({@required this.list}) : super([list]);

  @override
  String toString() => 'BxgifListFetchSuccessed { list: $list, }';
}
