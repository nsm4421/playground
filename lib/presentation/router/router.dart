import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/core/export.core.dart';
import 'package:my_app/presentation/bloc/export.bloc.dart';
import 'package:my_app/presentation/pages/export.pages.dart';

final GoRouter routerConfig = GoRouter(
  initialLocation: Routes.auth.path,
  redirect: (context, state) async {
    final authenticated = context.read<AuthBloc>().authenticated;
    final isInAuthPage = Routes.values
        .where((item) => item.path.contains('/auth'))
        .map((item) => item.path)
        .contains(state.matchedLocation);
    if (authenticated && isInAuthPage) {
      log('redirect to home');
      return Routes.home.path;
    } else if (!authenticated && !isInAuthPage) {
      log('redirect to auth page');
      return Routes.auth.path;
    }
    return null;
  },
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
        path: Routes.home.path, builder: (context, state) => const HomePage())
  ],
);
