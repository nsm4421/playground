enum TableName {
  user("accounts"),
  feed("feeds"),
  feedComment("feedComments"),
  chat("chats"),
  message("messages"),
  like("likes");

  final String name;

  const TableName(this.name);
}

enum BucketName {
  user("accounts"),
  feed("feeds"),
  chat("chats"),
  message("messages");

  final String name;

  const BucketName(this.name);
}
