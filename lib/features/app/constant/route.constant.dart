import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/features/splash/chat.screen.dart';
import 'package:hot_place/features/splash/home.screen.dart';
import 'package:hot_place/features/splash/setting.screen.dart';
import 'package:hot_place/features/user/presentation/view/page/sign_up/sign_up.screen.dart';
import 'package:hot_place/features/user/presentation/view/page/login/welcome.screen.dart';

import '../../user/presentation/view/page/login/login.screen.dart';
import '../../user/presentation/view/page/splash/splash.screen.dart';

enum Routes {
  // splash
  init("/"),

  welcome("/welcome"),
  login("/auth/login"),

  // sign up
  signUp("/auth/sign-up"),

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
      name: Routes.welcome.name,
      path: Routes.welcome.path,
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomeScreen();
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
      name: Routes.signUp.name,
      path: Routes.signUp.path,
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpScreen();
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
        return const ChatScreen();
      },
    ),
    GoRoute(
      name: Routes.setting.name,
      path: Routes.setting.path,
      builder: (BuildContext context, GoRouterState state) {
        return const SettingScreen();
      },
    ),
  ],
);
