import 'package:flutter/material.dart';
import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:graphql/internal.dart';
import '../../../graphql/schema/news.dart';

typedef BoolCallback = bool Function();
typedef FutureCallback = Future<Null> Function();

typedef QueryBuilder = Widget Function(
  List list, 
  bool loading,
  {
    FutureCallback refetch,
    FutureCallback fetchMore,
  }
);

class QueryPro extends StatefulWidget {
  const QueryPro({
    final Key key,
    // @required this.options,
    @required this.builder,
  }) : super(key: key);

  // final QueryOptions options;
  final QueryBuilder builder;

  @override
  _QueryProState createState() => _QueryProState();
}


class _QueryProState extends State<QueryPro> {
  @override
  Widget build(BuildContext context) {
    return GraphQLConsumer(
      builder: (GraphQLClient client) {
        return QueryProWidthClient(
          // options: widget.options,
          builder: widget.builder,
          client: client,
        );
      }
    );
  }
}


// QueryPro 默认的实例
class QueryProWidthClient extends StatefulWidget {
  const QueryProWidthClient({
    final Key key,
    // @required this.options,
    @required this.builder,
    @required this.client,
  }) : super(key: key);

  // final QueryOptions options;
  final QueryBuilder builder;
  final client;

  @override
  _QueryProWidthClientState createState() => _QueryProWidthClientState();
}

// QueryProWidthClient 默认的实例,有状态
class _QueryProWidthClientState extends State<QueryProWidthClient> {
  int page = 0;
  int first = 10;
  bool loading = false;
  List<dynamic> list = [];
  final StreamController _streamController = StreamController();

  Future<Null> _fetchMore() async {
    loading = true;
    page = page += 1;
    _streamController.sink.add(loading);
    
    final QueryResult res = await widget.client.mutate(
      MutationOptions(
        document: newsSchema,
        variables: {
          'skip': page * first,
          'first': first
        },
      ),
    );
    loading = false;
    if(res.hasErrors) return;
    list = list..addAll(res.data['list']);
    _streamController.sink.add(loading);
    _streamController.sink.add(list);
  }

  Future<Null> _refresh() async {
    page = 0;
    loading = true;
    _streamController.sink.add(loading);
    final QueryResult res = await widget.client.mutate(
      MutationOptions(
        document: newsSchema,
        variables: {
          'skip': page * first,
          'first': first
        },
      ),
    );
    loading = false;
    if(res.hasErrors) return;
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
        return widget?.builder(list, loading, refetch: _refresh, fetchMore: _fetchMore );
      },
    );
  }
}
