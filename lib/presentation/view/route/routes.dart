import 'package:go_router/go_router.dart';
import 'package:my_app/presentation/view/auth/auth.screen.dart';
import 'package:my_app/presentation/view/auth/sign_up.screen.dart';
import 'package:my_app/presentation/view/main/main.screen.dart';
import 'package:my_app/presentation/view/main/profile/edit_profile.screen.dart';
import 'package:my_app/presentation/view/route/splash.screen.dart';

import '../../../core/enums/route.enum.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: RoutePath.splash.path,
    name: RoutePath.splash.label,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
      path: RoutePath.signIn.path,
      name: RoutePath.signIn.label,
      builder: (context, state) => const AuthScreen()),
  GoRoute(
      path: RoutePath.signUp.path,
      name: RoutePath.signUp.label,
      builder: (context, state) => const SignUpScreen()),
  GoRoute(
      path: RoutePath.main.path,
      name: RoutePath.main.label,
      builder: (context, state) => const MainScreen()),
  GoRoute(
      path: RoutePath.editProfile.path,
      name: RoutePath.editProfile.label,
      builder: (context, state) => const EditProfileScreen()),
], initialLocation: RoutePath.splash.path);
