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
    return BlocBuilder<CommentListBloc, CommentListState>(
      builder: (context, state) {
        if (state is CommentListFetchSuccessed) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return Padding(
                  padding: EdgeInsets.all(64),
                  child: Text(state.list[index]['content']),
                );
              },
              childCount: state.list.length,
            ),
          );
          // CupertinoButton(
          //   child: Text('more'),
          //   onPressed: () {
          //     commentListBloc.dispatch(CommentListFetchMore());
          //   },
          // )
        } else {
          return SliverSafeArea(
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(children: <Widget>[
                      Text('评论加载中'),
                      Padding(padding: EdgeInsets.all(8)),
                      // state.data['pictures'].length > 0 ? multiPictureView(state.data['pictures']) : null,
                    ]),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}