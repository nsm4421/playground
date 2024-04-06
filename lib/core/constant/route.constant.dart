import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/presentation/auth/page/sign_up/sign_up.screen.dart';
import 'package:hot_place/presentation/feed/page/upload/upload_feed.screen.dart';
import 'package:hot_place/presentation/main/page/main.screen.dart';
import 'package:hot_place/presentation/setting/page/edit_profile.screen.dart';

import '../../presentation/main/page/splash.screen.dart';

enum Routes {
  splash("/"),
  main("/main"),
  signUp("/sign-up"),
  uploadFeed("/upload-feed"),
  editProfile("/edit-profile");

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
    name: Routes.uploadFeed.name,
    path: Routes.uploadFeed.path,
    builder: (BuildContext context, GoRouterState state) {
      return const UploadFeedScreen();
    },
  ),
  GoRoute(
    name: Routes.editProfile.name,
    path: Routes.editProfile.path,
    builder: (BuildContext context, GoRouterState state) {
      return const EditProfileScreen();
    },
  )
], initialLocation: Routes.splash.path);
