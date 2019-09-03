import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: Container(
        decoration: BoxDecoration(color: widget.color),
        // child: FadeInImage.memoryNetwork(
        //   placeholder: kTransparentImage,
        //   image: widget.image,
        //   fit: BoxFit.cover,
        // ),
        child: CachedNetworkImage(
          width: widget.width,
          height: widget.height,
          imageUrl: widget.image,
          placeholder: (context, url) => CupertinoActivityIndicator(),
          errorWidget: (context, url, error) => new Icon(CupertinoIcons.bookmark),
          fit: BoxFit.cover,
        ),
      ),
      // child: Text('xxxx')),
    );
  }
}
