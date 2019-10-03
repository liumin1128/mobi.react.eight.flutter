import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DynamicListEvent extends Equatable {
  DynamicListEvent();
  @override
  List<Object> get props => [];
}

class DynamicListFetch extends DynamicListEvent {}

class DynamicListFetchMore extends DynamicListEvent {}

class DynamicListCreate extends DynamicListEvent {
  final BuildContext context;
  final String content;
  final List<String> pictures;

  DynamicListCreate({@required this.context, this.content, this.pictures});

  @override
  List<Object> get props => [context, content, pictures];
}
