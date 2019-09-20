import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eight/blocs/bxgif_detail_bloc/index.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:eight/components/Lazyload/Image.dart';

class BxgifDetailPage extends StatefulWidget {
  final String id;
  BxgifDetailPage({Key key, this.id}) : super(key: key);

  @override
  BxgifDetailPageState createState() => BxgifDetailPageState();
}

class BxgifDetailPageState extends State<BxgifDetailPage> {
  ScrollController _scrollController = ScrollController(); //listview的控制器
  int currentIndex = 1;
  String title = "";
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
          final int length = state.data['list'].length;
          return CupertinoPageScaffold(
            backgroundColor: Color(0xFF000000),
            navigationBar: CupertinoNavigationBar(
              middle: Text(state.data['title'].substring(0, 13)),
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                Container(
                  child: PhotoViewGallery.builder(
                    scrollDirection: Axis.vertical,
                    scrollPhysics: const BouncingScrollPhysics(),
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index + 1;
                        title = state.data['list'][index]['title'];
                      });
                    },
                    builder: (BuildContext context, int index) {
                      final data = state.data['list'][index];
                      // setState(() {
                      //   title = data['title'];
                      // });
                      return PhotoViewGalleryPageOptions.customChild(
                        // child: Stack(
                        //   alignment: Alignment.bottomRight,
                        //   children: <Widget>[
                        child: LazyloadImage(
                          image: data['url'],
                          borderRadius: BorderRadius.zero,
                        ),
                        // ),
                        // Container(
                        //   padding: const EdgeInsets.all(20.0),
                        //   child: Text(
                        //     "xxxxxxx",
                        //     style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 17.0, decoration: null),
                        //   ),
                        // )
                        // ],
                        // ),
                        childSize: Size(
                          double.parse(data['width']),
                          double.parse(data['height']),
                        ),
                        // initialScale: PhotoViewComputedScale.contained,
                        // minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
                        // maxScale: PhotoViewComputedScale.covered * 1.1,
                        // heroAttributes: PhotoViewHeroAttributes(tag: 'xxx'),
                      );
                      return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(data['url']),
                        // initialScale: PhotoViewComputedScale.contained * 0.8,
                        heroAttributes: PhotoViewHeroAttributes(tag: 'xxxxx'),
                      );
                    },
                    itemCount: state.data['list'].length,
                    loadingChild: Container(
                      color: Color(0xFF000000),
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                    backgroundDecoration: BoxDecoration(
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "$title ",
                        style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 17.0, decoration: null),
                      ),
                      Text(
                        "$currentIndex / $length",
                        style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 17.0, decoration: null),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return CupertinoPageScaffold(
            backgroundColor: Color(0xFF000000),
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        }
      },
    );
  }
}
