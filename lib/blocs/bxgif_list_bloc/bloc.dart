import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:eight/graphql/schema/bxgif.dart';
// import 'package:eight/utils/index.dart';
import 'index.dart';

class BxgifListBloc extends Bloc<BxgifListEvent, BxgifListState> {
  final GraphQLClient client;

  BxgifListBloc({@required this.client}) : assert(client != null);

  @override
  BxgifListState get initialState => Uninitialized();

  @override
  Stream<BxgifListState> mapEventToState(BxgifListEvent event) async* {
    // if (event is SaveToken) {
    //   dispatch(GetUserInfo(token: event.token));
    // }

    if (event is BxgifListFetch) {
      yield* _mapBxgifListFetchToState();
    } else if (event is BxgifListFetchMore) {
      yield* _mapBxgifListFetchMoreToState();
      // } else if (event is BxgifListCreate) {
      //   yield* _mapBxgifListCreateToState(event);
    }
  }

  Stream<BxgifListState> _mapBxgifListFetchToState() async* {
    try {
      final QueryResult res = await client.mutate(MutationOptions(document: bxgifListSchema));

      if (res.hasErrors) return;

      var list = res.data['list'];

      yield BxgifListFetchSuccessed(list: list);
    } catch (_) {
      print('_mapLoggedInToState出错');
      yield BxgifListFetchError();
    }
  }

  Stream<BxgifListState> _mapBxgifListFetchMoreToState() async* {
    try {
      if (currentState is BxgifListFetchSuccessed) {
        final _list = (currentState as BxgifListFetchSuccessed).list;
        final skip = _list.length;
        print(skip);

        final QueryResult res = await client.mutate(
          MutationOptions(
            document: bxgifListSchema,
            variables: {
              'skip': skip,
            },
          ),
        );

        if (res.hasErrors) return;

        var list = res.data['list'];

        yield BxgifListFetchSuccessed(list: _list + list);
      }
    } catch (_) {
      print('_mapBxgifListFetchToState error');
      yield BxgifListFetchError();
    }
  }
}
