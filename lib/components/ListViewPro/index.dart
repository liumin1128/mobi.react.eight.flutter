import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ListViewPro 默认的实例
class ListViewPro extends StatefulWidget {
  ListViewPro({ Key key, this.title, this.onScrollToBottom, this.onRefresh, this.itemCount, this.itemBuilder }) : super(key: key);
  final onScrollToBottom;
  final onRefresh;
  final itemCount;
  final itemBuilder;
  final title;
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
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<Null> _onRefresh() async {
    print('onRefresh');
    // if(widget.onRefresh != null) {
      await widget.onRefresh();
    // }
  }

  Future<Null> _onScrollToBottom() async {
    print('onScrollToBottom');
    // if(widget.onScrollToBottom != null) {
      await widget.onScrollToBottom();
    // }
  }

  @override
  Widget build(BuildContext context) {
    // return new CupertinoSliverRefreshControl(
    //   onRefresh: _onRefresh,
    //   child: ListView.builder(
    //     controller: _scrollController,
    //     itemCount: widget.itemCount,
    //     itemBuilder: widget.itemBuilder,
    //   )
    // );

    // return ListView.builder(
    //   controller: _scrollController,
    //   itemCount: widget.itemCount,
    //   itemBuilder: widget.itemBuilder,
    // );

    return CustomScrollView(
      controller: _scrollController,
      physics: ScrollPhysics(),
      slivers: <Widget>[

        widget.title != null 
          ? CupertinoSliverNavigationBar(
            largeTitle: new Text(widget.title),
            backgroundColor: Colors.white,
            border: Border(
              top: BorderSide(
                style: BorderStyle.none,
              ),
            )
          ) 
          : null,

        CupertinoSliverRefreshControl(onRefresh:_onRefresh),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            widget.itemBuilder,
            childCount: widget.itemCount,
          ),
        ),

        SliverSafeArea(
          // top: true,
          bottom: true,
          sliver: SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              // child: Text('loading more...', textAlign: TextAlign.center)
              child: Center(
                child: Container(
                  width: 16,
                  height: 16,
                  child: CupertinoActivityIndicator(
                    // strokeWidth: 2,
                  )
                )
              )
            )
          ),
        )
        
      ],
    );
  }
}
 