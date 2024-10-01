part of 'constant.dart';

enum BottomNav {
  displayDiary(
      label: 'diary',
      iconData: Icons.photo_album_outlined,
      activeIconData: Icons.photo_album),
  writeDiary(
      label: 'write',
      iconData: Icons.edit_note_outlined,
      activeIconData: Icons.edit_note),
  imageToText(
      label: 'translate',
      iconData: Icons.g_translate_outlined,
      activeIconData: Icons.g_translate);

  final IconData iconData;
  final IconData activeIconData;
  final String label;

  const BottomNav(
      {required this.iconData,
      required this.activeIconData,
      required this.label});
}
