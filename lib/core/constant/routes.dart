import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/presentation/pages/auth/sign_up_with_email.screen.dart';
import 'package:my_app/presentation/pages/entry.page.dart';
import 'package:my_app/presentation/pages/main/chat/open/open_chat.page.dart';
import 'package:my_app/presentation/pages/main/feed/upload/upload_feed.page.dart';
import 'package:my_app/presentation/pages/main/setting/edit/edit_profile.page.dart';
import 'package:my_app/presentation/pages/splash.page.dart';

enum Routes {
  splash("/splash"),
  signUpWithEmailAndPassword("/auth/sign-up"),
  entry("/"),
  uploadFeed("/feed/upload"),
  openChat("/chat/open"),
  chatRoom("/chat/:chatId"),
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
  // GoRoute(
  //   name: Routes.chatRoom.name,
  //   path: Routes.chatRoom.path,
  //   builder: (context, state) {
  //     final chat = state.extra as ChatEntity;
  //     return ChatRoomPage(chat);
  //   },
  // ),
], initialLocation: Routes.splash.path);
