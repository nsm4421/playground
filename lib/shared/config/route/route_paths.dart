part of 'router.dart';

enum RoutePaths {
  // 인증 페이지
  auth('/auth'),
  signUp('/auth/sign-up', subpath: 'sign-up'),
  // 홈화면
  feed('/feed'),
  search('/search'),
  createMedia('/create-media'),
  reels('/reels'),
  setting('/setting'),
  ;

  const RoutePaths(this.path, {this.subpath});

  final String path;
  final String? subpath;
}
