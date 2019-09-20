import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BxgifDetailEvent extends Equatable {
  BxgifDetailEvent([List props = const []]) : super(props);
}

class BxgifDetailFetch extends BxgifDetailEvent {
  final String id;

  BxgifDetailFetch({@required this.id}) : super([id]);

  @override
  String toString() => 'BxgifDetailFetch';
}
