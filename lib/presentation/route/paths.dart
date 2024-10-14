part of 'router.dart';

enum Routes {
  auth('/auth'),
  home('/display-diary'),
  editDiary('/write-diary'),
  meeting('/meeting'),
  createMeeting('/create-meeting'),
  setting('/setting'),
  reels('/reels'),
  chat('/chat'),
  search('/search'),
  editProfile('/setting/edit-profile'),
  image2Text('/image-to-text');

  final String path;

  const Routes(this.path);
}
