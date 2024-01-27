import 'package:flutter/material.dart';

enum SearchOption {
  hashtag(label: 'Hashtag', icon: Icons.tag, activeIcon: Icons.tag_outlined),
  content(label: 'Content', icon: Icons.abc, activeIcon: Icons.abc_outlined),
  nickname(
      label: 'User',
      icon: Icons.account_circle_outlined,
      activeIcon: Icons.account_circle);

  const SearchOption(
      {required this.label, required this.icon, required this.activeIcon});

  final String label;
  final IconData icon;
  final IconData activeIcon;
}
