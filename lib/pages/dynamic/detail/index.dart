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
  final String session;
  DynamicDetailPage({Key key, this.session}) : super(key: key);

  @override
  DynamicDetailPageState createState() => DynamicDetailPageState();
}

class DynamicDetailPageState extends State<DynamicDetailPage> {
  // dynamic obj = ModalRoute.of(context).settings.arguments;
  // if (obj != null && isNotEmpty(obj["name"])) {
  //   name = obj["name"];
  // }

  ScrollController _scrollController = ScrollController(); //listview的控制器
  TextEditingController _contentTextEditingController;
  FocusNode _contentFocusNode = FocusNode();

  String _placeholder = '发表评论';
  String _commentTo = '';
  String _replyTo = '';

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {}
    });

    _contentFocusNode.addListener(() {
      // print(_contentFocusNode.hasFocus);
      if (!_contentFocusNode.hasFocus) {
        setState(() {
          _placeholder = '发表评论';
          _commentTo = '';
          _replyTo = '';
        });
      }
    });

    // _contentTextEditingController = TextEditingController(text: '');

    _onRefresh();
  }

  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _contentFocusNode.dispose();
  }

  Future<Null> _onRefresh() async {
    final dynamicDetailBloc = BlocProvider.of<DynamicDetailBloc>(context);
    dynamicDetailBloc.dispatch(DynamicDetailFetch(id: widget.session));
  }

  Future<Null> _onSentComment(content) async {
    final commetListBloc = BlocProvider.of<CommentListBloc>(context);
    commetListBloc.dispatch(
      CommentListCreateComment(
        context: context,
        session: widget.session,
        content: content,
        commentTo: _commentTo,
        replyTo: _replyTo,
      ),
    );
    _contentTextEditingController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    // final dynamicDetailBloc = BlocProvider.of<DynamicDetailBloc>(context);
    return BlocBuilder<DynamicDetailBloc, DynamicDetailState>(
      builder: (context, state) {
        if (state is DynamicDetailFetchSuccessed && widget.session == state.data['_id']) {
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
                style: TextStyle(
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
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(state.data['content']),
                                Padding(padding: EdgeInsets.all(8)),
                                state.data['pictures'].length > 0 ? multiPictureView(state.data['pictures']) : Container(),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 16),
                          child: Text('全部评论', style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ),
                      CommentList(
                        session: state.data['_id'],
                        onItemPressed: (comment, reply) {
                          var _nickname = reply != null ? reply.user.nickname : comment.user.nickname;
                          setState(() {
                            _placeholder = '回复：$_nickname';
                            _commentTo = comment.id;
                            _replyTo = reply != null ? reply.id : comment.id;

                            FocusScope.of(context).requestFocus(_contentFocusNode);
                          });
                        },
                      ),
                      SliverSafeArea(
                        sliver: SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 64),
                            child: Text(''),
                          ),
                        ),
                      )
                      // CupertinoSliverNavigationBar(
                      //   largeTitle: Text('widget.title'),
                      //   middle: Stack(
                      //     children: <Widget>[
                      //       Avatar(src: state.data['user']['avatarUrl'], size: 30),
                      //     ],
                      //   ),
                      // ),
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: CupertinoTheme.of(context).barBackgroundColor,
                            // // color: Color(0xCCF8F8F8),
                            // // color: Color(0xeeffffff),
                            border: Border(
                              top: BorderSide(
                                style: BorderStyle.solid,
                                color: Color(0x11000000),
                              ),
                            ),
                          ),
                          child: Container(
                            // padding: EdgeInsets.all(8),
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: CupertinoTextField(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                    maxLines: 4,
                                    minLines: 1,
                                    focusNode: _contentFocusNode,
                                    controller: _contentTextEditingController,
                                    placeholder: _placeholder,
                                    textInputAction: TextInputAction.send,
                                    placeholderStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 17,
                                      // height: 0.7,
                                      color: CupertinoColors.inactiveGray,
                                    ),
                                    style: TextStyle(
                                      fontSize: 20,
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
                                      color: Color(0xffeeeeee),
                                      // color: CupertinoTheme.of(context).barBackgroundColor,

                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    onChanged: (str) {
                                      print(str);
                                    },
                                    onSubmitted: (text) {
                                      print('submit $text');
                                      _onSentComment(text);
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  margin: EdgeInsets.only(left: 8),
                                  child: Icon(
                                    CupertinoIcons.folder,
                                    color: Color(0xFF999999),
                                    size: 32,
                                  ),
                                )
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
          return CupertinoPageScaffold(child: Center(child: CupertinoActivityIndicator()));
        }
      },
    );
  }
}
