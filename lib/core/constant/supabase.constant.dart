enum TableName {
  user("accounts"),
  feed("feeds"),
  feedComment("feedComments"),
  openChat("openChats"),
  openChatMessage("openChatMessages"),
  like("likes");

  final String name;

  const TableName(this.name);
}

enum BucketName {
  user("accounts"),
  feed("feeds"),
  openChat("openChats"),
  openChatMessage("openChatMessage");

  final String name;

  const BucketName(this.name);
}
