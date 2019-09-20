import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/blocs/bxgif_detail_bloc/index.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
// import 'package:eight/components/Lazyload/Image.dart';

class BxgifDetailPage extends StatefulWidget {
  final String id;
  BxgifDetailPage({Key key, this.id}) : super(key: key);

  @override
  BxgifDetailPageState createState() => BxgifDetailPageState();
}

class BxgifDetailPageState extends State<BxgifDetailPage> {
  ScrollController _scrollController = ScrollController(); //listview的控制器

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {}
    });

    _onRefresh();
  }

  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<Null> _onRefresh() async {
    final bxgifDetailBloc = BlocProvider.of<BxgifDetailBloc>(context);
    bxgifDetailBloc.dispatch(BxgifDetailFetch(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    // final bxgifDetailBloc = BlocProvider.of<BxgifDetailBloc>(context);
    return BlocBuilder<BxgifDetailBloc, BxgifDetailState>(
      builder: (context, state) {
        if (state is BxgifDetailFetchSuccessed && widget.id == state.data['_id']) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(middle: Text(state.data['title'].substring(14))),
            child: Container(
              child: PhotoViewGallery.builder(
                scrollDirection: Axis.vertical,
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(state.data['list'][index]['url']),
                    // initialScale: PhotoViewComputedScale.contained * 0.8,
                    heroAttributes: PhotoViewHeroAttributes(tag: 'xxxxx'),
                  );
                },
                itemCount: state.data['list'].length,
                loadingChild: Center(
                  child: CupertinoActivityIndicator(),
                ),
                backgroundDecoration: BoxDecoration(color: Color(0xFFFFFFF)),
                // pageController: widget.pageController,
                // onPageChanged: onPageChanged,
              ),
            ),
          );

          // child: CustomScrollView(
          //   controller: _scrollController,
          //   slivers: <Widget>[
          //     SliverFillViewport(
          //       viewportFraction: 1.0,
          //       delegate: SliverChildBuilderDelegate(
          //         (_, index) => Container(
          //           child: Text('Item $index'),
          //           alignment: Alignment.center,
          //           color: Color(0x55000000),
          //         ),
          //         childCount: 10,
          //       ),
          //     ),
          //   ],
          // ),
          // child: CustomScrollView(
          //   controller: _scrollController,
          //   slivers: <Widget>[
          //     CupertinoSliverNavigationBar(
          //       largeTitle: Text(state.data['title'].substring(14)),
          //       border: Border(
          //         top: BorderSide(
          //           style: BorderStyle.none,
          //         ),
          //       ),
          //     ),
          //     CupertinoSliverRefreshControl(onRefresh: _onRefresh),
          //     // 内容
          //     SliverSafeArea(
          //       sliver: SliverToBoxAdapter(
          //         child: Container(
          //           padding: const EdgeInsets.all(16),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: <Widget>[
          //               Text(state.data['title'])
          //               // Text(state.data['content']),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // );
        } else {
          return CupertinoPageScaffold(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
      },
    );
  }
}
