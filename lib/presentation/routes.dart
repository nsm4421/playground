import 'package:go_router/go_router.dart';
import 'package:my_app/presentation/main.screen.dart';
import 'package:my_app/presentation/view/splash.screen.dart';

import '../core/enums/route.enum.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: RoutePath.splash.path,
    name: RoutePath.splash.label,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: RoutePath.main.path,
    name: RoutePath.main.label,
    builder: (context, state) => const MainScreen(),
  ),
], initialLocation: RoutePath.splash.path);
