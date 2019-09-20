import 'package:flutter/cupertino.dart' hide Action;
// import 'dart:ui' show ImageFilter;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/blocs/bxgif_detail_bloc/index.dart';
// import 'package:eight/blocs/comment_list_bloc/index.dart';
// // import 'package:eight/components/ListViewPro/index.dart';
// import 'package:eight/components/Avatar/index.dart';
// import 'package:eight/components/MultiPicturesView/index.dart';
// import 'package:eight/container/comment/list/index.dart';
// // import 'package:eight/container/comment/list/item.dart';
// // import 'item.dart';

class BxgifDetailPage extends StatefulWidget {
  final String id;
  BxgifDetailPage({Key key, this.id}) : super(key: key);

  @override
  BxgifDetailPageState createState() => BxgifDetailPageState();
}

class BxgifDetailPageState extends State<BxgifDetailPage> {
  ScrollController _scrollController = ScrollController(); //listview的控制器

  @override
  void initState() {
    super.initState();

    // final bxgifListBloc = BlocProvider.of<BxgifListBloc>(context);
    // bxgifListBloc.dispatch(BxgifListFetch());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {}
    });

    _onRefresh();
  }

  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<Null> _onRefresh() async {
    final bxgifDetailBloc = BlocProvider.of<BxgifDetailBloc>(context);
    bxgifDetailBloc.dispatch(BxgifDetailFetch(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    // final bxgifDetailBloc = BlocProvider.of<BxgifDetailBloc>(context);
    return BlocBuilder<BxgifDetailBloc, BxgifDetailState>(
      builder: (context, state) {
        if (state is BxgifDetailFetchSuccessed && widget.id == state.data['_id']) {
          return CupertinoPageScaffold(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: Text(state.data['title'].substring(14)),
                  border: Border(
                    top: BorderSide(
                      style: BorderStyle.none,
                    ),
                  ),
                ),
                CupertinoSliverRefreshControl(onRefresh: _onRefresh),
                // 内容
                SliverSafeArea(
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(state.data['title'])
                          // Text(state.data['content']),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return CupertinoPageScaffold(child: Center(child: CupertinoActivityIndicator()));
        }
      },
    );
  }
}
