import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/data/entity/user/user.entity.dart';
import 'package:hot_place/presentation/auth/page/sign_up/sign_up.screen.dart';
import 'package:hot_place/presentation/chat/page/open_chat/open_chat.screen.dart';
import 'package:hot_place/presentation/chat/page/open_chat/open_chat_room.screen.dart';
import 'package:hot_place/presentation/chat/page/private_Chat/private_chat_room.screen.dart';
import 'package:hot_place/presentation/chat/page/open_chat/create_open_chat.screen.dart';
import 'package:hot_place/presentation/feed/page/search/search_feed.screen.dart';
import 'package:hot_place/presentation/feed/page/upload/upload_feed.screen.dart';
import 'package:hot_place/presentation/main/page/main.screen.dart';
import 'package:hot_place/presentation/setting/page/edit_profile.screen.dart';

import '../../presentation/main/page/splash.screen.dart';

enum Routes {
  splash("/"),
  main("/main"),
  signUp("/auth/sign-up"),
  uploadFeed("/feed/create"),
  searchFeed("/feed/search"),
  editProfile("/setting/profile"),
  openChat("/open-chat"),
  createOpenChat("/open-chat/create"),
  openChatRoom("/open-chat/chat-room"),
  privateChatRoom("/private-chat/chat-room");

  final String path;

  const Routes(this.path);
}

final GoRouter routerConfig = GoRouter(routes: <RouteBase>[
  GoRoute(
    name: Routes.splash.name,
    path: Routes.splash.path,
    builder: (BuildContext context, GoRouterState state) {
      return const SplashScreen();
    },
  ),
  GoRoute(
    name: Routes.main.name,
    path: Routes.main.path,
    builder: (BuildContext context, GoRouterState state) {
      return const MainScreen();
    },
  ),
  GoRoute(
    name: Routes.signUp.name,
    path: Routes.signUp.path,
    builder: (BuildContext context, GoRouterState state) {
      return const SignUpScreen();
    },
  ),
  GoRoute(
    name: Routes.searchFeed.name,
    path: Routes.searchFeed.path,
    builder: (BuildContext context, GoRouterState state) {
      return const SearchFeedScreen();
    },
  ),
  GoRoute(
    name: Routes.uploadFeed.name,
    path: Routes.uploadFeed.path,
    builder: (BuildContext context, GoRouterState state) {
      return const UploadFeedScreen();
    },
  ),
  GoRoute(
    name: Routes.editProfile.name,
    path: Routes.editProfile.path,
    builder: (BuildContext context, GoRouterState state) {
      return const EditProfileScreen();
    },
  ),
  GoRoute(
    name: Routes.openChat.name,
    path: Routes.openChat.path,
    builder: (BuildContext context, GoRouterState state) {
      return const OpenChatScreen();
    },
  ),
  GoRoute(
    name: Routes.createOpenChat.name,
    path: Routes.createOpenChat.path,
    builder: (BuildContext context, GoRouterState state) {
      return const CreateOpenChatScreen();
    },
  ),
  GoRoute(
    name: Routes.openChatRoom.name,
    path: "${Routes.openChatRoom.path}/:id",
    builder: (BuildContext context, GoRouterState state) {
      final chatId = state.pathParameters['id']!;
      return OpenChatRoomScreen(chatId);
    },
  ),
  GoRoute(
    name: Routes.privateChatRoom.name,
    path: "${Routes.privateChatRoom.path}/:id",
    builder: (BuildContext context, GoRouterState state) {
      final extra = state.extra as Map<String, dynamic>;
      final receiver = UserEntity.fromJson(extra);
      final chatId = state.pathParameters['id']!;
      return PrivateChatRoomScreen(chatId: chatId, receiver: receiver);
    },
  )
], initialLocation: Routes.splash.path);
