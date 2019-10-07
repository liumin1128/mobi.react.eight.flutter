import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:eight/blocs/entities/index.dart';

class Item extends Equatable {
  final String id;
  final User user;
  final String content;
  final int createdAt;
  final List<String> pictures;

  Item({@required this.id, this.user, this.content, this.pictures, this.createdAt});

  @override
  String toString() {
    return 'Item{id: $id, task: $content}';
  }

  static Item fromJson(Map<String, Object> json) {
    // user
    Map<String, Object> defaultUser = {'nickname': '消失的用户', 'avatarUrl': ''};
    User user = User.fromJson(json["user"] != null ? json["user"] : defaultUser);
    // pictures
    List<String> pictures = List<String>.from((json["pictures"] != null ? json["pictures"] : []));
    return Item(
      id: json["_id"] as String,
      content: (json["content"] as String) ?? "",
      user: user,
      pictures: pictures,
      createdAt: json["createdAt"] as int,
    );
  }

  @override
  List<Object> get props => [id];
}
