import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:eight/graphql/schema/comment.dart';
import 'index.dart';
// import 'package:eight/utils/action.dart';

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
    try {
      final QueryResult res = await client.mutate(
        MutationOptions(document: commentListSchema, variables: {
          'session': event.session,
          'first': 10
        }),
      );

      if (res.hasErrors) return;

      var list = res.data['list'];

      List<Item> _comments = [];

      list.map((i) {
        List<Item> _replys = [];

        for (int jdx = 0; jdx < i['replys'].length; jdx++) {
          final temp = i['replys'][jdx];

          _replys.add(Item(
            id: temp['_id'],
            session: temp['session'],
            content: temp['content'],
            zanCount: temp['zanCount'],
            zanStatus: temp['zanStatus'],
            replyCount: temp['replyCount'],
            user: temp['user'],
          ));
        }

        _comments.add(Item(
          id: i['_id'],
          session: i['session'],
          content: i['content'],
          zanCount: i['zanCount'],
          zanStatus: i['zanStatus'],
          replyCount: i['replyCount'],
          user: i['user'],
          replys: _replys,
        ));
      }).toList();

      yield CommentListFetchSuccessed(list: _comments, session: event.session);
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
              'first': 10
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

  Stream<CommentListState> _mapCommentListCreateCommentToState(event) async* {
    try {
      if (currentState is CommentListFetchSuccessed) {
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

        if (res.hasErrors) return;

        var result = res.data['result'];

        if (result['status'] == 200) {
          final _list = (currentState as CommentListFetchSuccessed).list;
          print('event.commentTo');
          print(event.commentTo);

          if (event.commentTo != '') {
            print('idx11111111111');

            final newReply = Item(
              id: result['data']['_id'],
              session: result['data']['session'],
              content: result['data']['content'],
              zanCount: result['data']['zanCount'],
              zanStatus: result['data']['zanStatus'],
              replyCount: result['data']['replyCount'],
              user: result['data']['user'],
            );

            final List<Item> newList = List<Item>.from(_list).map((i) {
              if (i.id == event.commentTo) {
                return i.pushReply(reply: newReply);
              }
              return i;
            }).toList();

            yield CommentListFetchSuccessed(list: newList, session: event.session);
            return;
          }

          print('评论成功');

          final list = [
            result['data']
          ];

          yield CommentListFetchSuccessed(list: list + _list, session: event.session);
        } else {
          // alert(
          //   context: '评论失败',
          //   title: '验证码错误',
          //   content: '验证码格式不正确，请重新输入',
          // );
        }
      }
    } catch (error) {
      print('_mapCommentListFetchToState error');
      print(error);
      yield CommentListFetchError();
    }
  }
}
