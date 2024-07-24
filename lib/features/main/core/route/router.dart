import 'package:go_router/go_router.dart';
import 'package:portfolio/features/chat/presentation/pages/open_chat/create_open_chat.page.dart';
import 'package:portfolio/features/chat/presentation/pages/open_chat/open_chat.page.dart';
import '../../../auth/presentation/pages/sign_up/sign-up.page.dart';
import '../../presentation/pages/main.page.dart';
import '../../presentation/pages/splash/splash.page.dart';

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
  /// 오픈 채팅
  GoRoute(
      path: RoutePaths.openChat.path,
      name: 'open-chat',
      builder: (context, state) => const OpenChatPage(),
      routes: [
        GoRoute(
          path: RoutePaths.createOpenChat.subPath!,
          name: 'create-open-chat',
          builder: (context, state) => const CreateOpenChatPage(),
        ),
      ]),
], initialLocation: RoutePaths.splash.path);
