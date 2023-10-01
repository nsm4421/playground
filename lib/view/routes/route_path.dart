class RouteItem {
  final String path;
  final String name;

  RouteItem({required this.path, required this.name});
}

/// Define routing path
class RoutePath {
  static final RouteItem splash = RouteItem(path: '/splash', name: 'splash');
  static final RouteItem home = RouteItem(path: '/home', name: 'home');
}
