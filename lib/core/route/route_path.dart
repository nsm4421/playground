part of "router.dart";

enum RoutePaths {
  splash("/"),
  signUp("/auth/sign-up"),
  main("/main"),
  chat("/chat"),
  createFeed("/feed/create"),
  privateChat("/chat/private", subPath: "private"),
  privateChatRoom("/chat/private/room", subPath: "room"),
  openChat("/chat/open", subPath: "open"),
  openChatRoom("/chat/open/room", subPath: "room"),
  createOpenChat("/chat/open/create", subPath: "create");

  final String path;
  final String? subPath;

  const RoutePaths(this.path, {this.subPath});
}
