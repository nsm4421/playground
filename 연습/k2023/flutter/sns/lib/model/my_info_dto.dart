class MyInfoDto {
  final int postCount;
  final int followingCount;
  final int followerCount;
  final String? introduce;

  MyInfoDto(
      {required this.postCount,
      required this.followingCount,
      required this.followerCount,
      this.introduce});
}
