import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:eight/graphql/schema/notification.dart';
import 'index.dart';

class NotificationListBloc extends Bloc<NotificationListEvent, NotificationListState> {
  final GraphQLClient client;

  NotificationListBloc({@required this.client}) : assert(client != null);

  @override
  NotificationListState get initialState => Uninitialized();

  @override
  Stream<NotificationListState> mapEventToState(NotificationListEvent event) async* {
    if (event is NotificationListFetch) {
      yield* _mapNotificationListFetchToState();
    } else if (event is NotificationListFetchMore) {
      yield* _mapNotificationListFetchMoreToState();
    }
  }

  Stream<NotificationListState> _mapNotificationListFetchToState() async* {
    try {
      final QueryResult res = await client.mutate(MutationOptions(document: notificationListSchema));

      if (res.hasErrors) return;

      List<Item> list = List<Item>.from(
        res.data['list'].map((i) => Item.fromJson(i)).toList(),
      );

      yield NotificationListFetchSuccessed(list: list);
    } catch (e) {
      print('_mapLoggedInToState出错');
      print(e);
      yield NotificationListFetchError();
    }
  }

  Stream<NotificationListState> _mapNotificationListFetchMoreToState() async* {
    try {
      if (currentState is NotificationListFetchSuccessed) {
        final _list = (currentState as NotificationListFetchSuccessed).list;
        final skip = _list.length;

        final QueryResult res = await client.mutate(
          MutationOptions(
            document: notificationListSchema,
            variables: {
              'skip': skip,
            },
          ),
        );

        if (res.hasErrors) return;

        List<Item> list = List<Item>.from(
          res.data['list'].map((i) => Item.fromJson(i)).toList(),
        );

        yield NotificationListFetchSuccessed(list: _list + list);
      }
    } catch (_) {
      print('_mapNotificationListFetchToState error');
      yield NotificationListFetchError();
    }
  }
}
