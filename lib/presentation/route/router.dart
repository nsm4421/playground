import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../../core/constant/constant.dart';
import '../../core/util/util.dart';
import '../bloc/auth/authentication.bloc.dart';
import '../bloc/bloc_module.dart';
import '../view/auth/page.dart';
import '../view/diary/display/page.dart';
import '../view/diary/edit/page.dart';
import '../view/home/page.dart';
import '../view/meeting/create/page.dart';
import '../view/meeting/page.dart';
import '../view/search/page.dart';
import '../view/setting/edit/page.dart';
import '../view/setting/page.dart';
import '../widgets/widgets.dart';

part 'paths.dart';

part 'auth_notifier.dart';

@lazySingleton
class CustomRouter {
  late GlobalKey<NavigatorState> _rootNavigatorKey;

  GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

  final AuthStateNotifier _authStateNotifier;

  CustomRouter(this._authStateNotifier) {
    _rootNavigatorKey =
        GlobalKey<NavigatorState>(debugLabel: 'root-navigator-key');
  }

  @lazySingleton
  GoRouter get routerConfig => GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: Routes.auth.path,
      routes: [
        _authRouter,
        _homeRouter,
        GoRoute(
            path: Routes.createMeeting.path,
            builder: (context, state) => const CreateMeetingPage()),
        GoRoute(
            path: Routes.editProfile.path,
            builder: (context, state) => const EditProfilePage()),
      ],
      redirect: _redirect,
      refreshListenable: _authStateNotifier);

  GoRoute get _authRouter => GoRoute(
      path: Routes.auth.path, builder: (context, state) => const AuthPage());

  StatefulShellRoute get _homeRouter => StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state, navigationShell) {
        return HomePage(navigationShell);
      },
      branches: HomeBottomNavItems.values
          .map((item) => StatefulShellBranch(routes: [
                GoRoute(
                    path: item.route.path,
                    pageBuilder: (context, state) {
                      return switch (item) {
                        HomeBottomNavItems.displayDiary =>
                          const NoTransitionPage(child: DisplayDiariesPage()),
                        HomeBottomNavItems.writeDiary =>
                          const NoTransitionPage(child: EditDiaryPage()),
                        HomeBottomNavItems.meeting =>
                          const NoTransitionPage(child: MeetingPage()),
                        HomeBottomNavItems.search =>
                          const NoTransitionPage(child: SearchPage()),
                        HomeBottomNavItems.setting =>
                          const NoTransitionPage(child: SettingPage()),
                        (_) => const NoTransitionPage(
                            child: Center(child: PageNotFoundedScreen()))
                      };
                    })
              ]))
          .toList());

  String? Function(BuildContext, GoRouterState) get _redirect =>
      (context, state) {
        final authenticated = context.read<AuthenticationBloc>().state.step ==
            AuthenticationStep.authorized;
        final isInAuthPage = Routes.values
            .where((item) => item.path.contains('/auth'))
            .map((item) => item.path)
            .contains(state.matchedLocation);
        if (authenticated && isInAuthPage) {
          customUtil.logger.d('로그인했는데 인증페이지에 있는 경우, 홈화면으로 redirect');
          return Routes.home.path;
        } else if (!authenticated && !isInAuthPage) {
          customUtil.logger.d('로그인 안했는데 인증페이지에 없는 경우, 인증페이지로 redirect');
          return Routes.auth.path;
        }
        return null;
      };
}
