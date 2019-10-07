import 'package:flutter/cupertino.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter_html/flutter_html.dart';
import 'package:transparent_image/transparent_image.dart';

const double kMinInteractiveDimensionCupertino = 44.0;

class String2Html extends StatefulWidget {
  const String2Html({Key key, @required this.html}) : super(key: key);

  final String html;

  @override
  _String2HtmlState createState() => _String2HtmlState();
}

class _String2HtmlState extends State<String2Html> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Html(
      data: widget.html,
      // useRichText: false,
      customRender: (node, children) {
        if (node is dom.Element) {
          switch (node.localName) {
            case 'img':
              {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                      decoration: BoxDecoration(color: CupertinoColors.black),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: node.attributes['src'],
                      )),
                );
              }
            // case "video": return Chewie(...);
            // case "custom_tag": return CustomWidget(...);
          }
        }
      },
      customTextAlign: (dom.Node node) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "p":
              return TextAlign.justify;
          }
        }
      },
      customTextStyle: (dom.Node node, TextStyle baseStyle) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "p":
              return baseStyle.merge(TextStyle(height: 1.25, fontSize: 14));
          }
        }
        return baseStyle;
      },
    );
  }
}
