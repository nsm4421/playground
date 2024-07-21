part of "router.dart";

enum RoutePaths {
  splash("/"), auth("/auth"), main("/main");
  final String path;

  const RoutePaths(this.path);
}