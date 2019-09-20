import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/blocs/bxgif_list_bloc/index.dart';
import 'package:eight/components/ListViewPro/index.dart';
// import 'item.dart';

class BxgifListPage extends StatefulWidget {
  @override
  BxgifListPageState createState() => BxgifListPageState();
}

class BxgifListPageState extends State<BxgifListPage> {
  @override
  void initState() {
    super.initState();
    final bxgifListBloc = BlocProvider.of<BxgifListBloc>(context);
    bxgifListBloc.dispatch(BxgifListFetch());
  }

  @override
  Widget build(BuildContext context) {
    final bxgifListBloc = BlocProvider.of<BxgifListBloc>(context);
    return CupertinoPageScaffold(
      child: BlocBuilder<BxgifListBloc, BxgifListState>(
        builder: (context, state) {
          if (state is BxgifListFetchSuccessed) {
            return ListViewPro(
              title: '动态',
              onRefresh: () {
                bxgifListBloc.dispatch(BxgifListFetch());
              },
              onScrollToBottom: () {
                bxgifListBloc.dispatch(BxgifListFetchMore());
              },
              itemCount: state.list.length,
              itemBuilder: (_, int index) {
                final sss = state.list[index];
                print('sss');
                print(sss);
                return Text(sss['title']);
                // return Text('$index');
                // return BxgifItem(data: state.list[index]);
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
