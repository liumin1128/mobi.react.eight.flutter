import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String title;
  final String content;
  final String cover;
  final int createdAt;
  final String appName;
  final String appCode;
  final String html;

  Item({
    @required this.id,
    this.createdAt,
    this.content,
    this.title,
    this.cover,
    this.appName,
    this.appCode,
    this.html,
  });

  @override
  String toString() {
    return 'Item{id: $id, task: $content}';
  }

  static Item fromJson(Map<String, Object> json) {
    print(json["_id"]);
    print(json["title"]);
    // user
    return Item(
      id: json["_id"] as String,
      title: (json["title"] as String) ?? "",
      cover: (json["cover"] as String) ?? ((json["photos"] as List)[0] as String) ?? 'https://imgs.react.mobi/Fq79WFgZh2HDJNrtKTkdzMIOpGu7',
      appName: (json["appName"] as String) ?? "",
      appCode: (json["appCode"] as String) ?? "",
      html: (json["html"] as String) ?? "",
      createdAt: json["createdAt"] as int,
    );
  }

  @override
  List<String> get props => [id];
}
