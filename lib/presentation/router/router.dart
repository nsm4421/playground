import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/di/dependency_injection.dart';
import 'package:my_app/core/export.core.dart';
import 'package:my_app/presentation/bloc/export.bloc.dart';
import 'package:my_app/presentation/pages/export.pages.dart';

import 'router_refresh_listenable.dart';

final GoRouter routerConfig = GoRouter(
  initialLocation: Routes.auth.path,
  redirect: (context, state) async {
    final isAuth = context.read<AuthBloc>().state.isAuth;
    final isInAuthPage = Routes.values
        .where((item) => item.path.contains('/auth'))
        .map((item) => item.path)
        .contains(state.matchedLocation);
    if (isAuth && isInAuthPage) {
      log('redirect to home');
      return Routes.home.path;
    } else if (!isAuth && !isInAuthPage) {
      log('redirect to auth page');
      return Routes.auth.path;
    }
    return null;
  },
  refreshListenable: getIt<RouterRefreshListenable>(),
  routes: [
    /// auth
    GoRoute(
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
    ),

    /// home
    GoRoute(
        path: Routes.home.path, builder: (context, state) => const HomePage()),
    GoRoute(
        path: Routes.chat.path,
        builder: (context, state) => const ChatPage(),
        routes: [
          GoRoute(
              path: Routes.chatRoom.subPath ?? 'room',
              builder: (context, state) {
                return ChatRoomPage(chatId: 'test');
              }),
        ])
  ],
);
