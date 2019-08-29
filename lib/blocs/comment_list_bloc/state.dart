import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommentListState extends Equatable {
  CommentListState([List props = const []]) : super(props);
}

class Uninitialized extends CommentListState {
  @override
  String toString() => 'Uninitialized';
}

class CommentListFetchError extends CommentListState {
  @override
  String toString() => 'CommentListFetchError';
}

class CommentListFetchSuccessed extends CommentListState {
  final String session;
  final List list;

  CommentListFetchSuccessed({
    @required this.list,
    @required this.session,
  }) : super([
          list,
          session
        ]);

  @override
  String toString() => 'CommentListFetchSuccessed { session: $session, list: $list, }';
}
