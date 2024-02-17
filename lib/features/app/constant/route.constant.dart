import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/features/splash/chat.screen.dart';
import 'package:hot_place/features/splash/home.screen.dart';
import 'package:hot_place/features/splash/setting.screen.dart';
import 'package:hot_place/features/user/presentation/page/login.screen.dart';
import 'package:hot_place/features/user/presentation/page/otp.screen.dart';

import '../../splash/splash.screen.dart';
import '../../splash/welcome.screen.dart';

enum Routes {
  // splash
  init("/"),

  // authentication
  welcome("/welcome"),
  otp("/auth/otp"),
  login("/auth/login"),
  onboarding("/auth/onboarding"),

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
      name: Routes.otp.name,
      path: Routes.otp.path,
      builder: (BuildContext context, GoRouterState state) {
        return const OtpScreen();
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
