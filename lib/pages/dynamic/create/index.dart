import 'package:flutter/cupertino.dart' hide Action;
// import 'package:flutter_bloc/flutter_bloc.dart';

class DynamicCreatePage extends StatefulWidget {
  @override
  DynamicCreatePageState createState() => DynamicCreatePageState();
}

class DynamicCreatePageState extends State<DynamicCreatePage> {
  ScrollController _scrollController = ScrollController(); //listview的控制器
  FocusNode _contentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {}
    });

    _contentFocusNode.addListener(() {
      // print(_contentFocusNode.hasFocus);
      if (!_contentFocusNode.hasFocus) {}
    });

    // _contentTextEditingController = TextEditingController(text: '');
  }

  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _contentFocusNode.dispose();
  }

  Future<Null> _onSentComment(content) async {
    // _contentTextEditingController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: Border(
          top: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        middle: Text('创建'),
      ),
      child: Center(
        child: Text('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'),
      ),
    );
  }
}
