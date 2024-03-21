enum CollectionName {
  user("users"),
  like("likes"),
  chat("chats"),
  postComment("post-comments"),
  post("posts"),
  message("messages");

  final String name;

  const CollectionName(this.name);
}
