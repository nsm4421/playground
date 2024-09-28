part of 'router.dart';

enum RoutePaths {
  // 인증 페이지
  auth('/auth'),
  signUp('/auth/sign-up', subpath: 'sign-up'),
  // 홈화면
  feed('/feed'),
  search('/search'),
  createMedia('/create-media'),
  chat('/chat'),
  setting('/setting'),
  // 기타
  editProfile('/setting/edit-profile'),
  chatRoom('/chat/room', subpath: 'room');

  const RoutePaths(this.path, {this.subpath});

  final String path;
  final String? subpath;
}
