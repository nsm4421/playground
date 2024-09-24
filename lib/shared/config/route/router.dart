import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/auth.export.dart';
import '../../../auth/presentation/pages/sign_in/sign_in.page.dart';
import '../../../auth/presentation/pages/sign_up/sign_up.page.dart';
import '../../../chat/chat.export.dart';
import '../../../feed/feed.export.dart';
import '../../../home/home.export.dart';
import '../../../search/search.export.dart';
import '../../../setting/setting.export.dart';
import '../../shared.export.dart';

part 'route_paths.dart';

part 'auth_notifier.dart';

@lazySingleton
class CustomRoute {
  late GlobalKey<NavigatorState> _rootNavigatorKey;

  final AuthStateNotifier _authStateNotifier; // 인증상태가 변경 시 이를 감지하여, 라우팅을 처리

  CustomRoute(this._authStateNotifier) {
    _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  }

  /// router 세팅
  GoRouter get routerConfig => GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: RoutePaths.auth.path,
      routes: [
        _authRouter,
        _homeRouter,
        // 프로필 수정
        GoRoute(
            path: RoutePaths.editProfile.path,
            builder: (context, state) => const EditProfilePage())
      ],
      redirect: _redirect,
      refreshListenable: _authStateNotifier);

  /// 인증
  GoRoute get _authRouter => GoRoute(
          path: RoutePaths.auth.path,
          builder: (context, state) => const SignInPage(),
          routes: [
            // 회원가입
            GoRoute(
                path: RoutePaths.signUp.subpath!,
                builder: (context, state) => const SignUpPage())
          ]);

  /// 홈화면
  StatefulShellRoute get _homeRouter => StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state, navigationShell) {
        return HomePage(navigationShell);
      },
      branches: HomeBottomNavItem.values
          .map((item) => StatefulShellBranch(routes: [
                GoRoute(
                    path: item.path,
                    pageBuilder: (context, state) {
                      return switch (item) {
                        HomeBottomNavItem.feed =>
                          const NoTransitionPage(child: FeedPage()),
                        HomeBottomNavItem.search =>
                          const NoTransitionPage(child: SearchPage()),
                        HomeBottomNavItem.createMedia =>
                          const NoTransitionPage(child: CreateFeedPage()),
                        HomeBottomNavItem.chat =>
                          const NoTransitionPage(child: ChatPage()),
                        HomeBottomNavItem.setting =>
                          const NoTransitionPage(child: SettingPage()),
                      };
                    })
              ]))
          .toList());

  /// 리다이렉션
  String? Function(BuildContext, GoRouterState) get _redirect =>
      (context, state) {
        final authenticated =
            context.read<AuthenticationBloc>().state.authStatus ==
                AuthStatus.authenticated;
        final isInAuthPage = RoutePaths.values
            .where((item) => item.path.contains('/auth'))
            .map((item) => item.path)
            .contains(state.matchedLocation);

        if (authenticated && isInAuthPage) {
          // 로그인했는데 인증페이지에 있는 경우, 홈화면으로 redirect
          return RoutePaths.feed.path;
        } else if (!authenticated && !isInAuthPage) {
          // 로그인 안했는데 인증페이지에 없는 경우, 인증페이지로 redirect
          return RoutePaths.auth.path;
        }

        return null;
      };
}
