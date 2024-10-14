part of 'constant.dart';

enum HomeBottomNavItems {
  displayDiary(
      label: 'FEED',
      iconData: Icons.photo_album_outlined,
      activeIconData: Icons.photo_album,
      route: Routes.home),
  search(
      label: 'SEARCH',
      iconData: Icons.search_outlined,
      activeIconData: Icons.search,
      route: Routes.search),
  meeting(
      label: 'MEETING',
      iconData: Icons.airplane_ticket_outlined,
      activeIconData: Icons.airplane_ticket,
      route: Routes.meeting),
  writeDiary(
      label: 'ADD',
      iconData: Icons.edit_note_outlined,
      activeIconData: Icons.edit_note,
      route: Routes.editDiary),
  setting(
      label: 'SETTING',
      iconData: Icons.settings_outlined,
      activeIconData: Icons.settings,
      route: Routes.setting);

  final IconData iconData;
  final IconData activeIconData;
  final String label;
  final Routes route;

  const HomeBottomNavItems(
      {required this.iconData,
      required this.activeIconData,
      required this.label,
      required this.route});
}
