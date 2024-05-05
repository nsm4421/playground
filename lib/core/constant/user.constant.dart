import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AuthStatus {
  authenticated,
  unAuthenticated;
}

enum Provider {
  google;
}

enum Sex {
  none("성별을 선택하지 않음"),
  woman("여자"),
  man("남자");

  final String description;

  const Sex(this.description);
}

enum UserSearchType {
  nickname(label: "닉네임", iconData: Icons.account_circle_outlined),
  hashtag(label: "해시태그", iconData: Icons.tag);

  final String label;
  final IconData iconData;

  const UserSearchType({required this.label, required this.iconData});
}
