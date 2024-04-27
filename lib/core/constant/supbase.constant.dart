enum TableName {
  user('accounts'),
  feed('feeds'),
  like("feed_like"),
  feedComment("feed_comments"),
  openChat("open_chats"),
  openChatMessage("open_chat_messages"),
  privateChat("private_chats"),
  privateChatMessage("private_chat_messages");

  final String name;

  const TableName(this.name);
}

enum BucketName {
  user("account"),
  feed("feed"),
  chat("chat"),
  message("message");

  final String name;

  const BucketName(this.name);
}
