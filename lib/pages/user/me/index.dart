import 'package:flutter/cupertino.dart';
import 'package:reactmobi/blocs/counter_bloc.dart';
import 'package:reactmobi/blocs/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    final themeBloc = BlocProvider.of<ThemeBloc>(context);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("用户"),
        border: Border(
          top: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            counterBloc.dispatch(CounterEvent.increment);
          },
          child: Icon(CupertinoIcons.bell),
        ),
        trailing: GestureDetector(
          onTap: () {
            themeBloc.dispatch(SetTheme(theme: 'dark1'));
          },
          child: Icon(CupertinoIcons.bell),
        ),
        // trailing: Icon(CupertinoCupertinoIcons.add)
        // backgroundColor: Colors.white,
      ),
      // child: Center(
      //   child: Text('1111'),
      // ),
      child: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, count) {
            return Center(
              child: Text(
                '$count',
                style: TextStyle(fontSize: 24.0),
              ),
            );
          },
        ),
      ),
    );
  }
}
