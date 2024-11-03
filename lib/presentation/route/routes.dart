enum Routes {
  auth('/auth'),
  signUp('/auth/sign-up', subPath: 'sign-up'),
  home('/');

  final String path;
  final String? subPath;

  const Routes(this.path, {this.subPath});
}