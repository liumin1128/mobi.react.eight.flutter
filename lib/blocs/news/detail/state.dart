import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'index.dart';

@immutable
abstract class NewsDetailState extends Equatable {
  NewsDetailState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends NewsDetailState {}

class NewsDetailFetchError extends NewsDetailState {}

class NewsDetailFetchSuccessed extends NewsDetailState {
  final Item detail;

  NewsDetailFetchSuccessed({@required this.detail});

  @override
  List<Object> get props => [detail];
}
