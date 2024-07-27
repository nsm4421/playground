import 'package:go_router/go_router.dart';
import 'package:portfolio/features/chat/domain/entity/open_chat.entity.dart';
import 'package:portfolio/features/chat/presentation/pages/open_chat/create/create_open_chat.page.dart';
import 'package:portfolio/features/chat/presentation/pages/open_chat/display/display_open_chat.page.dart';
import 'package:portfolio/features/chat/presentation/pages/open_chat/chat_room/open_chat_room.page.dart';
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
      builder: (context, state) => const DisplayOpenChatPage(),
      routes: [
        GoRoute(
          path: RoutePaths.openChatRoom.subPath!,
          name: 'open-chat-room',
          builder: (context, state) {
            final chat = state.extra as OpenChatEntity;
            return OpenChatRoomPage(chat);
          },
        ),
        GoRoute(
          path: RoutePaths.createOpenChat.subPath!,
          name: 'create-open-chat',
          builder: (context, state) => const CreateOpenChatPage(),
        ),
      ]),
], initialLocation: RoutePaths.splash.path);
