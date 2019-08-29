import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/blocs/dynamic_detail_bloc/index.dart';
import 'package:eight/components/ListViewPro/index.dart';
// import 'item.dart';

class DynamicDetailPage extends StatefulWidget {
  @override
  DynamicDetailPageState createState() => DynamicDetailPageState();
}

class DynamicDetailPageState extends State<DynamicDetailPage> {
  @override
  void initState() {
    super.initState();
    final dynamicListBloc = BlocProvider.of<DynamicDetailBloc>(context);
    dynamicListBloc.dispatch(DynamicDetailFetch(id: '5d66017f13b71b52f7f5a95b'));
  }

  @override
  Widget build(BuildContext context) {
    final dynamicListBloc = BlocProvider.of<DynamicDetailBloc>(context);
    return CupertinoPageScaffold(
      child: BlocBuilder<DynamicDetailBloc, DynamicDetailState>(
        builder: (context, state) {
          if (state is DynamicDetailFetchSuccessed) {
            return Text(state.data['content']);
          } else {
            return Text('loading');
          }
        },
      ),
    );
  }
}
