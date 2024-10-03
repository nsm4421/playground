part of 'router.dart';

enum Routes {
  entry('/'),
  editDiary('/diary/edit');

  final String path;

  const Routes(this.path);
}
