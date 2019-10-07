import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
// blocs
import 'package:eight/blocs/theme_bloc.dart';
// import 'package:eight/blocs/user_bloc/index.dart';
import 'package:eight/blocs/dynamic_list/index.dart';
import 'package:eight/blocs/news/list/index.dart';
import 'package:eight/blocs/news/detail/index.dart';
import 'package:eight/blocs/user/index.dart';
// import 'package:eight/blocs/comment_list_bloc/index.dart';
// pages
import 'package:eight/pages/home/index.dart';
import 'package:eight/pages/news/detail/index.dart';
// import 'package:eight/pages/user/index.dart';
// import 'package:eight/pages/dynamic/list/index.dart';
// import 'package:eight/pages/dynamic/create/index.dart';
import 'package:eight/pages/user/login/phone/index.dart';
import 'package:eight/pages/user/login/username/index.dart';

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
      child: GraphQLConsumer(
        builder: (GraphQLClient client) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<ThemeBloc>(builder: (context) => ThemeBloc()),
              BlocProvider<UserBloc>(builder: (context) => UserBloc(client: client)..dispatch(AppStarted())),
              BlocProvider<DynamicListBloc>(builder: (context) => DynamicListBloc(client: client)),
              BlocProvider<NewsListBloc>(builder: (context) => NewsListBloc(client: client)),
              BlocProvider<NewsDetailBloc>(builder: (context) => NewsDetailBloc(client: client)),
              // BlocProvider<DynamicDetailBloc>(builder: (context) => DynamicDetailBloc(client: client)),
              // BlocProvider<CommentListBloc>(builder: (context) => CommentListBloc(client: client)),
            ],
            child: BlocBuilder<ThemeBloc, CupertinoThemeData>(
              builder: (context, theme) {
                return CupertinoApp(
                  theme: theme,
                  routes: <String, WidgetBuilder>{
                    '/': (BuildContext context) => HomePage(),
                    '/user/login/phone': (BuildContext context) => UserPhoneLogin(),
                    '/user/login/password': (BuildContext context) => UserPasswordLogin(),
                    // '/dynamic/create': (BuildContext context) => DynamicCreatePage(),
                    // '/dynamic/detail': (BuildContext context) {
                    //   final Map query = ModalRoute.of(context).settings.arguments;
                    //   return DynamicDetailPage(session: query['session']);
                    // },
                    '/news/detail': (BuildContext context) {
                      final Map query = ModalRoute.of(context).settings.arguments;
                      return NewsDetailPage(id: query['id']);
                    },
                  },
                  initialRoute: '/',
                );
              },
            ),
          );
        },
      ),
    );
  }
}
