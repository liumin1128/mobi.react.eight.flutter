import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:eight/graphql/schema/comment.dart';
import 'index.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final GraphQLClient client;

  CommentListBloc({@required this.client}) : assert(client != null);

  @override
  CommentListState get initialState => Uninitialized();

  @override
  Stream<CommentListState> mapEventToState(CommentListEvent event) async* {
    if (event is CommentListFetch) {
      yield* _mapCommentListFetchToState(event);
    } else if (event is CommentListFetchMore) {
      yield* _mapCommentListFetchMoreToState();
    }
  }

  Stream<CommentListState> _mapCommentListFetchToState(event) async* {
    try {
      final QueryResult res = await client.mutate(
        MutationOptions(document: commentListSchema, variables: {
          'session': event.session,
          'first': 10
        }),
      );

      if (res.hasErrors) return;

      var list = res.data['list'];

      yield CommentListFetchSuccessed(list: list, session: event.session);
    } catch (_) {
      print('_mapLoggedInToState出错');
      yield CommentListFetchError();
    }
  }

  Stream<CommentListState> _mapCommentListFetchMoreToState() async* {
    try {
      if (currentState is CommentListFetchSuccessed) {
        final _list = (currentState as CommentListFetchSuccessed).list;
        final _session = (currentState as CommentListFetchSuccessed).session;
        final skip = _list.length;
        print(skip);

        final QueryResult res = await client.mutate(
          MutationOptions(
            document: commentListSchema,
            variables: {
              'skip': skip,
              'session': _session
            },
          ),
        );

        if (res.hasErrors) return;

        var list = res.data['list'];

        yield CommentListFetchSuccessed(list: _list + list, session: _session);
      }
    } catch (_) {
      print('_mapCommentListFetchToState error');
      yield CommentListFetchError();
    }
  }
}
