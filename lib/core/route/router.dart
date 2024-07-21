import 'package:go_router/go_router.dart';

import '../../splash.page.dart';

part "route_path.dart";

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePaths.splash.path,
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
  ],
  initialLocation: RoutePaths.splash.path
);