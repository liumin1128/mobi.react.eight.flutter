import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:eight/utils/index.dart';
// import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:eight/blocs/dynamic_list/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DynamicCreatePage extends StatefulWidget {
  @override
  DynamicCreatePageState createState() => DynamicCreatePageState();
}

class DynamicCreatePageState extends State<DynamicCreatePage> {
  ScrollController _scrollController = ScrollController(); //listview的控制器
  FocusNode _contentFocusNode = FocusNode();
  TextEditingController _contentTextEditingController = TextEditingController();

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

  Widget buildGridViewImages() {
    // return DragAndDropList<Asset>(
    //   _images,
    //   itemBuilder: (BuildContext context, asset) {
    //     return SizedBox(
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
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: EdgeInsets.all(16),
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFcccccc)),
                ),
                child: Icon(
                  CupertinoIcons.photo_camera_solid,
                  size: 36,
                  color: Color(0xFFcccccc),
                ),
              ),
              onTap: _pickeImage,
            )
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
        // leading: Text('创建'),
        middle: Text(
          '发布动态',
          style: TextStyle(
            color: CupertinoTheme.of(context).primaryColor,
          ),
        ),
        trailing: CupertinoButton(
          // color: CupertinoTheme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(vertical: 4),
          borderRadius: BorderRadius.circular(16),
          minSize: 0,
          child: Text('发布', style: TextStyle(fontSize: 16)),
          onPressed: () async {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  content: Container(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              },
            );

            List pictures = await uploadMultiAssetsToQiniu(_images);
            final dynamicListBloc = BlocProvider.of<DynamicListBloc>(context);
            final String content = _contentTextEditingController.text;

            Navigator.pop(context);

            dynamicListBloc.dispatch(
              DynamicListCreate(
                context: context,
                content: content,
                pictures: pictures,
              ),
            );
          },
        ),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // 触摸收起键盘
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 64)),
            CupertinoTextField(
              padding: EdgeInsets.all(16),
              placeholder: "想要说些什么？",
              controller: _contentTextEditingController,
              // autofocus: true,
              // focusNode: focusNodeCode,
              maxLines: 8,
              // minLines: 8,
              onChanged: (str) {
                setState(() {});
              },
              // style: TextStyle(
              //   fontSize: 22,
              //   color: CupertinoColors.black,
              // ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    style: BorderStyle.solid,
                    color: Color(0xFFeeeeee),
                  ),
                ),
              ),
            ),
            // buildGridViewImages(),

            Expanded(
              child: buildGridViewImages(),
            ),
          ],
        ),
      ),
    );
  }
}
