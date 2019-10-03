import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
// enum ThemeEvent { toggle }

abstract class ThemeEvent extends Equatable {
  ThemeEvent();
  @override
  List<Object> get props => [];
}

final Map<String, CupertinoThemeData> themes = {
  'dark': CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF000000),
    // textTheme: CupertinoTextThemeData(testStyle: )
  ),
  'light': CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFfd4c86),
  )
};

class SetTheme extends ThemeEvent {
  final String theme;

  SetTheme({@required this.theme});

  @override
  String toString() => 'SetTheme { token: $theme }';
}

class ThemeBloc extends Bloc<ThemeEvent, CupertinoThemeData> {
  @override
  CupertinoThemeData get initialState => themes['light'];

  @override
  Stream<CupertinoThemeData> mapEventToState(ThemeEvent event) async* {
    if (event is SetTheme) {
      yield event.theme == 'dark' ? themes['light'] : themes['dark'];
    }
  }
}
