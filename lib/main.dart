import 'package:flutter/cupertino.dart';
import 'package:bloc/bloc.dart';
import 'package:eight/utils/graphql.dart';
import 'package:eight/blocs/delegate.dart';
import 'app.dart';

main() {
  final client = getClient();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(App(client: client));
}
