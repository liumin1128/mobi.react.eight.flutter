import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';

class LazyloadImage extends StatefulWidget {
  LazyloadImage({Key key, this.image, this.width, this.height, this.color, this.borderRadius}) : super(key: key);
  final String image;
  final double width;
  final double height;
  final Color color;
  final BorderRadius borderRadius;

  @override
  _LazyloadImageState createState() => _LazyloadImageState();
}

class _LazyloadImageState extends State<LazyloadImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: Container(
          decoration: BoxDecoration(color: widget.color),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: widget.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
