import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:eight/graphql/schema/news.dart';
import 'index.dart';

class NewsDetailBloc extends Bloc<NewsDetailEvent, NewsDetailState> {
  final GraphQLClient client;

  NewsDetailBloc({@required this.client}) : assert(client != null);

  @override
  NewsDetailState get initialState => Uninitialized();

  @override
  Stream<NewsDetailState> mapEventToState(NewsDetailEvent event) async* {
    if (event is NewsDetailFetch) {
      yield* _mapNewsDetailFetchToState(event);
    }
  }

  Stream<NewsDetailState> _mapNewsDetailFetchToState(event) async* {
    try {
      final QueryResult res = await client.mutate(
        MutationOptions(
          document: newsDetailSchema,
          variables: {
            '_id': event.id,
          },
        ),
      );

      if (res.hasErrors) return;

      yield NewsDetailFetchSuccessed(detail: Item.fromJson(res.data['data']));
    } catch (e) {
      print('NewsDetailFetchError');
      print(e);
      yield NewsDetailFetchError();
    }
  }
}
