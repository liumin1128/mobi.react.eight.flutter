import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String nickname;
  final String avatarUrl;

  User({
    @required this.id,
    @required this.nickname,
    @required this.avatarUrl,
  }) : super([
          id,
          nickname,
          avatarUrl,
        ]);

  @override
  String toString() => 'CommentItemUser { id: $id, nickname: $nickname }';
}

class Item extends Equatable {
  final String createdAt;
  final String id;
  final String session;
  final String content;
  final int zanCount;
  final bool zanStatus;
  final int replyCount;
  final User user;
  final List<Item> replys;

  Item({
    @required this.id,
    this.session,
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
          user,
          replys,
        ]);

  Item copyWith({
    String createdAt,
    String id,
    String session,
    String content,
    int zanCount,
    bool zanStatus,
    int replyCount,
    User user,
    List replys,
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

  Item pushReply({
    @required Item reply,
  }) {
    return Item(
      id: this.id,
      session: this.session,
      createdAt: this.createdAt,
      content: this.content,
      zanCount: this.zanCount,
      zanStatus: this.zanStatus,
      replyCount: this.replyCount,
      user: this.user,
      replys: [
            reply
          ] +
          this.replys,
    );
  }

  @override
  String toString() => 'Item { id: $id, content: $content }';
}

Item getCommentItem(data) {
  List<Item> _replys = [];

  for (int jdx = 0; jdx < data['replys'].length; jdx++) {
    final temp = data['replys'][jdx];
    _replys.add(Item(
      id: temp['_id'],
      session: temp['session'],
      content: temp['content'],
      zanCount: temp['zanCount'],
      zanStatus: temp['zanStatus'],
      replyCount: temp['replyCount'],
      user: User(
        id: temp['user']['id'],
        nickname: temp['user']['nickname'],
        avatarUrl: temp['user']['avatarUrl'],
      ),
    ));
  }

  return Item(
    id: data['_id'],
    session: data['session'],
    content: data['content'],
    zanCount: data['zanCount'],
    zanStatus: data['zanStatus'],
    replyCount: data['replyCount'],
    replys: _replys,
    user: User(
      id: data['user']['id'],
      nickname: data['user']['nickname'],
      avatarUrl: data['user']['avatarUrl'],
    ),
  );
}
