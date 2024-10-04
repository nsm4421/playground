import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel/domain/entity/auth/presence.dart';
import 'package:travel/presentation/bloc/auth/authentication.bloc.dart';
import 'package:travel/presentation/view/auth/auth.page.dart';
import 'package:travel/presentation/view/main_view/index.page.dart';

import '../../core/di/dependency_injection.dart';
import '../view/diary/edit/edit_diary.page.dart';

part 'paths.dart';

part 'auth_notifier.dart';

final routerConfig = GoRouter(
    initialLocation: Routes.auth.path,
    routes: [
      GoRoute(
          path: Routes.auth.path,
          builder: (context, state) => const AuthPage()),
      GoRoute(
          path: Routes.home.path,
          builder: (context, state) => const MainView()),
      GoRoute(
          path: Routes.editDiary.path,
          builder: (context, state) => const EditDiaryPage())
    ],

    /// 인증 상태에 따라 redirection
    redirect: (context, state) {
      final authenticated = context.read<AuthenticationBloc>().state.step ==
          AuthenticationStep.authorized;
      final isInAuthPage = Routes.values
          .where((item) => item.path.contains('/auth'))
          .map((item) => item.path)
          .contains(state.matchedLocation);
      if (authenticated && isInAuthPage) {
        // 로그인했는데 인증페이지에 있는 경우, 홈화면으로 redirect
        return Routes.home.path;
      } else if (!authenticated && !isInAuthPage) {
        // 로그인 안했는데 인증페이지에 없는 경우, 인증페이지로 redirect
        return Routes.auth.path;
      }
      return null;
    },

    /// 인증 상태 listener
    refreshListenable:
        AuthStateNotifier(getIt<AuthenticationBloc>().authStateStream));
