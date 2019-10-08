import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/blocs/notification/list/index.dart';
import 'package:eight/components/ListViewPro/index.dart';
import 'item.dart';

class NotificationListPage extends StatefulWidget {
  @override
  NotificationListPageState createState() => NotificationListPageState();
}

class NotificationListPageState extends State<NotificationListPage> {
  @override
  void initState() {
    super.initState();
    final notificationListBloc = BlocProvider.of<NotificationListBloc>(context);
    notificationListBloc.dispatch(NotificationListFetch());
  }

  @override
  Widget build(BuildContext context) {
    final notificationListBloc = BlocProvider.of<NotificationListBloc>(context);
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFFAFAFA),
      child: BlocBuilder<NotificationListBloc, NotificationListState>(
        builder: (context, state) {
          if (state is NotificationListFetchSuccessed) {
            return ListViewPro(
              title: '消息通知',
              onRefresh: () {
                notificationListBloc.dispatch(NotificationListFetch());
              },
              onScrollToBottom: () {
                notificationListBloc.dispatch(NotificationListFetchMore());
              },
              itemCount: state.list.length,
              itemBuilder: (_, int index) {
                // return Text(state.list[index].title);
                return NotificationListItem(data: state.list[index]);
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
