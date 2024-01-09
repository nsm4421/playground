import 'package:flutter/material.dart';

enum BottomNav { home, search, group, chat, profile }

extension BottomNavExt on BottomNav {
  String label() {
    switch (this) {
      case BottomNav.home:
        return "홈";
      case BottomNav.search:
        return "검색";
      case BottomNav.group:
        return "그룹";
      case BottomNav.chat:
        return "채팅";
      case BottomNav.profile:
        return "마이페이지";
    }
  }

  Icon icon() {
    switch (this) {
      case BottomNav.home:
        return const Icon(Icons.home_outlined, size: 18);
      case BottomNav.search:
        return const Icon(Icons.search_outlined, size: 18);
      case BottomNav.group:
        return const Icon(Icons.group_outlined, size: 18);
      case BottomNav.chat:
        return const Icon(Icons.chat_bubble_outline, size: 18);
      case BottomNav.profile:
        return const Icon(Icons.account_circle_outlined, size: 18);
    }
  }

  Icon activeIcon() {
    switch (this) {
      case BottomNav.home:
        return const Icon(Icons.home, size: 23);
      case BottomNav.search:
        return const Icon(Icons.search, size: 23);
      case BottomNav.group:
        return const Icon(Icons.group, size: 23);
      case BottomNav.chat:
        return const Icon(Icons.chat_bubble, size: 23);
      case BottomNav.profile:
        return const Icon(Icons.account_circle, size: 23);
    }
  }
}
