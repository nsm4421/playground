import 'package:go_router/go_router.dart';
import 'package:my_app/presentation/view/auth/auth.screen.dart';
import 'package:my_app/presentation/view/auth/sign_up.screen.dart';
import 'package:my_app/presentation/view/home/home.screen.dart';

import '../../../core/enums/route.enum.dart';
import 'intro.screen.dart';
import 'splash.screen.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: RoutePath.splash.path,
    name: RoutePath.splash.label,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: RoutePath.intro.path,
    name: RoutePath.intro.label,
    builder: (context, state) => const IntroScreen(),
  ),
  GoRoute(
      path: RoutePath.auth.path,
      name: RoutePath.auth.label,
      builder: (context, state) => const AuthScreen()),
  GoRoute(
      path: RoutePath.signUp.path,
      name: RoutePath.signUp.label,
      builder: (context, state) => const SignUpScreen()),
  GoRoute(
      path: RoutePath.home.path,
      name: RoutePath.home.label,
      builder: (context, state) => const HomeScreen())
], initialLocation: RoutePath.splash.path);
