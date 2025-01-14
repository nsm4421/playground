import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/export.core.dart';
import 'package:my_app/domain/entity/export.entity.dart';
import 'package:my_app/domain/usecase/export.usecase.dart';
import 'package:my_app/presentation/pages/export.pages.dart';

@injectable
class CustomRouter {
  final AuthUseCase _useCase;
  late ValueNotifier<bool> _isAuth;
  late Stream<UserEntity?> _authStream;
  late StreamSubscription<UserEntity?> _authSubscription;

  late final GlobalKey<NavigatorState> _rootNavigatorKey;

  CustomRouter(this._useCase) {
    _isAuth = ValueNotifier(false);
    _authStream = _useCase.authStream;
    _authSubscription = _authStream.listen((data) {
      _isAuth.value = (data != null);
    });
    _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  }

  String get _initialLocation => Routes.auth.path;

  FutureOr<String?> Function(BuildContext, GoRouterState) get _redirect =>
      (context, state) {
        final isInAuthPage = Routes.values
            .where((item) => item.path.contains('/auth'))
            .map((item) => item.path)
            .contains(state.matchedLocation);
        if (_isAuth.value && isInAuthPage) {
          return HomeBottomNavItems.values.first.route.path;
        } else if (!_isAuth.value && !isInAuthPage) {
          return Routes.auth.path;
        }
        return null;
      };

  GoRoute get _authRouter => GoRoute(
        path: Routes.auth.path,
        builder: (context, state) => const AuthPage(),
        routes: [
          GoRoute(
            path: Routes.signUp.subPath ?? 'sign-up',
            builder: (context, state) => const SignUpPage(),
          ),
          GoRoute(
            path: Routes.signIn.subPath ?? 'sign-in',
            builder: (context, state) => const SignInPage(),
          ),
        ],
      );

  StatefulShellRoute get _homeRouter => StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state, navigationShell) {
        return NoTransitionPage(child: HomePage(navigationShell));
      },
      branches: HomeBottomNavItems.values
          .map((item) => switch (item) {
                /// feed
                HomeBottomNavItems.feed => StatefulShellBranch(routes: [
                    GoRoute(
                      path: Routes.feed.path,
                      pageBuilder: (context, state) {
                        return const NoTransitionPage(child: DisplayFeedPage());
                      },
                    )
                  ]),

                /// chat
                HomeBottomNavItems.chat => StatefulShellBranch(
                    routes: [
                      GoRoute(
                        path: Routes.chat.path,
                        pageBuilder: (context, state) {
                          return const NoTransitionPage(
                              child: DisplayGroupChatPage());
                        },
                      )
                    ],
                  ),

                /// setting
                HomeBottomNavItems.setting => StatefulShellBranch(routes: [
                    GoRoute(
                        path: Routes.setting.path,
                        pageBuilder: (context, state) {
                          return const NoTransitionPage(child: SettingPage());
                        })
                  ])
              })
          .toList());

  Iterable<RouteBase> get _routes => [
        GoRoute(
            path: Routes.createFeed.path,
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: CreateFeedPage());
            }),
        GoRoute(
            path: Routes.createGroupChat.path,
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: CreateGroupChatPage());
            }),
        GoRoute(
          path: Routes.groupChatRoom.path,
          pageBuilder: (context, state) {
            try {
              return NoTransitionPage(
                child: GroupChatRoomPage(
                  state.extra as GroupChatEntity,
                ),
              );
            } catch (error) {
              log(error.toString());
              return NoTransitionPage(
                child: Text(
                  "Chat Room Not Founded",
                  style: context.textTheme.displayLarge,
                ),
              );
            }
          },
        ),
      ];

  @lazySingleton
  GoRouter get config {
    return GoRouter(
      initialLocation: _initialLocation,
      navigatorKey: _rootNavigatorKey,
      redirect: _redirect,
      refreshListenable: _isAuth,
      routes: [_authRouter, _homeRouter, ..._routes],
    );
  }
}
