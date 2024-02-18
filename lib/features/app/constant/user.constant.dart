enum UserStatus {
  active("활동중"),
  dormant("휴면"),
  withdrawal("탈퇴");

  final String description;

  const UserStatus(this.description);
}
