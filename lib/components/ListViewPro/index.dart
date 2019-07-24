import 'package:flutter/material.dart';

// ListViewPro 默认的实例
class ListViewPro extends StatefulWidget {
  ListViewPro({ Key key, this.onScrollToBottom, this.onRefresh, this.itemCount, this.itemBuilder }) : super(key: key);
  final onScrollToBottom;
  final onRefresh;
  final itemCount;
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
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<Null> _onRefresh() async {
    print('onRefresh');
    if(widget.onRefresh != null) {
      widget.onRefresh();
    }
  }

  Future<Null> _onScrollToBottom() async {
    print('onScrollToBottom');
    if(widget.onScrollToBottom != null) {
      widget.onScrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
      )
    );
  }
}
