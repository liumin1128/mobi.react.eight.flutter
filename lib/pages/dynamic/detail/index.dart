import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/blocs/dynamic_detail_bloc/index.dart';
import 'package:eight/blocs/comment_list_bloc/index.dart';
// import 'package:eight/components/ListViewPro/index.dart';
import 'package:eight/components/Avatar/index.dart';
import 'package:eight/components/MultiPicturesView/index.dart';
import 'package:eight/container/comment/list/index.dart';
// import 'package:eight/container/comment/list/item.dart';
// import 'item.dart';

class DynamicDetailPage extends StatefulWidget {
  @override
  DynamicDetailPageState createState() => DynamicDetailPageState();
}

class DynamicDetailPageState extends State<DynamicDetailPage> {
  ScrollController _scrollController = ScrollController(); //listview的控制器

  @override
  void initState() {
    super.initState();

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
    final dynamicDetailBloc = BlocProvider.of<DynamicDetailBloc>(context);
    dynamicDetailBloc.dispatch(DynamicDetailFetch(id: '5d2d0527609ab51adc5b65ea'));

    // final commetListBloc = BlocProvider.of<CommentListBloc>(context);
    // commetListBloc.dispatch(CommentListFetch(session: '5d2d0527609ab51adc5b65ea'));
  }

  @override
  Widget build(BuildContext context) {
    // final dynamicDetailBloc = BlocProvider.of<DynamicDetailBloc>(context);
    return BlocBuilder<DynamicDetailBloc, DynamicDetailState>(
      builder: (context, state) {
        if (state is DynamicDetailFetchSuccessed) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              // backgroundColor: CupertinoColors.white,
              border: Border(
                top: BorderSide(
                  style: BorderStyle.none,
                ),
              ),
              // leading: CupertinoNavigationBarBackButton(), // 需要可pop
              middle: Text(
                state.data['user']['nickname'],
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: new TextStyle(
                  fontSize: 20,
                ),
              ),
              trailing: Avatar(src: state.data['user']['avatarUrl'], size: 30),
            ),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                CupertinoSliverRefreshControl(onRefresh: _onRefresh),
                // 内容
                SliverSafeArea(
                  sliver: SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(children: <Widget>[
                            Text(state.data['content']),
                            Padding(padding: EdgeInsets.all(8)),
                            state.data['pictures'].length > 0 ? multiPictureView(state.data['pictures']) : Container(),
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                CommentList(
                  session: state.data['_id'],
                )
                // 评论
              ],
            ),
          );
        } else {
          return CupertinoActivityIndicator();
        }
      },
    );
  }
}
