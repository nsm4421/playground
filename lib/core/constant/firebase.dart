enum CollectionName {
  user("users"),
  feed("feeds"),
  feedComment("feedComments"),
  chat("chats"),
  message("messages");

  final String name;

  const CollectionName(this.name);
}

enum BucketName {
  user("users"),
  feed("feeds"),
  chat("chats"),
  message("messages");

  final String name;

  const BucketName(this.name);
}
