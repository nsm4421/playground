enum TableName {
  user("accounts"),
  feed("feeds"),
  feedComment("feedComments"),
  openChat("openChats"),
  openChatMessage("openChatMessages"),
  privateChatMessage("privateChatMessages"),
  like("likes");

  final String name;

  const TableName(this.name);
}

enum BucketName {
  user("accounts"),
  feed("feeds"),
  openChat("openChats"),
  openChatMessage("openChatMessage"),
  privateChatMessage("privateChatMessage");

  final String name;

  const BucketName(this.name);
}

enum BoxName {
  privateChat("privateChat");

  final String name;

  const BoxName(this.name);
}
