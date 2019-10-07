import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/blocs/dynamic_list/index.dart';
import 'package:eight/components/ListViewPro/index.dart';
import 'package:eight/components/Icons/Eva.dart';
import 'item.dart';

class DynamicListPage extends StatefulWidget {
  @override
  DynamicListPageState createState() => DynamicListPageState();
}

class DynamicListPageState extends State<DynamicListPage> {
  @override
  void initState() {
    super.initState();
    final dynamicListBloc = BlocProvider.of<DynamicListBloc>(context);
    dynamicListBloc.dispatch(DynamicListFetch());
  }

  @override
  Widget build(BuildContext context) {
    final dynamicListBloc = BlocProvider.of<DynamicListBloc>(context);
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFFAFAFA),
      child: BlocBuilder<DynamicListBloc, DynamicListState>(
        builder: (context, state) {
          if (state is DynamicListFetchSuccessed) {
            return ListViewPro(
              title: '动态',
              onRefresh: () {
                dynamicListBloc.dispatch(DynamicListFetch());
              },
              onScrollToBottom: () {
                dynamicListBloc.dispatch(DynamicListFetchMore());
              },
              itemCount: state.list.length,
              itemBuilder: (_, int index) {
                return DynamicItem(data: state.list[index]);
              },
              navigationBar: CupertinoSliverNavigationBar(
                largeTitle: Text('动态'),
                border: Border(
                  top: BorderSide(
                    style: BorderStyle.none,
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed('/dynamic/create');
                  },
                  child: Icon(EvaIcons.editOutline),
                ),
              ),
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
