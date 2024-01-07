enum RoutePath {
  splash(path: '/splash', label: 'splash'),
  intro(path: '/intro', label: 'intro'),
  auth(path: '/auth', label: 'auth'),
  home(path: '/home', label: 'home')
;
  final String path;
  final String label;

  const RoutePath({required this.path, required this.label});
}
