import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String createdAt;
  final String id;
  final String session;
  final String content;
  final int zanCount;
  final bool zanStatus;
  final int replyCount;
  final Map user;
  final List replys;

  Item({
    @required this.id,
    @required this.session,
    this.createdAt,
    this.content,
    this.zanCount,
    this.zanStatus,
    this.replyCount,
    this.user,
    this.replys,
  }) : super([
          id,
          session,
          createdAt,
          content,
          zanCount,
          zanStatus,
          replyCount,
          replys,
        ]);

  Item copyWith({
    final String createdAt,
    final String id,
    final String session,
    final String content,
    final int zanCount,
    final bool zanStatus,
    final int replyCount,
    final Map user,
    final List replys,
  }) {
    return Item(
      id: id ?? this.id,
      session: session ?? this.session,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      zanCount: zanCount ?? this.zanCount,
      zanStatus: zanStatus ?? this.zanStatus,
      replyCount: replyCount ?? this.replyCount,
      user: user ?? this.user,
      replys: replys ?? this.replys,
    );
  }

  @override
  String toString() => 'Item { id: $id, content: $content }';
}
