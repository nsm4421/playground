part of "router.dart";

enum RoutePaths {
  splash("/"),
  signUp("/auth/sign-up"),
  main("/main");

  final String path;
  final String? subPath;

  const RoutePaths(this.path, {this.subPath});
}
