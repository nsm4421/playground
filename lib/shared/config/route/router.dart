import 'package:flutter/material.dart';
import 'package:flutter_app/auth/auth.export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/presentation/pages/sign_in/sign_in.page.dart';
import '../../../auth/presentation/pages/sign_up/sign_up.page.dart';
import '../../../home/home.export.dart';
import '../../shared.export.dart';

part 'route_paths.dart';
part 'auth_notifier.dart';

final routerConfig = GoRouter(
    initialLocation: RoutePaths.auth.path,
    routes: [
      // 인증
      GoRoute(
          path: RoutePaths.auth.path,
          builder: (context, state) => const SignInPage(),
          routes: [
            // 회원가입
            GoRoute(
                path: RoutePaths.signUp.subpath!,
                builder: (context, state) => const SignUpPage())
          ]),
      // 인증
      GoRoute(
          path: RoutePaths.home.path,
          builder: (context, state) => const HomePage()),
    ],
    redirect: (context, state) {
      final authenticated =
          context.read<AuthenticationBloc>().state.authStatus ==
              AuthStatus.authenticated;
      final isInAuthPage = RoutePaths.values
          .where((item) => item.path.contains('/auth'))
          .map((item) => item.path)
          .contains(state.matchedLocation);

      if (authenticated && isInAuthPage) {
        return RoutePaths.home.path;
      } else if (!authenticated && !isInAuthPage) {
        return RoutePaths.auth.path;
      }

      return null;
    },
    refreshListenable:
        AuthStateNotifier(getIt<AuthenticationBloc>().userStream));
