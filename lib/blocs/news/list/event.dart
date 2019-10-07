import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewsListEvent extends Equatable {
  NewsListEvent();
  @override
  List<Object> get props => [];
}

class NewsListFetch extends NewsListEvent {}

class NewsListFetchMore extends NewsListEvent {}
