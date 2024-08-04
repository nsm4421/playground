enum TableName {
  account("accounts"),
  feed("feeds"),
  feedComment("feed_comments"),
  emotion("emotions"),
  openChatRoom("open_chat_rooms"),
  openChatMessage("open_chat_messages"),
  privateChatMessage("private_chat_messages"),
  ;

  final String name;

  const TableName(this.name);
}

enum BucketName {
  profileImage("profile-image"),
  feed("feed");

  final String name;

  const BucketName(this.name);
}

enum RpcName {
  fetchFeeds(
      name: "fetch_feeds",
      description: "beforeAt을 전달하면, 해당일자 이전의 피드를 20개를 조회함"),
  fetchComments(
      name: "fetch_comments",
      description: "beforeAt을 전달하면, 해당일자 이전의 댓글을 20개를 조회함");

  final String name;
  final String? description;

  const RpcName({required this.name, this.description});
}
