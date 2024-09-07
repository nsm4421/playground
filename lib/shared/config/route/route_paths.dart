part of 'router.dart';

enum RoutePaths {
  auth('/auth'),
  signUp('/auth/sign-up', subpath: 'sign-up'),
  home('/'),
  ;

  const RoutePaths(this.path, {this.subpath});

  final String path;
  final String? subpath;
}
