import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserState extends Equatable {
  UserState([List props = const []]) : super(props);
}

class Uninitialized extends UserState {
  @override
  String toString() => 'Uninitialized';
}

class Unauthenticated extends UserState {
  @override
  String toString() => 'Unauthenticated';
}

class Authenticated extends UserState {
  final String token;

  Authenticated(this.token)
      : super([
          token
        ]);

  @override
  String toString() => 'Authenticated { token: $token }';
}
