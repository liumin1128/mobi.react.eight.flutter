import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
// enum ThemeEvent { toggle }

abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const []]) : super(props);
}

final Map<String, CupertinoThemeData> themes = {
  'dark': CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF000000),
  ),
  'light': CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFFfd4c86),
  )
};

class SetTheme extends ThemeEvent {
  final String theme;

  SetTheme({@required this.theme})
      : super([
          theme
        ]);

  @override
  String toString() => 'SetTheme { token: $theme }';
}

class ThemeBloc extends Bloc<ThemeEvent, CupertinoThemeData> {
  @override
  CupertinoThemeData get initialState => themes['light'];

  @override
  Stream<CupertinoThemeData> mapEventToState(ThemeEvent event) async* {
    if (event is SetTheme) {
      yield event.theme == 'dark' ? themes['light'] : themes['dart'];
    }
  }
}
