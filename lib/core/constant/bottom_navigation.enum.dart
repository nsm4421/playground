import 'package:flutter/material.dart';

enum BottomNavigation { home, match, chat, setting }

extension BottomNavigationEx on BottomNavigation {
  BottomNavigationBarItem toWidget() {
    switch (this) {
      case BottomNavigation.home:
        return const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_filled),
            label: "HOME");
      case BottomNavigation.match:
        return const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: "MATCH");
      case BottomNavigation.chat:
        return const BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat),
            label: "CHAT");
      case BottomNavigation.setting:
        return const BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: "SETTING");
    }
  }
}
