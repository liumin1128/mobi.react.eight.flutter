import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'index.dart';

@immutable
abstract class DynamicListState extends Equatable {
  DynamicListState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends DynamicListState {}

class DynamicListFetchError extends DynamicListState {}

class DynamicListFetchSuccessed extends DynamicListState {
  final List<Item> list;

  DynamicListFetchSuccessed({@required this.list});

  @override
  List<Object> get props => [list];
}
