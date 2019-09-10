import 'package:flutter/cupertino.dart' hide Action;
import 'dart:io';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eight/utils/image.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';

class DynamicCreatePage extends StatefulWidget {
  @override
  DynamicCreatePageState createState() => DynamicCreatePageState();
}

class DynamicCreatePageState extends State<DynamicCreatePage> {
  ScrollController _scrollController = ScrollController(); //listview的控制器
  FocusNode _contentFocusNode = FocusNode();

  List images = [];

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

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
          spinner: Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CupertinoActivityIndicator(),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFf8f8f8),
      navigationBar: CupertinoNavigationBar(
        border: Border(
          top: BorderSide(
            style: BorderStyle.none,
          ),
        ),
        middle: Text('创建'),
      ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: buildGridView(),
          ),
          // buildGridView(),
          CupertinoButton(
            onPressed: () async {
              // File image = await pickerPicture();
              // var sss = await uploadToQiniu(image: image);
              // print(sss);
              // print(sss);
              // print(sss);
              // print(sss);
              var list = await loadAssets();
              print(list);

              setState(() {
                images = list;
              });
            },
            child: Text('getImage'),
          ),
        ],
      ),
    );
  }
}
