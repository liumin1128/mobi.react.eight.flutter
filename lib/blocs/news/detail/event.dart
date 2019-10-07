import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewsDetailEvent extends Equatable {
  NewsDetailEvent();
  @override
  List<Object> get props => [];
}

class NewsDetailFetch extends NewsDetailEvent {
  final String id;

  NewsDetailFetch({@required this.id});
}
