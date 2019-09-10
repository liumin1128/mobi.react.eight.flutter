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
  @override
  String toString() => 'DynamicListFetchMore';
}

class DynamicListCreate extends DynamicListEvent {
  final BuildContext context;
  final String content;
  final List<String> pictures;

  DynamicListCreate({
    @required this.context,
    this.content,
    this.pictures,
  }) : super([
          context,
          content,
          pictures,
        ]);

  @override
  String toString() => 'DynamicListFetchMore';
}
