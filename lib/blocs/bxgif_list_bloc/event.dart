import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BxgifListEvent extends Equatable {
  BxgifListEvent([List props = const []]) : super(props);
}

class BxgifListFetch extends BxgifListEvent {
  @override
  String toString() => 'BxgifListFetch';
}

class BxgifListFetchMore extends BxgifListEvent {
  @override
  String toString() => 'BxgifListFetchMore';
}
