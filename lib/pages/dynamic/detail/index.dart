import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/blocs/dynamic_detail_bloc/index.dart';
import 'package:eight/components/ListViewPro/index.dart';
import 'package:eight/components/Avatar/index.dart';
import 'package:eight/components/MultiPicturesView/index.dart';
import 'package:eight/container/comment/list/index.dart';
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
    final dynamicListBloc = BlocProvider.of<DynamicDetailBloc>(context);
    dynamicListBloc.dispatch(DynamicDetailFetch(id: '5d66017f13b71b52f7f5a95b'));

    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        final dynamicListBloc = BlocProvider.of<DynamicDetailBloc>(context);
        dynamicListBloc.dispatch(DynamicDetailFetch(id: '5d66017f13b71b52f7f5a95b'));
      }
    });
  }

  Future<Null> _onRefresh() async {
    final dynamicListBloc = BlocProvider.of<DynamicDetailBloc>(context);
    dynamicListBloc.dispatch(DynamicDetailFetch(id: '5d66017f13b71b52f7f5a95b'));
  }

  @override
  Widget build(BuildContext context) {
    final dynamicListBloc = BlocProvider.of<DynamicDetailBloc>(context);
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
                physics: ScrollPhysics(),
                slivers: <Widget>[
                  CupertinoSliverRefreshControl(onRefresh: _onRefresh),
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
                              multiPictureView(state.data['pictures']),
                              CommentList(session: state.data['_id'])
                            ]),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ));
        } else {
          return CupertinoActivityIndicator();
        }
      },
    );
  }
}
