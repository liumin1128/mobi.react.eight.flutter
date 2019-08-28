import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DynamicListState extends Equatable {
  DynamicListState([List props = const []]) : super(props);
}

class Uninitialized extends DynamicListState {
  @override
  String toString() => 'Uninitialized';
}

class Unauthenticated extends DynamicListState {
  @override
  String toString() => 'Unauthenticated';
}

class DynamicListFetchSuccessed extends DynamicListState {
  final List list;

  DynamicListFetchSuccessed(this.list)
      : super([
          list,
        ]);

  @override
  String toString() => 'DynamicListFetchSuccessed { list: $list, }';
}
