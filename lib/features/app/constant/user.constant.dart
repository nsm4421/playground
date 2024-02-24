enum UserStatus {
  onBoarding("온보딩"),
  online("접속중"),
  offline("미접속중"),
  dormant("휴면"),
  withdrawal("탈퇴");

  final String description;

  const UserStatus(this.description);
}

enum AuthStatus {
  authenticated,
  unAuthenticated;
}

enum Provider {
  google;
}
