part of "bottom_nav.cubit.dart";

enum BottomNav {
  home(
      label: 'HOME', iconData: Icons.home_outlined, activeIconData: Icons.home),
  chat(
      label: 'CHAT',
      iconData: Icons.chat_bubble_outline,
      activeIconData: Icons.chat_bubble),
  travel(
      label: 'TRIP',
      iconData: Icons.airplane_ticket_outlined,
      activeIconData: Icons.airplane_ticket),
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
