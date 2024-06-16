import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/data/entity/chat/open_chat/open_chat.entity.dart';
import 'package:my_app/presentation/pages/auth/sign_up_with_email.screen.dart';
import 'package:my_app/presentation/pages/entry.page.dart';
import 'package:my_app/presentation/pages/main/chat/open/create/create_open_chat.page.dart';
import 'package:my_app/presentation/pages/main/chat/open/open_chat.page.dart';
import 'package:my_app/presentation/pages/main/chat/open/room/open_chat_room.page.dart';
import 'package:my_app/presentation/pages/main/feed/upload/upload_feed.page.dart';
import 'package:my_app/presentation/pages/main/setting/edit/edit_profile.page.dart';
import 'package:my_app/presentation/pages/splash.page.dart';

enum Routes {
  /// auth
  signUpWithEmailAndPassword("/auth/sign-up"),

  /// main
  splash("/splash"),
  entry("/"),

  /// feed
  uploadFeed("/feed/upload"),

  /// chat
  openChat("/chat/open"),
  createOpenChat("/chat/open/create"),
  openChatRoom("/chat/open/chat-room"),

  /// setting
  editProfile("/setting/edit");

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
    name: Routes.editProfile.name,
    path: Routes.editProfile.path,
    builder: (context, state) {
      return const EditProfilePage();
    },
  ),

  /// chat
  GoRoute(
    name: Routes.openChat.name,
    path: Routes.openChat.path,
    builder: (context, state) {
      return const OpenChatPage();
    },
  ),
  GoRoute(
    name: Routes.createOpenChat.name,
    path: Routes.createOpenChat.path,
    builder: (context, state) {
      return const CreateOpenChatPage();
    },
  ),
  GoRoute(
    name: Routes.openChatRoom.name,
    path: Routes.openChatRoom.path,
    builder: (context, state) {
      final openChat = state.extra as OpenChatEntity;
      return OpenChatRoomPage(openChat);
    },
  ),
], initialLocation: Routes.splash.path);
