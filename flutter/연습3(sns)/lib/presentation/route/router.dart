import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/index/index.page.dart';

part 'route_paths.dart';

class CustomRoute {
  late GlobalKey<NavigatorState> _rootNavigatorKey;

  CustomRoute() {
    _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  }

  /// router 세팅
  GoRouter get routerConfig => GoRouter(
          navigatorKey: _rootNavigatorKey,
          initialLocation: RoutePaths.indexPage.path,
          routes: [
            // 프로필 수정
            GoRoute(
                path: RoutePaths.indexPage.path,
                builder: (context, state) => const IndexPage())
          ]);
}
