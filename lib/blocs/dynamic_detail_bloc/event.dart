import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DynamicDetailEvent extends Equatable {
  DynamicDetailEvent([List props = const []]) : super(props);
}

class DynamicDetailFetch extends DynamicDetailEvent {
  final String id;

  DynamicDetailFetch({@required this.id})
      : super([
          id
        ]);

  @override
  String toString() => 'DynamicDetailFetch';
}
