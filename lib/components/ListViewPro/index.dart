import 'package:flutter/cupertino.dart';

// ListViewPro 默认的实例
class ListViewPro extends StatefulWidget {
  ListViewPro({Key key, this.title, this.onScrollToBottom, this.onRefresh, this.initState, this.itemCount, this.itemBuilder}) : super(key: key);
  final Function onScrollToBottom;
  final Function onRefresh;
  final Function initState;
  final String title;
  final int itemCount;
  final itemBuilder;
  @override
  _ListViewProState createState() => _ListViewProState();
}

// ListViewPro 默认的实例,有状态
class _ListViewProState extends State<ListViewPro> {
  ScrollController _scrollController = ScrollController(); //listview的控制器

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _onScrollToBottom();
      }
      print('widget.initState');
      print(widget.initState);
      // if (widget.initState is Function) {
      //   widget.initState();
      // }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<Null> _onRefresh() async {
    print('onRefresh');
    if (widget.onRefresh is Function) {
      await widget.onRefresh();
    }
  }

  Future<Null> _onScrollToBottom() async {
    print('onScrollToBottom');
    if (widget.onScrollToBottom is Function) {
      await widget.onScrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      physics: ScrollPhysics(),
      slivers: <Widget>[
        widget.title != null
            ? CupertinoSliverNavigationBar(
                largeTitle: new Text(widget.title),
                border: Border(
                  top: BorderSide(
                    style: BorderStyle.none,
                  ),
                ))
            : null,
        CupertinoSliverRefreshControl(onRefresh: _onRefresh),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            widget.itemBuilder,
            childCount: widget.itemCount,
          ),
        ),
        SliverSafeArea(
          bottom: true,
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Center(
                child: Container(
                  width: 16,
                  height: 16,
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
