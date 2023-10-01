import '../pages/splash/splash_page.dart';
import '../pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_path.dart';

final GoRouter router = GoRouter(
  routes: [
    // splash page
    GoRoute(
      path: RoutePath.splash.path,
      name: RoutePath.splash.name,
      builder: (BuildContext context, GoRouterState state) =>
          const SplashPage(),
    ),
    // home page
    GoRoute(
      path: RoutePath.home.path,
      name: RoutePath.home.name,
      builder: (BuildContext context, GoRouterState state) => const HomePage(),
    ),
  ],
  initialLocation: '/splash',
);
