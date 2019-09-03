import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:eight/utils/common.dart';

class Avatar extends StatefulWidget {
  Avatar({Key key, this.src, this.size = 100}) : super(key: key);
  final String src;

  final double size;

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          decoration: BoxDecoration(color: CupertinoColors.inactiveGray),
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
