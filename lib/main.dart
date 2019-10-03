import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:eight/utils/graphql.dart';
import 'package:eight/blocs/delegate.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'app.dart';

main() {
  final client = getClient();
  final ValueNotifier<GraphQLClient> valueNotifier = ValueNotifier(client);
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App(client: valueNotifier));
}
