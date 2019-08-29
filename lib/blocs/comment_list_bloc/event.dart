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

class CommentListFetchMore extends CommentListEvent {
  // final BuildContext context;

  // CommentListFetchMore({@required this.context})
  //     : super([
  //         context
  //       ]);

  @override
  String toString() => 'CommentListFetchMore';
}
