part of "router.dart";

enum RoutePaths {
  splash("/"),
  signUp("/auth/sign-up"),
  main("/main"),
  chat("/chat"),
  feed("/feed"),
  travel("/travel"),
  recommendItinerary("/travel/recommend-itinerary",
      subPath: "recommend-itinerary"),
  setting("/setting"),
  editProfile("/setting/edit-profile", subPath: "edit-profile"),
  createFeed("/feed/create", subPath: "create"),
  feedComment("/feed/comment", subPath: "comment"),
  createComment("/feed/comment/create", subPath: "create"),
  privateChat("/chat/private", subPath: "private"),
  privateChatRoom("/chat/private/room", subPath: "room"),
  openChat("/chat/open", subPath: "open"),
  openChatRoom("/chat/open/room", subPath: "room"),
  createOpenChat("/chat/open/create", subPath: "create");

  final String path;
  final String? subPath;

  const RoutePaths(this.path, {this.subPath});
}
