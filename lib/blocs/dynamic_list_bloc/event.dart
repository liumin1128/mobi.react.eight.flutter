import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DynamicListEvent extends Equatable {
  DynamicListEvent([List props = const []]) : super(props);
}

class DynamicListFetch extends DynamicListEvent {
  @override
  String toString() => 'DynamicListFetch';
}

class DynamicListFetchMore extends DynamicListEvent {
  // final BuildContext context;

  // DynamicListFetchMore({@required this.context})
  //     : super([
  //         context
  //       ]);

  @override
  String toString() => 'DynamicListFetchMore';
}
