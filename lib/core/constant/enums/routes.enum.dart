enum Routes { splash, main }

extension RoutesEx on Routes {
  String get path {
    switch (this) {
      case Routes.splash:
        return "/splash";
      case Routes.main:
        return "/main";
    }
  }

  String get name {
    switch (this) {
      case Routes.splash:
        return "splash";
      case Routes.main:
        return "main";
    }
  }
}
