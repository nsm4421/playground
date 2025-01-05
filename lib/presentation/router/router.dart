import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/core/export.core.dart';
import 'package:my_app/domain/entity/export.entity.dart';
import 'package:my_app/domain/usecase/export.usecase.dart';
import 'package:my_app/presentation/pages/export.pages.dart';

@lazySingleton
class CustomRouter {
  final AuthUseCase _useCase;
  late ValueNotifier<bool> _isAuth;
  late Stream<UserEntity?> _authStream;
  late StreamSubscription<UserEntity?> _authSubscription;

  CustomRouter(this._useCase) {
    _isAuth = ValueNotifier(false);
    _authStream = _useCase.authStream;
    _authSubscription = _authStream.listen((data) {
      _isAuth.value = (data != null);
    });
  }

  String get _initialLocation => Routes.auth.path;

  FutureOr<String?> Function(BuildContext, GoRouterState) get _redirect =>
      (context, state) {
        final isInAuthPage = Routes.values
            .where((item) => item.path.contains('/auth'))
            .map((item) => item.path)
            .contains(state.matchedLocation);
        if (_isAuth.value && isInAuthPage) {
          return Routes.home.path;
        } else if (!_isAuth.value && !isInAuthPage) {
          return Routes.auth.path;
        }
        return null;
      };

  GoRoute get _unAuthenticatedRouter => GoRoute(
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

  Iterable<GoRoute> get _authenticatedRouters => [
        GoRoute(
            path: Routes.home.path,
            builder: (context, state) => const HomePage()),
        GoRoute(
            path: Routes.feed.path,
            builder: (context, state) => const DisplayFeedPage(),
            routes: [
              GoRoute(
                  path: Routes.createFeed.subPath!,
                  builder: (context, state) => const CreateFeedPage())
            ]),
        GoRoute(
            path: Routes.chat.path,
            builder: (context, state) => const ChatPage(),
            routes: [
              GoRoute(
                  path: Routes.groupChat.subPath ?? 'group',
                  builder: (context, state) {
                    return const Text('Group Chat');
                  },
                  routes: [
                    GoRoute(
                        path: Routes.createGroupChat.subPath ?? 'create',
                        builder: (context, state) {
                          return const CreateGroupChatPage();
                        }),
                    GoRoute(
                        path: Routes.groupChatRoom.subPath ?? 'room',
                        builder: (context, state) {
                          // TODO : chatId 사용해서 라우팅하기
                          return const GroupChatRoomPage('test');
                        }),
                  ]),
            ])
      ];

  @lazySingleton
  GoRouter get config {
    return GoRouter(
      initialLocation: _initialLocation,
      redirect: _redirect,
      refreshListenable: _isAuth,
      routes: [_unAuthenticatedRouter, ..._authenticatedRouters],
    );
  }
}
