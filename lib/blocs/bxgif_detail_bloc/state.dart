import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BxgifDetailState extends Equatable {
  BxgifDetailState([List props = const []]) : super(props);
}

class Uninitialized extends BxgifDetailState {
  @override
  String toString() => 'Uninitialized';
}

class BxgifDetailFetchError extends BxgifDetailState {
  @override
  String toString() => 'BxgifDetailFetchError';
}

class BxgifDetailFetchSuccessed extends BxgifDetailState {
  final Map data;

  BxgifDetailFetchSuccessed({@required this.data}) : super([data]);

  @override
  String toString() => 'BxgifDetailFetchSuccessed { data: $data, }';
}
