enum RoutePath {
  splash(path: '/', label: 'splash'),
  main(path: '/main', label: 'main');

  final String path;
  final String label;

  const RoutePath({required this.path, required this.label});
}
