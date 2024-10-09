part of 'router.dart';

enum Routes {
  auth('/auth'),
  home('/display-diary'),
  editDiary('/write-diary'),
  setting('/setting'),
  reels('/reels'),
  search('/search'),
  editProfile('/setting/edit-profile'),
  image2Text('/image-to-text');

  final String path;

  const Routes(this.path);
}
