import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String title;
  final String cover;
  final String createdAt;
  final int total;
  final int height;
  final int comment;

  Item({
    @required this.id,
    @required this.title,
    @required this.cover,
    @required this.createdAt,
    @required this.total,
    @required this.height,
    @required this.comment,
  }) : super([
          id,
          title,
          cover,
          comment,
          createdAt,
          total,
          height,
        ]);

  @override
  String toString() => 'Item { id: $title }';
}

Item getItem(data) {
  return Item(
    id: data['_id'],
    title: data['title'],
    cover: data['cover'],
    comment: 0,
    // comment: int.parse(RegExp(r"^[0-9]*$").firstMatch(data['comment']) ?? '0'),
    createdAt: data['createdAt'],
    total: 99,
    height: data['height'],
  );
}
