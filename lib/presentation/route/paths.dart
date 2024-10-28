part of 'router.dart';

enum Routes {
  auth('/auth'),
  home('/display-feed'),
  editFeed('/write-feed'),
  meeting('/meeting'),
  createMeeting('/create-meeting'),
  meetingDetail('/meeting-detail'),
  setting('/setting'),
  reels('/reels'),
  chat('/chat'),
  search('/search'),
  editProfile('/setting/edit-profile'),
  image2Text('/image-to-text');

  final String path;
  final String? subPath;

  const Routes(this.path, {this.subPath});
}
