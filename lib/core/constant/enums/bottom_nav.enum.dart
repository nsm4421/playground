import 'package:flutter/material.dart';

enum BottomNav { home, feed, chat, user }

extension BottomNavX on BottomNav {
  Icon get icon {
    switch (this) {
      case BottomNav.home:
        return const Icon(Icons.home_outlined);
      case BottomNav.feed:
        return const Icon(Icons.photo_album_outlined);
      case BottomNav.chat:
        return const Icon(Icons.chat_bubble_outline);
      case BottomNav.user:
        return const Icon(Icons.account_circle_outlined);
    }
  }

  Icon get activeIcon {
    switch (this) {
      case BottomNav.home:
        return const Icon(Icons.home);
      case BottomNav.feed:
        return const Icon(Icons.photo_album);
      case BottomNav.chat:
        return const Icon(Icons.chat_bubble);
      case BottomNav.user:
        return const Icon(Icons.account_circle);
    }
  }

  String get label {
    switch (this) {
      case BottomNav.home:
        return "홈";
      case BottomNav.feed:
        return "스토리";
      case BottomNav.chat:
        return "채팅";
      case BottomNav.user:
        return "유저";
    }
  }
}
