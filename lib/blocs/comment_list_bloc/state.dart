import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'index.dart';

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
  final List<Item> list;
  final bool isEnd;

  CommentListFetchSuccessed({
    @required this.list,
    @required this.session,
    @required this.isEnd,
  }) : super([
          list,
          session,
          isEnd
        ]);

  CommentListFetchSuccessed copyWith({
    List<Item> list,
    bool isEnd,
  }) {
    return CommentListFetchSuccessed(
      session: session ?? this.session,
      list: list ?? this.list,
      isEnd: isEnd ?? this.isEnd,
    );
  }

  CommentListFetchSuccessed pushComment({
    @required Item comment,
  }) {
    return CommentListFetchSuccessed(
      session: this.session,
      isEnd: this.isEnd,
      list: [
            comment
          ] +
          this.list,
    );
  }

  CommentListFetchSuccessed pushReply({
    @required Item reply,
    @required String commentTo,
  }) {
    final List<Item> _list = List<Item>.from(this.list).map((i) {
      if (i.id == commentTo) {
        return i.pushReply(reply: reply);
      }
      return i;
    }).toList();

    return CommentListFetchSuccessed(
      session: this.session,
      isEnd: this.isEnd,
      list: _list,
    );
  }

  @override
  String toString() => 'CommentListFetchSuccessed { session: $session, list: $list, }';
}
