import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/presentation/pages/entry.screen.dart';
import 'package:my_app/presentation/pages/main/short/upload/upload_short.screen.dart';
import 'package:my_app/presentation/pages/splash.screen.dart';

enum Routes {
  splash("/splash"),
  entry("/"),
  uploadShort("shorts/upload");

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
      name: Routes.entry.name,
      path: Routes.entry.path,
      builder: (BuildContext context, GoRouterState state) {
        return const EntryScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          name: Routes.uploadShort.name,
          path: Routes.uploadShort.path,
          builder: (BuildContext context, GoRouterState state) {
            return const UploadShortScreen();
          },
        ),
      ]),
], initialLocation: Routes.splash.path);
