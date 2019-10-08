import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'index.dart';

@immutable
abstract class NotificationListState extends Equatable {
  NotificationListState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends NotificationListState {}

class NotificationListFetchError extends NotificationListState {}

class NotificationListFetchSuccessed extends NotificationListState {
  final List<Item> list;

  NotificationListFetchSuccessed({@required this.list});

  @override
  List<Object> get props => [list];
}
