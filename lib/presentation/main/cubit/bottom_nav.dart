import 'package:flutter/material.dart';

enum BottomNav {
  home,
  feed,
  geo,
  chat,
  setting;

  String get label {
    switch (this) {
      case BottomNav.home:
        return "홈";
      case BottomNav.feed:
        return "피드";
      case BottomNav.geo:
        return "로컬";
      case BottomNav.chat:
        return "채팅";
      case BottomNav.setting:
        return "세팅";
    }
  }

  IconData get icon {
    switch (this) {
      case BottomNav.home:
        return Icons.home_outlined;
      case BottomNav.feed:
        return Icons.photo_album_outlined;
      case BottomNav.geo:
        return Icons.location_on_outlined;
      case BottomNav.chat:
        return Icons.chat_outlined;
      case BottomNav.setting:
        return Icons.settings_outlined;
    }
  }

  IconData get activeIcon {
    switch (this) {
      case BottomNav.home:
        return Icons.home;
      case BottomNav.feed:
        return Icons.photo_album;
      case BottomNav.geo:
        return Icons.location_on;
      case BottomNav.chat:
        return Icons.chat_bubble;
      case BottomNav.setting:
        return Icons.settings;
    }
  }
}
