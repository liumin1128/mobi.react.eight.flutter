import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:eight/graphql/schema/dynamic.dart';
import 'index.dart';

class DynamicDetailBloc extends Bloc<DynamicDetailEvent, DynamicDetailState> {
  final GraphQLClient client;

  DynamicDetailBloc({@required this.client}) : assert(client != null);

  @override
  DynamicDetailState get initialState => Uninitialized();

  @override
  Stream<DynamicDetailState> mapEventToState(DynamicDetailEvent event) async* {
    if (event is DynamicDetailFetch) {
      yield* _mapDynamicDetailFetchToState(event);
    }
  }

  Stream<DynamicDetailState> _mapDynamicDetailFetchToState(event) async* {
    try {
      print('event.id');
      print(event.id);

      final QueryResult res = await client.mutate(MutationOptions(document: dynamicDetailSchema, variables: {
        '_id': event.id
      }));

      if (res.hasErrors) return;

      var data = res.data['data'];

      print('data');
      print(data);

      yield DynamicDetailFetchSuccessed(data: data);
    } catch (_) {
      print('_mapLoggedInToState出错');
      yield Unauthenticated();
    }
  }
}
