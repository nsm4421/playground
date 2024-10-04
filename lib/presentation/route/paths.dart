part of 'router.dart';

enum Routes {
  auth('/auth'),
  home('/'),
  editDiary('/diary/edit');

  final String path;

  const Routes(this.path);
}
