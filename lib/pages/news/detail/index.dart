import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/blocs/news/detail/index.dart';
import 'package:eight/components/Avatar/index.dart';
import 'package:eight/components/String2Html/index.dart';

// import 'item.dart';

class NewsDetailPage extends StatefulWidget {
  final String id;
  NewsDetailPage({Key key, this.id});

  @override
  NewsDetailPageState createState() => NewsDetailPageState();
}

class NewsDetailPageState extends State<NewsDetailPage> {
  bool loading;

  @override
  void initState() {
    super.initState();
    final newsDetailBloc = BlocProvider.of<NewsDetailBloc>(context);
    newsDetailBloc.dispatch(NewsDetailFetch(id: widget.id));

    setState(() {
      loading = true;
    });
    Future<void>.delayed(Duration(milliseconds: 500), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFFAFAFA),
      navigationBar: CupertinoNavigationBar(),
      child: BlocBuilder<NewsDetailBloc, NewsDetailState>(
        builder: (context, state) {
          if (state is NewsDetailFetchSuccessed && state.detail.id == widget.id && !loading) {
            final detail = state.detail;
            return CustomScrollView(
              slivers: <Widget>[
                SliverSafeArea(
                  bottom: false,
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      // color: Color(0xFF000000),
                      padding: EdgeInsets.all(16),
                      // decoration: BoxDecoration(
                      //   border: Border(
                      //     bottom: BorderSide(color: Color(0xFFdddddd), width: 0.5),
                      //   ),
                      // ),
                      // margin: EdgeInsets.all(16),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              detail.title,
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF333333),
                                  ),
                            ),
                            Padding(padding: EdgeInsets.all(4)),
                            Row(
                              children: <Widget>[
                                // 用户头像
                                Container(
                                  padding: EdgeInsets.only(right: 12),
                                  child: Avatar(
                                    placeholder: detail.appName,
                                    size: 48,
                                  ),
                                ),
                                // 用户信息
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        detail.appName,
                                        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF333333),
                                            ),
                                      ),
                                      Text(
                                        // getTimeAgo(data.createdAt),
                                        detail.appName,
                                        maxLines: 1,
                                        // softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                                              fontSize: 16,
                                              // fontWeight: FontWeight.w300,
                                              color: Color(0xFFbbaaaa),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                // 关注按钮
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverSafeArea(
                  top: false,
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: String2Html(html: detail.html),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        },
      ),
    );
  }
}
