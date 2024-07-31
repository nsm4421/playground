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
  profileImage("profile-image");

  final String name;

  const BucketName(this.name);
}
