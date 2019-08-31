import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CommentListEvent extends Equatable {
  CommentListEvent([List props = const []]) : super(props);
}

class CommentListFetch extends CommentListEvent {
  final String session;

  CommentListFetch({@required this.session})
      : super([
          session
        ]);
  @override
  String toString() => 'CommentListFetch';
}

class CommentListCreateComment extends CommentListEvent {
  final String session;
  final String content;

  CommentListCreateComment({@required this.session, @required this.content})
      : super([
          session,
          content,
        ]);

  @override
  String toString() => 'CommentListCreateComment';
}

class CommentListFetchMore extends CommentListEvent {
  @override
  String toString() => 'CommentListFetchMore';
}
