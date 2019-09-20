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
      final QueryResult res = await client.mutate(
        MutationOptions(
          document: bxgifListSchema,
          variables: {
            'first': 10,
          },
        ),
      );

      if (res.hasErrors) return;

      var _temp = res.data['list'];

      List<Item> _list = [];
      for (var i = 0; i < _temp.length; i++) {
        print('$i');
        _list.add(getItem(_temp[i]));
      }

      yield BxgifListFetchSuccessed(list: _list);
    } catch (e) {
      print('BxgifListFetch出错');
      print(e);
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
              'first': 10,
            },
          ),
        );

        if (res.hasErrors) return;

        var _temp = res.data['list'];

        List<Item> _newlist = [];
        for (var i = 0; i < _temp.length; i++) {
          _newlist.add(getItem(_temp[i]));
        }

        yield BxgifListFetchSuccessed(list: _list + _newlist);
      }
    } catch (_) {
      print('_mapBxgifListFetchToState error');
      yield BxgifListFetchError();
    }
  }
}
