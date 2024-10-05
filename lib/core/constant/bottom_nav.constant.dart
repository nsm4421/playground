part of 'constant.dart';

enum HomeBottomNavItems {
  displayDiary(
      label: 'diary',
      iconData: Icons.photo_album_outlined,
      activeIconData: Icons.photo_album,
      route: Routes.home),
  writeDiary(
      label: 'write',
      iconData: Icons.edit_note_outlined,
      activeIconData: Icons.edit_note,
      route: Routes.editDiary),
  imageToText(
      label: 'translate',
      iconData: Icons.g_translate_outlined,
      activeIconData: Icons.g_translate,
      route: Routes.image2Text);

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
