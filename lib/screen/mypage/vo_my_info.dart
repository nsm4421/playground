class MyInfoVo {
  final int postCount;
  final int followingCount;
  final int followerCount;
  final String? introduce;

  MyInfoVo(
      {required this.postCount,
      required this.followingCount,
      required this.followerCount,
      this.introduce});
}
