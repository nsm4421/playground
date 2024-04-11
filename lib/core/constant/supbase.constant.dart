enum TableName {
  user('accounts'),
  feed('feeds'),
  like("likes"),
  openChat("open_chat");

  final String name;

  const TableName(this.name);
}

enum BucketName {
  user("user"),
  feed("feed"),
  chat("chat");

  final String name;

  const BucketName(this.name);
}
