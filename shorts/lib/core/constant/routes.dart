import 'package:go_router/go_router.dart';

import '../../data/entity/chat/open_chat/open_chat.entity.dart';
import '../../data/entity/user/account.entity.dart';
import '../../presentation/pages/auth/sign_up/sign_up_with_email.screen.dart';
import '../../presentation/pages/entry/entry.page.dart';
import '../../presentation/pages/entry/splash.page.dart';
import '../../presentation/pages/main/chat/open/create/create_open_chat.page.dart';
import '../../presentation/pages/main/chat/open/entry/open_chat.page.dart';
import '../../presentation/pages/main/chat/open/room/open_chat_room.page.dart';
import '../../presentation/pages/main/chat/private/private_chat.page.dart';
import '../../presentation/pages/main/feed/upload/upload_feed.page.dart';
import '../../presentation/pages/main/setting/edit/edit_profile.page.dart';

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
  privateChatRoom("/chat/private/chat-room"),

  /// setting
  editProfile("/setting/edit");

  final String path;

  const Routes(this.path);
}

final GoRouter routerConfig = GoRouter(routes: <RouteBase>[
  GoRoute(
    name: Routes.splash.name,
    path: Routes.splash.path,
    builder: (_, __) => const SplashPage(),
  ),
  GoRoute(
      name: Routes.entry.name,
      path: Routes.entry.path,
      builder: (_, __) => const EntryPage()),
  GoRoute(
      name: Routes.signUpWithEmailAndPassword.name,
      path: Routes.signUpWithEmailAndPassword.path,
      builder: (_, __) => const SignUpWithEmailAndPasswordScreen()),
  GoRoute(
    name: Routes.uploadFeed.name,
    path: Routes.uploadFeed.path,
    builder: (_, __) => const UploadFeedPage(),
  ),
  GoRoute(
    name: Routes.editProfile.name,
    path: Routes.editProfile.path,
    builder: (_, __) => const EditProfilePage(),
  ),

  /// chat
  GoRoute(
    name: Routes.openChat.name,
    path: Routes.openChat.path,
    builder: (_, __) => const OpenChatPage(),
  ),
  GoRoute(
    name: Routes.createOpenChat.name,
    path: Routes.createOpenChat.path,
    builder: (_, __) => const CreateOpenChatPage(),
  ),
  GoRoute(
    name: Routes.openChatRoom.name,
    path: Routes.openChatRoom.path,
    builder: (_, state) => OpenChatRoomPage(state.extra as OpenChatEntity),
  ),
  GoRoute(
    name: Routes.privateChatRoom.name,
    path: Routes.privateChatRoom.path,
    builder: (_, state) => PrivateChatPage(state.extra as AccountEntity),
  ),
], initialLocation: Routes.splash.path);
