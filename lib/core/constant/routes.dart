import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/data/entity/chat/base/chat.entity.dart';
import 'package:my_app/presentation/pages/auth/sign_up_with_email.screen.dart';
import 'package:my_app/presentation/pages/entry.page.dart';
import 'package:my_app/presentation/pages/main/chat/room/chat_room.page.dart';
import 'package:my_app/presentation/pages/main/feed/upload/upload_feed.page.dart';
import 'package:my_app/presentation/pages/splash.page.dart';

enum Routes {
  splash("/splash"),
  signUpWithEmailAndPassword("/auth/sign-up"),
  entry("/"),
  uploadFeed("/feed/upload"),
  chatRoom("/chat/:chatId");

  final String path;

  const Routes(this.path);
}

final GoRouter routerConfig = GoRouter(routes: <RouteBase>[
  GoRoute(
    name: Routes.splash.name,
    path: Routes.splash.path,
    builder: (BuildContext context, GoRouterState state) {
      return const SplashPage();
    },
  ),
  GoRoute(
      name: Routes.entry.name,
      path: Routes.entry.path,
      builder: (BuildContext context, GoRouterState state) {
        return const EntryPage();
      }),
  GoRoute(
      name: Routes.signUpWithEmailAndPassword.name,
      path: Routes.signUpWithEmailAndPassword.path,
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpWithEmailAndPasswordScreen();
      }),
  GoRoute(
    name: Routes.uploadFeed.name,
    path: Routes.uploadFeed.path,
    builder: (BuildContext context, GoRouterState state) {
      return const UploadFeedPage();
    },
  ),
  GoRoute(
    name: Routes.chatRoom.name,
    path: Routes.chatRoom.path,
    builder: (context, state) {
      final chat = state.extra as ChatEntity;
      return ChatRoomPage(chat);
    },
  )
], initialLocation: Routes.splash.path);
