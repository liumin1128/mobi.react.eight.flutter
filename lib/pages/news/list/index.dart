import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/blocs/news_list/index.dart';
import 'package:eight/components/ListViewPro/index.dart';
import 'item.dart';

class NewsListPage extends StatefulWidget {
  @override
  NewsListPageState createState() => NewsListPageState();
}

class NewsListPageState extends State<NewsListPage> {
  @override
  void initState() {
    super.initState();
    final newsListBloc = BlocProvider.of<NewsListBloc>(context);
    newsListBloc.dispatch(NewsListFetch());
  }

  @override
  Widget build(BuildContext context) {
    final newsListBloc = BlocProvider.of<NewsListBloc>(context);
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFFAFAFA),
      child: BlocBuilder<NewsListBloc, NewsListState>(
        builder: (context, state) {
          if (state is NewsListFetchSuccessed) {
            return ListViewPro(
              title: '动态',
              onRefresh: () {
                newsListBloc.dispatch(NewsListFetch());
              },
              onScrollToBottom: () {
                newsListBloc.dispatch(NewsListFetchMore());
              },
              itemCount: state.list.length,
              itemBuilder: (_, int index) {
                // return Text(state.list[index].title);
                return NewsListItem(data: state.list[index]);
              },
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
