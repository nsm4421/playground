part of 'constant.dart';

enum HomeBottomNavItem {
  feed(activeIcon: Icons.home_filled, icon: Icons.home_outlined, label: 'Feed'),
  search(
      activeIcon: Icons.search, icon: Icons.search_outlined, label: 'Search'),
  reels(
      activeIcon: Icons.video_collection,
      icon: Icons.video_collection_outlined,
      label: 'Reels'),
  setting(
      activeIcon: Icons.settings,
      icon: Icons.settings_outlined,
      label: 'Setting'),
  ;

  final IconData activeIcon;
  final IconData icon;
  final String label;

  const HomeBottomNavItem(
      {required this.activeIcon, required this.icon, required this.label});

  double get activeIconSize => 24;

  double get iconSize => 18;
}
