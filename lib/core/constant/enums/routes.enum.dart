enum Routes { auth, splash, main, chat }

extension RoutesEx on Routes {
  String get path {
    switch (this) {
      case Routes.auth:
        return "/";
      case Routes.splash:
        return "/splash";
      case Routes.main:
        return "/main";
      case Routes.chat:
        return "/chat";
    }
  }

  String get name {
    switch (this) {
      case Routes.auth:
        return "auth";
      case Routes.splash:
        return "splash";
      case Routes.main:
        return "main";
      case Routes.chat:
        return "chat";
    }
  }
}
