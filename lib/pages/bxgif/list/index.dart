import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eight/blocs/bxgif_list_bloc/index.dart';
import 'package:eight/components/ListViewPro/index.dart';
// import 'item.dart';
import 'package:eight/components/Lazyload/Image.dart';

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
      backgroundColor: Color(0xFFF8F8F8),
      child: BlocBuilder<BxgifListBloc, BxgifListState>(
        builder: (context, state) {
          if (state is BxgifListFetchSuccessed) {
            return StaggeredGridView.countBuilder(
              padding: EdgeInsets.all(8),
              crossAxisCount: 2,
              itemCount: 10,
              staggeredTileBuilder: (int index) => StaggeredTile.count(1, (state.list[index].height + 100) / 195),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemBuilder: (BuildContext context, int index) => Container(
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
                          image: state.list[index].cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          state.list[index].title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(color: Color(0xFF666666), fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
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
            //     final Item item = state.list[index];
            //     return Text(item.title);
            //     // return Text('$index');
            //     // return BxgifItem(data: state.list[index]);
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
