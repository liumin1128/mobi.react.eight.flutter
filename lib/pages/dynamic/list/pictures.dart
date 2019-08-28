import 'package:flutter/cupertino.dart';
import 'package:eight/components/Lazyload/Image.dart';

List<Widget> getPicturesList(pictures) {
  List<Widget> list = [];
  for (var i in pictures) {
    list.add(
      new LazyloadImage(
        borderRadius: BorderRadius.circular(4),
        width: 100,
        height: 100,
        color: Color(0x05000000),
        image: i,
      ),
    );
  }
  return list;
}
