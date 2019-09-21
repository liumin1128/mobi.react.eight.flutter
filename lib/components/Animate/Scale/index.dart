import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';

class Scale extends StatefulWidget {
  Scale({Key key, this.src, this.size = 100, this.decoration, this.child}) : super(key: key);
  final String src;

  final double size;
  final BoxDecoration decoration;
  final Widget child;

  @override
  _ScaleState createState() => _ScaleState();
}

class _ScaleState extends State<Scale> with SingleTickerProviderStateMixin {
  AnimationController controller;
  // Animation<double> animation;
  CurvedAnimation curve;
  @override
  initState() {
    super.initState();
    controller = new AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.elasticOut);

    // animation = Tween(begin: 50.0, end: 30.0).animate(controller)
    //   ..addListener(() {
    //     setState(() {});
    //   });
    controller.forward();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: curve,
      child: widget.child,
    );
  }
}
