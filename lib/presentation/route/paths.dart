part of 'router.dart';

enum Routes {
  home('/'),
  auth('/auth'),
  editDiary('/diary/edit');

  final String path;

  const Routes(this.path);
}
