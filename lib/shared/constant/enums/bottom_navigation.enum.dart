import 'package:flutter/material.dart';

import '../../config/config.export.dart';

enum HomeBottomNavItem {
  feed(activeIcon: Icons.home_filled, icon: Icons.home_outlined, label: '피드'),
  search(activeIcon: Icons.search, icon: Icons.search_outlined, label: '검색'),
  createMedia(activeIcon: Icons.add, icon: Icons.add, label: '포스팅'),
  chat(
      activeIcon: Icons.chat_bubble,
      icon: Icons.chat_bubble_outline,
      label: '채팅'),
  setting(
      activeIcon: Icons.settings, icon: Icons.settings_outlined, label: '세팅'),
  ;

  final IconData activeIcon;
  final IconData icon;
  final String label;

  const HomeBottomNavItem(
      {required this.activeIcon, required this.icon, required this.label});

  double get activeIconSize => 24;

  double get iconSize => 18;

  String get path {
    return switch (this) {
      feed => RoutePaths.feed.path,
      search => RoutePaths.search.path,
      createMedia => RoutePaths.createMedia.path,
      chat => RoutePaths.chat.path,
      setting => RoutePaths.setting.path
    };
  }
}
