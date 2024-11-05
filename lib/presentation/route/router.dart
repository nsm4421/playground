import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:travel/core/constant/constant.dart';
import 'package:travel/core/util/logger/logger.dart';
import 'package:travel/presentation/bloc/auth/presence/bloc.dart';
import 'package:travel/presentation/view/auth/index.dart';
import 'package:travel/presentation/view/auth/sign_up/index.dart';
import 'package:travel/presentation/view/home/create_media/index.dart';
import 'package:travel/presentation/view/home/feed/index.dart';
import 'package:travel/presentation/view/home/index.dart';

import 'util.dart';
import 'routes.dart';

@lazySingleton
class CustomRouter with CustomLogger {
  final AuthStateNotifier _authStateNotifier;
  late GlobalKey<NavigatorState> _rootNavigatorKey;

  CustomRouter(this._authStateNotifier) {
    _rootNavigatorKey =
        GlobalKey<NavigatorState>(debugLabel: 'root-navigator-key');
  }

  @lazySingleton
  GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

  @lazySingleton
  GoRouter get routerConfig => GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: Routes.auth.path,
      routes: [_authRouter, _homeRouter],
      redirect: _redirect,
      refreshListenable: _authStateNotifier);

  StatefulShellRoute get _homeRouter => StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state, navigationShell) {
          return HomePage(navigationShell);
        },
        branches: HomeBottomNavItem.values
            .map(
              (item) => StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: switch (item) {
                      HomeBottomNavItem.feed => Routes.feed.path,
                      HomeBottomNavItem.createMedia => Routes.createMedia.path,
                    },
                    pageBuilder: _pageBuilder(
                      switch (item) {
                        HomeBottomNavItem.feed => const FeedPage(),
                        HomeBottomNavItem.createMedia =>
                          const CreateMediaPage(),
                      },
                    ),
                  )
                ],
              ),
            )
            .toList(),
      );

  GoRoute get _authRouter => GoRoute(
        path: Routes.auth.path,
        pageBuilder: _pageBuilder(const AuthPage()),
        routes: [
          GoRoute(
            path: Routes.signUp.subPath ?? 'sign-up',
            pageBuilder: _pageBuilder(const SignUpPage()),
          ),
        ],
      );

  String? Function(BuildContext, GoRouterState) get _redirect =>
      (context, state) {
        final authenticated =
            context.read<AuthenticationBloc>().state.authenticated;
        final isInAuthPage = Routes.values
            .where((item) => item.path.contains('/auth'))
            .map((item) => item.path)
            .contains(state.matchedLocation);
        if (authenticated && isInAuthPage) {
          return Routes.feed.path;
        } else if (!authenticated && !isInAuthPage) {
          return Routes.auth.path;
        }
        return null;
      };

  Page<T> Function(BuildContext, GoRouterState) _pageBuilder<T>(Widget child) =>
      (context, state) {
        return CustomTransitionPage(
          child: child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      };
}
