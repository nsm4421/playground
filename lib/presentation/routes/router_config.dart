import 'package:go_router/go_router.dart';
import 'package:my_app/core/constant/enums/routes.enum.dart';
import 'package:my_app/presentation/main/main.screen.dart';
import 'package:my_app/presentation/pages/auth/sign-in/sign_in.screen.dart';
import 'package:my_app/presentation/pages/auth/sign-up/sign_up.screen.dart';

import '../pages/splash/splash.screen.dart';

final GoRouter routerConfig = GoRouter(
  initialLocation: Routes.splash.path,
  routes: [
    GoRoute(
      path: Routes.splash.path,
      name: Routes.splash.name,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.signIn.path,
      name: Routes.signIn.name,
      builder: (_, __) => const SignInScreen(),
    ),
    GoRoute(
      path: Routes.signUp.path,
      name: Routes.signUp.name,
      builder: (_, __) => const SignUpScreen(),
    ),
    GoRoute(
      path: Routes.main.path,
      name: Routes.main.name,
      builder: (_, __) => const MainScreen(),
    ),
  ],
);
