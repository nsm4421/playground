import 'package:go_router/go_router.dart';
import 'package:my_app/presentation/pages/home/home.screen.dart';

import '../pages/splash/splash.screen.dart';

final GoRouter routerConfig = GoRouter(
  initialLocation: "/splash",
  routes: [
    GoRoute(
      path: '/splash',
      name: "splash",
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      name: "home",
      builder: (_, __) => const HomeScreen(),
    ),
  ],
);
