import 'package:flutter/cupertino.dart' hide Action;
import 'dart:io';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eight/utils/image.dart';

class DynamicCreatePage extends StatefulWidget {
  @override
  DynamicCreatePageState createState() => DynamicCreatePageState();
}

class DynamicCreatePageState extends State<DynamicCreatePage> {
  ScrollController _scrollController = ScrollController(); //listview的控制器
  FocusNode _contentFocusNode = FocusNode();

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

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
      child: Container(
        child: Center(
          child: CupertinoButton(
            onPressed: () async {
              File image = await pickerPicture();
              var sss = await uploadPicture(image: image);
              print(sss);
              print(sss);
              print(sss);
              print(sss);
            },
            child: Text('getImage'),
          ),
        ),
      ),
    );
  }
}
