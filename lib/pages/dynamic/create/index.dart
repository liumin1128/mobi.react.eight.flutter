import 'package:flutter/cupertino.dart' hide Action;
import 'dart:io';
import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eight/utils/index.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
// import 'package:eight/components/Drag/index.dart';

class DynamicCreatePage extends StatefulWidget {
  @override
  DynamicCreatePageState createState() => DynamicCreatePageState();
}

class DynamicCreatePageState extends State<DynamicCreatePage> {
  ScrollController _scrollController = ScrollController(); //listview的控制器
  FocusNode _contentFocusNode = FocusNode();

  List<Asset> _images = [];

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

  Future<Null> _pickeImage() async {
    HapticFeedback.selectionClick();
    List<Asset> list = await loadAssets();
    setState(() {
      _images = _images + list;
    });
  }

  Widget buildGridView() {
    // return DragAndDropList<Asset>(
    //   _images,
    //   itemBuilder: (BuildContext context, asset) {
    //     return new SizedBox(
    //       child: AssetThumb(
    //         asset: asset,
    //         width: 300,
    //         height: 300,
    //         spinner: Center(
    //           child: SizedBox(
    //             width: 50,
    //             height: 50,
    //             child: CupertinoActivityIndicator(),
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    //   onDragFinish: (before, after) {
    //     Asset data = _images[before];
    //     _images.removeAt(before);
    //     _images.insert(after, data);
    //   },
    //   canBeDraggedTo: (one, two) => true,
    //   dragElevation: 8.0,
    //   tilt: 0.05,
    // );
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
            GestureDetector(
                child: Container(
                  color: Color(0x10000000),
                  child: Icon(
                    CupertinoIcons.add,
                    size: 36,
                  ),
                ),
                onTap: _pickeImage)
          ] +
          List.generate(
            _images.length,
            (index) {
              Asset asset = _images[index];
              return GestureDetector(
                onTap: () {
                  _onTapItem(index);
                },
                child: AssetThumb(
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
                ),
              );
            },
          ),
    );
  }

  void _onTapItem(index) {
    showCupertinoModalPopup<int>(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          // title: Text("This is Title"),
          // message: Text('Chose a item !'),
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context, 1);
            },
            child: Text("取消"),
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 1);
                alert(title: '暂不支持', context: context, showCancel: false);
              },
              child: Text('编辑图片'),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, 1);
                _images.removeAt(index);
                print(_images);
                setState(() {
                  _images = _images;
                });
              },
              child: Text('删除图片', style: CupertinoTheme.of(context).textTheme.actionTextStyle),
            ),
          ],
        );
      },
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
            onPressed: _pickeImage,
            child: Text('getImage'),
          ),
        ],
      ),
    );
  }
}
