import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:reactmobi/blocs/theme_bloc.dart';
import 'package:reactmobi/blocs/counter_bloc.dart';
import 'package:reactmobi/pages/home/index.dart';

class App extends StatefulWidget {
  App({this.client});
  final client;
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: widget.client,
      child: BlocProvider<ThemeBloc>(
        builder: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, CupertinoThemeData>(
          builder: (context, theme) {
            return BlocProvider<CounterBloc>(
              builder: (context) => CounterBloc(),
              child: CupertinoApp(
                theme: theme,
                routes: <String, WidgetBuilder>{
                  '/': (BuildContext context) => HomePage(),
                  // '/login': (BuildContext context) => UserLogin(),
                  // '/register': (BuildContext context) => UserLogin(),
                },
                initialRoute: '/',
              ),
            );
          },
        ),
      ),
    );
  }
}

// class CounterPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final counterBloc = BlocProvider.of<CounterBloc>(context);
//     final themeBloc = BlocProvider.of<ThemeBloc>(context);

//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         middle: Text("动态"),
//         border: Border(
//           top: BorderSide(
//             style: BorderStyle.none,
//           ),
//         ),
//         leading: GestureDetector(
//           onTap: () {
//             counterBloc.dispatch(CounterEvent.increment);
//           },
//           child: Icon(CupertinoIcons.bell),
//         ),
//         trailing: GestureDetector(
//           onTap: () {
//             themeBloc.dispatch(SetTheme(theme: 'dark1'));
//           },
//           child: Icon(CupertinoIcons.bell),
//         ),
//         // trailing: Icon(CupertinoCupertinoIcons.add)
//         // backgroundColor: Colors.white,
//       ),
//       // child: Center(
//       //   child: Text('1111'),
//       // ),
//       child: Center(
//         child: BlocBuilder<CounterBloc, int>(
//           builder: (context, count) {
//             return Center(
//               child: Text(
//                 '$count',
//                 style: TextStyle(fontSize: 24.0),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
