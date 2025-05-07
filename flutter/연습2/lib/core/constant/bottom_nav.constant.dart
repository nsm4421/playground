part of '../export.core.dart';

enum HomeBottomNavItems {
  feed(
      label: "Feed",
      iconData: Icons.feed_outlined,
      activeIconData: Icons.feed,
      route: Routes.feed),
  chat(
      label: "Chat",
      iconData: Icons.chat_outlined,
      activeIconData: Icons.chat,
      route: Routes.chat),
  setting(
      label: "Setting",
      iconData: Icons.settings_outlined,
      activeIconData: Icons.settings,
      route: Routes.setting);

  final String label;
  final IconData iconData;
  final IconData activeIconData;
  final Routes route;

  const HomeBottomNavItems({
    required this.label,
    required this.iconData,
    required this.activeIconData,
    required this.route,
  });
}
