enum TableName {
  user('accounts'),
  feed('feeds'),
  like("likes"),
  openChat("open_chats"),
  chatMessage("chat_messages");

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
