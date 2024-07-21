import 'package:go_router/go_router.dart';
import 'package:portfolio/features/common/presentation/pages/main.page.dart';
import '../../features/auth/presentation/pages/sign_up/sign-up.page.dart';
import '../../features/common/presentation/pages/splash.page.dart';

part "route_path.dart";

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: RoutePaths.splash.path,
    name: 'splash',
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: RoutePaths.signUp.path,
    name: 'sign-up',
    builder: (context, state) => const SignUpPage(),
  ),
  GoRoute(
    path: RoutePaths.main.path,
    name: 'main',
    builder: (context, state) => const MainPage(),
  ),
], initialLocation: RoutePaths.splash.path);
