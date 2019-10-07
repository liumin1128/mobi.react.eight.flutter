import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:eight/blocs/entities/index.dart';

@immutable
abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class Uninitialized extends UserState {}

class Unauthenticated extends UserState {}

class Authenticated extends UserState {
  final String token;
  final User userInfo;

  Authenticated({
    this.token,
    this.userInfo,
  });

  @override
  List<Object> get props => [userInfo];
}
