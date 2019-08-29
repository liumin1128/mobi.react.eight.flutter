import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/blocs/comment_list_bloc/index.dart';
import 'package:eight/components/ListViewPro/index.dart';
import 'item.dart';

class CommentList extends StatefulWidget {
  final String session;

  CommentList({@required this.session}) : assert(session != null);

  @override
  _CommentListPageState createState() => _CommentListPageState();
}

class _CommentListPageState extends State<CommentList> {
  @override
  void initState() {
    super.initState();
    final commentListBloc = BlocProvider.of<CommentListBloc>(context);
    commentListBloc.dispatch(CommentListFetch(session: widget.session));
  }

  @override
  Widget build(BuildContext context) {
    final commentListBloc = BlocProvider.of<CommentListBloc>(context);
    return CupertinoPageScaffold(
      child: BlocBuilder<CommentListBloc, CommentListState>(
        builder: (context, state) {
          if (state is CommentListFetchSuccessed) {
            return Text(state.list[0]['content']);
          } else {
            return Text('loading');
          }
        },
      ),
    );
  }
}
