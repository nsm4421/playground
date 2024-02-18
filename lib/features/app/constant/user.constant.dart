enum UserStatus {
  online("접속중"),
  offline("미접속중"),
  dormant("휴면"),
  withdrawal("탈퇴");

  final String description;

  const UserStatus(this.description);
}
