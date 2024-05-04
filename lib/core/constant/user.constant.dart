enum AuthStatus {
  authenticated,
  unAuthenticated;
}

enum Provider {
  google;
}

enum Sex {
  none("성별을 선택하지 않음"),
  woman("여자"),
  man("남자");

  final String description;

  const Sex(this.description);
}
