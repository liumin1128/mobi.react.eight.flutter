import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NotificationListEvent extends Equatable {
  NotificationListEvent();
  @override
  List<Object> get props => [];
}

class NotificationListFetch extends NotificationListEvent {}

class NotificationListFetchMore extends NotificationListEvent {}
