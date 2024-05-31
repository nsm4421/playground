import 'package:flutter/material.dart';

enum BottomNav {
  home(
      label: 'HOME', iconData: Icons.home_outlined, activeIconData: Icons.home),
  feed(
      label: 'FEED', iconData: Icons.feed_outlined, activeIconData: Icons.feed),
  short(
      label: 'SHORT',
      iconData: Icons.play_circle_outline,
      activeIconData: Icons.play_circle),
  chat(
      label: 'CHAT',
      iconData: Icons.chat_bubble_outline,
      activeIconData: Icons.chat_bubble),
  setting(
      label: 'SETTING',
      iconData: Icons.settings_outlined,
      activeIconData: Icons.settings);

  final String label;
  final IconData iconData;
  final IconData activeIconData;

  const BottomNav({
    required this.label,
    required this.iconData,
    required this.activeIconData,
  });
}
