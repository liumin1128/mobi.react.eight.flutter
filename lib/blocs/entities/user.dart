import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String nickname;
  final String avatarUrl;
  final String sign;
  final int sex;
  final String birthday;
  final String email;
  final String countryCode;
  final String purePhoneNumber;
  final String phoneNumber;
  final int follow;
  final int fans;
  final int dynamic;
  final bool followStatus;

  User({
    @required this.id,
    this.nickname,
    this.avatarUrl,
    this.sign,
    this.sex,
    this.birthday,
    this.email,
    this.countryCode,
    this.purePhoneNumber,
    this.phoneNumber,
    this.follow,
    this.fans,
    this.dynamic,
    this.followStatus,
  });

  @override
  String toString() {
    return 'User{id: $id, nickname: $nickname}';
  }

  static User fromJson(Map<String, Object> json) {
    return User(
      id: json["_id"] as String,
      nickname: (json["nickname"] as String) ?? "",
      avatarUrl: (json["avatarUrl"] as String) ?? "",
      // sign: (json["sign"] as String) ?? "",
      // birthday: (json["birthday"] as String) ?? "",
      // email: (json["email"] as String) ?? "",
      // phoneNumber: (json["phoneNumber"] as String) ?? "",
      // follow: (json["follow"] as int) ?? "",
      // fans: (json["fans"] as int) ?? 0,
      // dynamic: (json["dynamic"] as int) ?? 0,
      // followStatus: (json["followStatus"] as bool) ?? false,
    );
  }

  @override
  List<Object> get props => [id];
}
