import 'package:flutter/cupertino.dart';

import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String content;
  Item({@required this.id, this.content});

  @override
  String toString() {
    return 'Item{id: $id, task: $content}';
  }

  static Item fromJson(Map<String, Object> json) {
    return Item(
      id: json["_id"] as String,
      content: (json["content"] as String) ?? "",
    );
  }

  @override
  List<Object> get props => [id];
}
