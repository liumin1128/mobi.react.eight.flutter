import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DynamicDetailState extends Equatable {
  DynamicDetailState([List props = const []]) : super(props);
}

class Uninitialized extends DynamicDetailState {
  @override
  String toString() => 'Uninitialized';
}

class DynamicDetailFetchError extends DynamicDetailState {
  @override
  String toString() => 'DynamicDetailFetchError';
}

class DynamicDetailFetchSuccessed extends DynamicDetailState {
  final Map data;

  DynamicDetailFetchSuccessed({@required this.data})
      : super([
          data
        ]);

  @override
  String toString() => 'DynamicDetailFetchSuccessed { data: $data, }';
}
