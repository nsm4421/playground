enum Routes {
  /// auth
  auth('/auth'),
  signUp('/auth/sign-up', subPath: 'sign-up'),

  /// home
  home('/home'),
  feed('/home/feed', subPath: 'feed'),
  createFeed('/home/feed/create', subPath: 'create'),
  search('/home/search', subPath: 'search'),
  reels('/home/reels', subPath: 'reels'),
  setting('/home/setting', subPath: 'setting');

  final String path;
  final String? subPath;

  const Routes(this.path, {this.subPath});
}
