import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/presentation/main/page/main.screen.dart';
import 'package:hot_place/presentation/map/google_map.screen.dart';
import 'package:hot_place/presentation/post/page/create_post/create_post.screen.dart';
import 'package:hot_place/presentation/setting/page/edit_profile.screen.dart';

import '../../presentation/splash.screen.dart';

enum Routes {
  splash("/"),
  main("/main"),
  createPost("/post/create"),
  googleMap("/map/google"),
  editProfile("/setting/edit-profile");

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
      name: Routes.main.name,
      path: Routes.main.path,
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreen();
      },
    ),
    GoRoute(
      name: Routes.createPost.name,
      path: Routes.createPost.path,
      builder: (BuildContext context, GoRouterState state) {
        return const CreatePostScreen();
      },
    ),
    GoRoute(
      name: Routes.googleMap.name,
      path: Routes.googleMap.path,
      builder: (BuildContext context, GoRouterState state) {
        return const GoogleMapScreen();
      },
    ),
    GoRoute(
      name: Routes.editProfile.name,
      path: Routes.editProfile.path,
      builder: (BuildContext context, GoRouterState state) {
        return const EditProfileScreen();
      },
    ),
  ],
);
