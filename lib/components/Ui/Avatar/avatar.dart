import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';

class Avatar extends StatefulWidget {
  Avatar({Key key, this.avatarUrl}) : super(key: key);
  final String avatarUrl;

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          decoration: BoxDecoration(color: CupertinoColors.activeGreen),
          child: FadeInImage.memoryNetwork(
            fit: BoxFit.cover,
            placeholder: kTransparentImage,
            image: widget.avatarUrl,
          ),
        ),
      ),
    );
  }
}
