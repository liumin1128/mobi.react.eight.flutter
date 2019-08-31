import 'package:flutter/cupertino.dart' hide Action;
import 'dart:ui' show ImageFilter;
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
  TextEditingController _contentTextEditingController;
  FocusNode focusNodePhone = new FocusNode();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {}
    });

    _contentTextEditingController = TextEditingController(text: '111');

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
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                // 触摸收起键盘
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Stack(
                children: <Widget>[
                  CustomScrollView(
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
                      ),
                      CupertinoSliverNavigationBar(
                        largeTitle: Text('widget.title'),
                        middle: Stack(
                          children: <Widget>[
                            Avatar(src: state.data['user']['avatarUrl'], size: 30),
                          ],
                        ),
                      ),
                      // 评论
                    ],
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            // color: CupertinoTheme.of(context).barBackgroundColor,
                            // // color: Color(0xCCF8F8F8),
                            // // color: Color(0xeeffffff),
                            border: Border(
                              top: BorderSide(
                                style: BorderStyle.solid,
                                color: Color(0x33000000),
                              ),
                            ),
                          ),
                          child: Container(
                            // padding: EdgeInsets.all(16),
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: CupertinoTextField(
                                    padding: EdgeInsets.all(16),
                                    maxLines: 4,
                                    minLines: 1,
                                    controller: _contentTextEditingController,
                                    placeholder: '发表评论',
                                    placeholderStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 17,
                                      // height: 0.7,
                                      color: CupertinoColors.inactiveGray,
                                    ),
                                    style: TextStyle(
                                      fontSize: 20,
                                      // height: 1.2,
                                      color: CupertinoColors.black,
                                    ),
                                    decoration: BoxDecoration(
                                      // border: Border.all(
                                      //   style: BorderStyle.solid,
                                      //   color: Color(0x10000000),
                                      // ),
                                      // border: Border(
                                      //   top: BorderSide(
                                      //     style: BorderStyle.solid,
                                      //     color: Color(0x10000000),
                                      //   ),
                                      // ),
                                      // color: Color(0xffffffff),
                                      color: CupertinoTheme.of(context).barBackgroundColor,

                                      // borderRadius: BorderRadius.circular(4),
                                    ),
                                    onChanged: (str) {
                                      print(str);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return CupertinoPageScaffold(child: CupertinoActivityIndicator());
        }
      },
    );
  }
}
