import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:eight/graphql/schema/bxgif.dart';
import 'index.dart';

class BxgifDetailBloc extends Bloc<BxgifDetailEvent, BxgifDetailState> {
  final GraphQLClient client;

  BxgifDetailBloc({@required this.client}) : assert(client != null);

  @override
  BxgifDetailState get initialState => Uninitialized();

  @override
  Stream<BxgifDetailState> mapEventToState(BxgifDetailEvent event) async* {
    if (event is BxgifDetailFetch) {
      yield* _mapBxgifDetailFetchToState(event);
    }
  }

  Stream<BxgifDetailState> _mapBxgifDetailFetchToState(event) async* {
    try {
      final QueryResult res = await client.mutate(
        MutationOptions(
          document: bxgifDetailSchema,
          variables: {
            '_id': event.id,
          },
        ),
      );

      if (res.hasErrors) return;

      var data = res.data['data'];

      yield BxgifDetailFetchSuccessed(data: data);
    } catch (_) {
      print('_mapLoggedInToState出错');
      yield BxgifDetailFetchError();
    }
  }
}
