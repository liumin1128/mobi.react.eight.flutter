import 'package:flutter/cupertino.dart';
import 'package:flutter/animation.dart';

const double kMinInteractiveDimensionCupertino = 44.0;

class Button extends StatefulWidget {
  const Button({
    Key key,
    @required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
    this.color,
    this.disabledColor,
    this.minSize = kMinInteractiveDimensionCupertino,
    this.pressedOpacity = 0.1,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    @required this.onPressed,
  })  : assert(pressedOpacity == null || (pressedOpacity >= 0.0 && pressedOpacity <= 1.0)),
        super(key: key);

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Color disabledColor;
  final double minSize;
  final double pressedOpacity;
  final BorderRadius borderRadius;
  final Function onPressed;

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Semantics(
        button: true,
        child: Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            // color: widget.color,
            border: Border.all(
              style: BorderStyle.solid,
              color: widget.color,
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
