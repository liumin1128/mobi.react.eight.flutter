import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:eight/graphql/schema/comment.dart';
import 'index.dart';
import 'package:eight/utils/action.dart';

final int fist = 10;

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
    } else if (event is CommentListCreateComment) {
      yield* _mapCommentListCreateCommentToState(event);
    }
  }

  Stream<CommentListState> _mapCommentListFetchToState(event) async* {
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    print(event.session);
    try {
      final QueryResult res = await client.mutate(
        MutationOptions(document: commentListSchema, variables: {
          'session': event.session,
          'first': fist
        }),
      );

      if (res.hasErrors) return;

      var list = res.data['list'];

      List<Item> _comments = [];
      for (var i = 0; i < list.length; i++) {
        _comments.add(getCommentItem(list[i]));
      }

      final isEnd = res.data['meta']['commentCount'] <= _comments.length;

      print('isEnd');
      print(isEnd);

      yield CommentListFetchSuccessed(list: _comments, session: event.session, isEnd: isEnd);
    } catch (error) {
      print('error');
      print(error);
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
              'session': _session,
              'first': fist
            },
          ),
        );

        if (res.hasErrors) return;

        List<Item> _comments = [];
        for (var i = 0; i < res.data['list'].length; i++) {
          _comments.add(getCommentItem(res.data['list'][i]));
        }

        final list = _list + _comments;

        final isEnd = res.data['meta']['commentCount'] <= list.length;

        yield CommentListFetchSuccessed(list: list, session: _session, isEnd: isEnd);
      }
    } catch (_) {
      print('_mapCommentListFetchToState error');
      yield CommentListFetchError();
    }
  }

  Stream<CommentListState> _mapCommentListCreateCommentToState(event) async* {
    try {
      if (currentState is CommentListFetchSuccessed) {
        print('event');
        print(event.session);
        print(event.content);

        final QueryResult res = await client.mutate(
          MutationOptions(
            document: createCommentSchema,
            variables: {
              'session': event.session,
              'content': event.content,
            },
          ),
        );

        if (res.hasErrors) return;

        var result = res.data['result'];

        if (result['status'] == 200) {
          final _list = (currentState as CommentListFetchSuccessed).list;

          print('评论成功');

          final list = [
            getCommentItem(result['data'])
          ];

          yield CommentListFetchSuccessed(list: list + _list, session: event.session);
        } else if (result['status'] == 403) {
          print('尚未登录');

          alert(
            context: event.context,
            title: '评论失败',
            content: result['message'],
            showCancel: false,
          );
        }
      }
    } catch (error) {
      print('_mapCommentListFetchToState error');
      print(error);
      yield CommentListFetchError();
    }
  }

  Stream<CommentListState> _mapCommentListCreateReplyToState(event) async* {
    try {
      if (currentState is CommentListFetchSuccessed) {
        print('event');
        print(event.session);
        print(event.content);
        print(event.commentTo);
        print(event.replyTo);

        final QueryResult res = await client.mutate(
          MutationOptions(
            document: createCommentSchema,
            variables: {
              'session': event.session,
              'content': event.content,
              'commentTo': event.commentTo,
              'replyTo': event.replyTo
            },
          ),
        );

        print('res');
        print(res);

        if (res.hasErrors) return;

        var result = res.data['result'];

        if (result['status'] == 200) {
          final _list = (currentState as CommentListFetchSuccessed).list;

          // 评论回复
          if (event.commentTo != '') {
            print('评论回复成功');
            final List<Item> newList = List<Item>.from(_list).map((i) {
              if (i.id == event.commentTo) {
                var sas = result['data'];
                print(sas);
                return i.pushReply(reply: getReplyItem(result['data']));
              }
              return i;
            }).toList();

            yield CommentListFetchSuccessed(list: newList, session: event.session);
            return;
          }

          print('评论成功');

          final list = [
            getCommentItem(result['data'])
          ];

          yield CommentListFetchSuccessed(list: list + _list, session: event.session);
        } else if (result['status'] == 403) {
          print('尚未登录');

          alert(
            context: event.context,
            title: '评论失败',
            content: result['message'],
            showCancel: false,
          );
        }
      }
    } catch (error) {
      print('_mapCommentListFetchToState error');
      print(error);
      yield CommentListFetchError();
    }
  }
}
