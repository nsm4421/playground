import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/sign_in.page.dart';
import '../../splash.page.dart';

part "route_path.dart";

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutePaths.splash.path,
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RoutePaths.auth.path,
      name: 'auth',
      builder: (context, state) => const SignInPage(),
    ),
  ],
  initialLocation: RoutePaths.splash.path
);