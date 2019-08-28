import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/blocs/dynamic_list_bloc/index.dart';
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
    return CupertinoPageScaffold(
      child: BlocBuilder<DynamicListBloc, DynamicListState>(
        builder: (context, state) {
          if (state is DynamicListFetchSuccessed) {
            return ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (_, int index) {
                return DynamicItem(data: state.list[index]);
              },
            );
          } else {
            return Text('loading');
          }
        },
      ),
    );
  }
}
