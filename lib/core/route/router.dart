import 'package:go_router/go_router.dart';
import 'package:portfolio/domain/entity/auth/presence.entity.dart';
import 'package:portfolio/domain/entity/chat/open_chat.entity.dart';
import 'package:portfolio/domain/entity/feed/feed.entity.dart';
import 'package:portfolio/presentation/pages/feed/create/comment/create_feed_comment.page.dart';
import 'package:portfolio/presentation/pages/feed/create/feed/create_feed.page.dart';
import 'package:portfolio/presentation/pages/feed/display/comment/display_feed_comment.page.dart';
import 'package:portfolio/presentation/pages/feed/display/feed/display_feed.page.dart';
import 'package:portfolio/presentation/pages/setting/edit/edit_profile.page.dart';
import 'package:portfolio/presentation/pages/travel/recommend/recommend_itinerary.page.dart';
import 'package:portfolio/presentation/pages/travel/travel.page.dart';

import '../../presentation/pages/main/components/error.screen.dart';
import '../../presentation/pages/auth/sign_up/sign-up.page.dart';
import '../../presentation/pages/chat/open_chat/chat_room/open_chat_room.page.dart';
import '../../presentation/pages/chat/open_chat/create/create_open_chat.page.dart';
import '../../presentation/pages/chat/open_chat/display/display_open_chat.page.dart';
import '../../presentation/pages/chat/private_chat/chat_room/private_chat_room.page.dart';
import '../../presentation/pages/chat/private_chat/display/display_private_chat.page.dart';
import '../../presentation/pages/main/main.page.dart';
import '../../presentation/pages/main/splash/splash.page.dart';
import '../../presentation/pages/setting/setting.page.dart';

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

  /// 피드
  GoRoute(
      path: RoutePaths.feed.path,
      name: 'feed',
      builder: (context, state) => const DisplayFeedPage(),
      routes: [
        // 피드 작성
        GoRoute(
          path: RoutePaths.createFeed.subPath!,
          name: 'create-feed',
          builder: (context, state) => const CreateFeedPage(),
        ),
        // 댓글 목록
        GoRoute(
            path: RoutePaths.feedComment.subPath!,
            name: 'comment',
            builder: (context, state) {
              final feed = state.extra as FeedEntity;
              return DisplayFeedCommentPage(feed);
            },
            routes: [
              // 댓글 작성
              GoRoute(
                path: RoutePaths.createComment.subPath!,
                name: 'create-feed-comment',
                builder: (context, state) {
                  final feedId = state.extra as String;
                  return CreateFeedCommentPage(feedId);
                },
              ),
            ]),
      ]),

  // 여행
  GoRoute(
      path: RoutePaths.travel.path,
      name: "travel",
      builder: (context, state) => const TravelPage(),
      routes: [
        GoRoute(
            path: RoutePaths.recommendItinerary.subPath!,
            name: "recommend-itinerary",
            builder: (context, state) => const RecommendItineraryPage())
      ]),

  // 세팅
  GoRoute(
      path: RoutePaths.setting.path,
      name: 'setting',
      builder: (context, state) => const SettingPage(),
      routes: [
        // 프로필 수정
        GoRoute(
            path: RoutePaths.editProfile.subPath!,
            name: 'edit-profile',
            builder: (context, state) => const EditProfilePage()),
      ]),

  /// 채팅
  GoRoute(
      path: RoutePaths.chat.path,
      name: "chat",
      // TODO : 잘못된 라우팅 처리하기 위한 페이지
      builder: (context, state) => const ErrorScreen(),
      routes: [
        /// DM
        GoRoute(
            path: RoutePaths.privateChat.subPath ?? "private",
            name: "private-chat",
            builder: (context, state) => const DisplayPrivateChatPage(),
            routes: [
              GoRoute(
                  path: RoutePaths.privateChatRoom.subPath ?? "room",
                  name: "private-chat-room",
                  builder: (context, state) {
                    final opponent = state.extra as PresenceEntity;
                    return PrivateChatRoomPage(opponent);
                  })
            ]),

        /// 오픈 채팅
        GoRoute(
            path: RoutePaths.openChat.subPath ?? "open",
            name: 'open-chat',
            builder: (context, state) => const DisplayOpenChatPage(),
            routes: [
              GoRoute(
                path: RoutePaths.openChatRoom.subPath ?? "room",
                name: 'open-chat-room',
                builder: (context, state) {
                  final chat = state.extra as OpenChatEntity;
                  return OpenChatRoomPage(chat);
                },
              ),
              GoRoute(
                path: RoutePaths.createOpenChat.subPath ?? "create",
                name: 'create-open-chat',
                builder: (context, state) => const CreateOpenChatPage(),
              ),
            ]),
      ]),
], initialLocation: RoutePaths.splash.path);
