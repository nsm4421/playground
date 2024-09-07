import 'package:go_router/go_router.dart';

import '../../../auth/presentation/pages/sign_in/sign_in.page.dart';
import '../../../auth/presentation/pages/sign_up/sign_up.page.dart';

part 'route_paths.dart';

final routerConfig = GoRouter(initialLocation: RoutePaths.auth.path, routes: [
  // 인증
  GoRoute(
      path: RoutePaths.auth.path,
      builder: (context, state) => const SignInPage(),
      routes: [
        // 로그인
        GoRoute(
            path: RoutePaths.signIn.subpath!,
            builder: (context, state) => const SignInPage()),
        // 회원가입
        GoRoute(
            path: RoutePaths.signUp.subpath!,
            builder: (context, state) => const SignUpPage())
      ])
]);
