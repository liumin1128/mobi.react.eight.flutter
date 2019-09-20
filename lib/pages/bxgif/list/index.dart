import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eight/blocs/bxgif_list_bloc/index.dart';
// import 'package:eight/components/ListViewPro/index.dart';
// import 'item.dart';
import 'package:eight/components/Lazyload/Image.dart';

class BxgifListPage extends StatefulWidget {
  @override
  BxgifListPageState createState() => BxgifListPageState();
}

class BxgifListPageState extends State<BxgifListPage> {
  ScrollController _scrollController = ScrollController(); //listview的控制器

  @override
  void initState() {
    super.initState();
    final bxgifListBloc = BlocProvider.of<BxgifListBloc>(context);
    bxgifListBloc.dispatch(BxgifListFetch());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _onScrollToBottom();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<Null> _onScrollToBottom() async {
    print('onScrollToBottom');
    final bxgifListBloc = BlocProvider.of<BxgifListBloc>(context);
    bxgifListBloc.dispatch(BxgifListFetchMore());
  }

  // Future<Null> _onRefresh() async {
  //   print('onRefresh');
  //   if (widget.onRefresh is Function) {
  //     await widget.onRefresh();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final bxgifListBloc = BlocProvider.of<BxgifListBloc>(context);
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFF8F8F8),
      child: BlocBuilder<BxgifListBloc, BxgifListState>(
        builder: (context, state) {
          if (state is BxgifListFetchSuccessed) {
            print(state.list.length.toString());
            return StaggeredGridView.countBuilder(
                controller: _scrollController,
                padding: EdgeInsets.all(8),
                crossAxisCount: 2,
                // itemCount: 8,
                itemCount: state.list.length,
                staggeredTileBuilder: (int index) {
                  return StaggeredTile.count(1, (state.list[index].height + 100) / 195);
                },
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                itemBuilder: (BuildContext context, int index) {
                  final Item item = state.list[index];
                  print('$index');
                  print(item.height);
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Color(0xFFFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 8.0,
                          offset: Offset.fromDirection(8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: LazyloadImage(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                                bottomLeft: Radius.zero,
                                bottomRight: Radius.zero,
                              ),
                              // color: Color(0x05000000),
                              image: item.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              item.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(color: Color(0xFF666666), fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
            // return ListViewPro(
            //   title: '动态',
            //   onRefresh: () {
            //     bxgifListBloc.dispatch(BxgifListFetch());
            //   },
            //   onScrollToBottom: () {
            //     bxgifListBloc.dispatch(BxgifListFetchMore());
            //   },
            //   itemCount: state.list.length,
            //   itemBuilder: (_, int index) {
            //     final Item item = item;
            //     return Text(item.title);
            //     // return Text('$index');
            //     // return BxgifItem(data: item);
            //   },
            // );

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
