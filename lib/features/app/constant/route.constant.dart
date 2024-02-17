enum PageRoute {
  // authentication
  init("/"),
  otp("/auth/otp"),
  login("/auth/login"),
  onboarding("/auth/onboarding"),

  // home
  home("/home"),

  // setting
  setting("/setting"),

  // chat
  chat("/chat")
  ;

  final String path;

  const PageRoute(this.path);
}