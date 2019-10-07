import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'index.dart';

@immutable
abstract class NewsListState extends Equatable {
  NewsListState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends NewsListState {}

class NewsListFetchError extends NewsListState {}

class NewsListFetchSuccessed extends NewsListState {
  final List<Item> list;

  NewsListFetchSuccessed({@required this.list});

  @override
  List<Object> get props => [list];
}
