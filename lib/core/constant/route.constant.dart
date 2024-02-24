import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/presentation/home.screen.dart';
import 'package:hot_place/presentation/auth/page/login.screen.dart';
import '../../presentation/splash.screen.dart';

enum Routes {
  // splash
  init("/"),

  // login page
  login("/login"),

  // home
  home("/home"),

  // setting
  setting("/setting"),

  // chat
  chat("/chat");

  final String path;

  const Routes(this.path);
}

final GoRouter routerConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: Routes.init.name,
      path: Routes.init.path,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      name: Routes.login.name,
      path: Routes.login.path,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      name: Routes.home.name,
      path: Routes.home.path,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      name: Routes.chat.name,
      path: Routes.chat.path,
      builder: (BuildContext context, GoRouterState state) {
        return const Text("TEST");
      },
    ),
    GoRoute(
      name: Routes.setting.name,
      path: Routes.setting.path,
      builder: (BuildContext context, GoRouterState state) {
        return const Text("TEST");
      },
    ),
  ],
);
