part of "router.dart";

enum RoutePaths {
  splash("/"),
  signUp("/auth/sign-up"),
  main("/main"),
  chat("/chat"),
  openChat("/chat/open", subPath: "open"),
  createOpenChat("/chat/open/create", subPath: "create");

  final String path;
  final String? subPath;

  const RoutePaths(this.path, {this.subPath});
}
