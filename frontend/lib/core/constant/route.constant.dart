import 'package:go_router/go_router.dart';

enum Routes {
  splash("/"),
  main("/main");

  final String path;

  const Routes(this.path);
}

final GoRouter routerConfig = GoRouter(routes: <RouteBase>[
], initialLocation: Routes.splash.path);
