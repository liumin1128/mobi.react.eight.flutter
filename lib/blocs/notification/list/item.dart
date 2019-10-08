import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:eight/blocs/entities/index.dart';

class Item extends Equatable {
  final String id;
  final int createdAt;
  final String actionShowText;
  final String userShowText;
  final String actionorShowText;
  final User user;
  final User actionor;

  Item({
    @required this.id,
    this.createdAt,
    this.actionShowText,
    this.userShowText,
    this.actionorShowText,
    this.user,
    this.actionor,
  });

  static Item fromJson(Map<String, Object> json) {
    // user
    Map<String, Object> defaultUser = {'nickname': '消失的用户', 'avatarUrl': ''};
    User user = User.fromJson(json["user"] != null ? json["user"] : defaultUser);
    User actionor = User.fromJson(json["actionor"] != null ? json["actionor"] : defaultUser);

    return Item(
      id: json["_id"] as String,
      createdAt: json["createdAt"] as int,
      actionShowText: (json["actionShowText"] as String) ?? "",
      userShowText: (json["userShowText"] as String) ?? "",
      actionorShowText: (json["actionorShowText"] as String) ?? "",
      user: user,
      actionor: actionor,
    );
  }

  @override
  List<Object> get props => [id];
}
