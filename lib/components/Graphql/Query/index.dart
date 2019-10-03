import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';

typedef BoolCallback = bool Function();
typedef FutureCallback = Future<void> Function();

typedef QueryBuilder = Widget Function(
  List list,
  bool loading, {
  FutureCallback refetch,
  FutureCallback fetchMore,
});

class QueryPro extends StatefulWidget {
  const QueryPro({
    final Key key,
    // @required this.options,
    @required this.builder,
    @required this.document,
  }) : super(key: key);

  // final QueryOptions options;
  final QueryBuilder builder;
  final document;

  @override
  _QueryProState createState() => _QueryProState();
}

class _QueryProState extends State<QueryPro> {
  @override
  Widget build(BuildContext context) {
    return GraphQLConsumer(builder: (GraphQLClient client) {
      return QueryProWidthClient(
        builder: widget.builder,
        document: widget.document,
        client: client,
      );
    });
  }
}

// QueryPro 默认的实例
class QueryProWidthClient extends StatefulWidget {
  const QueryProWidthClient({
    final Key key,
    // @required this.options,
    @required this.builder,
    @required this.document,
    @required this.client,
  }) : super(key: key);

  // final QueryOptions options;
  final QueryBuilder builder;
  final client;
  final document;

  @override
  _QueryProWidthClientState createState() => _QueryProWidthClientState();
}

// QueryProWidthClient 默认的实例,有状态
class _QueryProWidthClientState extends State<QueryProWidthClient> {
  int page = 5;
  int first = 20;
  bool loading = false;
  List<dynamic> list = [];
  final StreamController _streamController = StreamController();

  Future<void> _fetchMore() async {
    loading = true;
    page = page += 1;
    _streamController.sink.add(loading);

    final QueryResult res = await widget.client.mutate(
      MutationOptions(
        document: widget.document,
        variables: {'skip': page * first, 'first': first},
      ),
    );
    loading = false;
    if (res.hasErrors) return;
    list = list..addAll(res.data['list']);
    _streamController.sink.add(loading);
    _streamController.sink.add(list);
  }

  Future<void> _refresh() async {
    page = 0;
    loading = true;
    _streamController.sink.add(loading);
    print('11111');
    // await Future<void>.delayed(const Duration(seconds: 5));
    final QueryResult res = await widget.client.mutate(
      MutationOptions(
        document: widget.document,
        variables: {'skip': page * first, 'first': first},
      ),
    );
    print('22222');
    loading = false;
    if (res.hasErrors) return;
    list = res.data['list'];
    _streamController.sink.add(loading);
    _streamController.sink.add(list);
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // initialData: _streamController?.latestResult ?? QueryResult(loading: true),
      stream: _streamController.stream,
      builder: (
        BuildContext buildContext,
        AsyncSnapshot snapshot,
      ) {
        return widget?.builder(list, loading, refetch: _refresh, fetchMore: _fetchMore);
      },
    );
  }
}
