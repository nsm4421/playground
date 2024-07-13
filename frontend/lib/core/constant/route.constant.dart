import 'package:go_router/go_router.dart';
import 'package:hot_place/presentation/index.page.dart';

enum Routes {
  splash("/"),
  main("/main");

  final String path;

  const Routes(this.path);
}

final GoRouter routerConfig = GoRouter(routes: <RouteBase>[
  GoRoute(path: "/", builder: (_, __) => const IndexPage())
], initialLocation: Routes.splash.path);
