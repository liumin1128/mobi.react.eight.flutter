import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:eight/utils/common.dart';

class Avatar extends StatefulWidget {
  Avatar({
    Key key,
    this.src,
    this.size = 100,
    this.decoration,
    this.placeholder,
  }) : super(key: key);
  final String src;
  final String placeholder;
  final double size;
  final BoxDecoration decoration;

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    if (widget.src == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: widget.size,
          height: widget.size,
          color: Color(0xFFdddddd),
          alignment: Alignment.center,
          child: Text(
            widget.placeholder.substring(0, 1),
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFFaaaaaa),
            ),
          ),
        ),
      );
    }
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: widget.decoration,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          decoration: BoxDecoration(color: CupertinoColors.lightBackgroundGray),
          child: FadeInImage.memoryNetwork(
            fit: BoxFit.cover,
            placeholder: kTransparentImage,
            image: getSmallImg(widget.src, widget.size * 2, widget.size * 2),
          ),
        ),
      ),
    );
  }
}
