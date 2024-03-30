import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/presentation/auth/page/sign_up/sign_up.screen.dart';
import 'package:hot_place/presentation/main/page/on_login.screen.dart';
import 'package:hot_place/presentation/main/page/main.screen.dart';

import '../../presentation/auth/page/sign_in/sign_in.screen.dart';
import '../../presentation/main/page/splash.screen.dart';

enum Routes {
  splash("/"),
  main("/main"),
  home("/home"),
  signIn("/sign-in"),
  signUp("/sign-up");

  final String path;

  const Routes(this.path);
}

final GoRouter routerConfig = GoRouter(routes: <RouteBase>[
  GoRoute(
    name: Routes.splash.name,
    path: Routes.splash.path,
    builder: (BuildContext context, GoRouterState state) {
      return const SplashScreen();
    },
  ),
  GoRoute(
    name: Routes.main.name,
    path: Routes.main.path,
    builder: (BuildContext context, GoRouterState state) {
      return const MainScreen();
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
], initialLocation: Routes.splash.path);
