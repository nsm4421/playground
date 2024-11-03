import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'util.dart';
import '../view/auth/index.dart';
import '../view/auth/sign_up/index.dart';
import 'routes.dart';

@lazySingleton
class CustomRouter {
  late GlobalKey<NavigatorState> _rootNavigatorKey;

  CustomRouter() {
    _rootNavigatorKey =
        GlobalKey<NavigatorState>(debugLabel: 'root-navigator-key');
  }

  GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

  @lazySingleton
  GoRouter get routerConfig => GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: Routes.auth.path,
        routes: [
          _authRouter,
        ],
      );

  GoRoute get _authRouter => GoRoute(
        path: Routes.auth.path,
        pageBuilder: CustomRouteUtil<dynamic>().pageBuilder(const AuthPage()),
        routes: [
          GoRoute(
            path: Routes.signUp.subPath ?? 'sign-up',
            pageBuilder:
                CustomRouteUtil<dynamic>().pageBuilder(const SignUpPage()),
          ),
        ],
      );
}
