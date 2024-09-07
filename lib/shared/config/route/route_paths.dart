part of 'router.dart';

enum RoutePaths {
  auth('/auth'),
  signIn('/auth/sign-in', subpath: 'sign-in'),
  signUp('/auth/sign-up', subpath: 'sign-up'),
  ;

  const RoutePaths(this.path, {this.subpath});

  final String path;
  final String? subpath;
}
