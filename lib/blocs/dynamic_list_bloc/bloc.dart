import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:eight/graphql/schema/dynamic.dart';
import 'index.dart';

class DynamicListBloc extends Bloc<DynamicListEvent, DynamicListState> {
  final GraphQLClient client;

  DynamicListBloc({@required this.client}) : assert(client != null);

  @override
  DynamicListState get initialState => Uninitialized();

  @override
  Stream<DynamicListState> mapEventToState(DynamicListEvent event) async* {
    // if (event is SaveToken) {
    //   dispatch(GetUserInfo(token: event.token));
    // }

    if (event is DynamicListFetch) {
      yield* _mapDynamicListFetchToState();
    } else if (event is DynamicListFetchMore) {
      yield* _mapDynamicListFetchMoreToState();
    } else if (event is DynamicListCreate) {
      yield* _mapDynamicListCreateToState(event);
    }
  }

  Stream<DynamicListState> _mapDynamicListFetchToState() async* {
    try {
      final QueryResult res = await client.mutate(MutationOptions(document: dynamicListSchema));

      if (res.hasErrors) return;

      var list = res.data['list'];

      yield DynamicListFetchSuccessed(list: list);
    } catch (_) {
      print('_mapLoggedInToState出错');
      yield DynamicListFetchError();
    }
  }

  Stream<DynamicListState> _mapDynamicListFetchMoreToState() async* {
    try {
      if (currentState is DynamicListFetchSuccessed) {
        final _list = (currentState as DynamicListFetchSuccessed).list;
        final skip = _list.length;
        print(skip);

        final QueryResult res = await client.mutate(
          MutationOptions(
            document: dynamicListSchema,
            variables: {
              'skip': skip,
            },
          ),
        );

        if (res.hasErrors) return;

        var list = res.data['list'];

        yield DynamicListFetchSuccessed(list: _list + list);
      }
    } catch (_) {
      print('_mapDynamicListFetchToState error');
      yield DynamicListFetchError();
    }
  }

  Stream<DynamicListState> _mapDynamicListCreateToState(event) async* {
    try {
      final QueryResult res = await client.mutate(MutationOptions(
        document: dynamicCreateSchema,
        variables: {
          'input': {
            'content': event.content,
            'pictures': event.pictures,
          }
        },
      ));

      print('res');
      print(res);
    } catch (_) {
      print('_mapDynamicListFetchToState error');
    }
  }
}
