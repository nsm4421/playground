import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/presentation/auth/page/sign_up/sign_up.screen.dart';
import 'package:hot_place/presentation/home.screen.dart';

import '../../presentation/auth/page/sign_in/sign_in.screen.dart';
import '../../presentation/splash.screen.dart';

enum Routes {
  splash("/"),
  home("/home"),
  signIn("/sign-in"),
  signUp("/sign-up");

  final String path;

  const Routes(this.path);
}

final GoRouter routerConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: Routes.splash.name,
      path: Routes.splash.path,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
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
      name: Routes.signUp.name,
      path: Routes.signUp.path,
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpScreen();
      },
    ),
    GoRoute(
      name: Routes.signIn.name,
      path: Routes.signIn.path,
      builder: (BuildContext context, GoRouterState state) {
        return const SignInScreen();
      },
    )
  ],
);
