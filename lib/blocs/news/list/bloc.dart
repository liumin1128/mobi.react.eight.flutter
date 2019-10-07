import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:eight/graphql/schema/news.dart';
import 'index.dart';

class NewsListBloc extends Bloc<NewsListEvent, NewsListState> {
  final GraphQLClient client;

  NewsListBloc({@required this.client}) : assert(client != null);

  @override
  NewsListState get initialState => Uninitialized();

  @override
  Stream<NewsListState> mapEventToState(NewsListEvent event) async* {
    if (event is NewsListFetch) {
      yield* _mapNewsListFetchToState();
    } else if (event is NewsListFetchMore) {
      yield* _mapNewsListFetchMoreToState();
    }
  }

  Stream<NewsListState> _mapNewsListFetchToState() async* {
    try {
      final QueryResult res = await client.mutate(MutationOptions(document: newsListSchema));

      if (res.hasErrors) return;

      List<Item> list = List<Item>.from(
        res.data['list'].map((i) => Item.fromJson(i)).toList(),
      );

      yield NewsListFetchSuccessed(list: list);
    } catch (e) {
      print('_mapLoggedInToState出错');
      print(e);
      yield NewsListFetchError();
    }
  }

  Stream<NewsListState> _mapNewsListFetchMoreToState() async* {
    try {
      if (currentState is NewsListFetchSuccessed) {
        final _list = (currentState as NewsListFetchSuccessed).list;
        final skip = _list.length;

        final QueryResult res = await client.mutate(
          MutationOptions(
            document: newsListSchema,
            variables: {
              'skip': skip,
            },
          ),
        );

        if (res.hasErrors) return;

        List<Item> list = List<Item>.from(
          res.data['list'].map((i) => Item.fromJson(i)).toList(),
        );

        yield NewsListFetchSuccessed(list: _list + list);
      }
    } catch (_) {
      print('_mapNewsListFetchToState error');
      yield NewsListFetchError();
    }
  }
}
