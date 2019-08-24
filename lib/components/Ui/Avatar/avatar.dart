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
    return FadeInImage.memoryNetwork(
      placeholder: kTransparentImage,
      image: widget.avatarUrl,
    );
  }
}
