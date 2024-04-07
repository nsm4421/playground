enum TableName {
  user('accounts'),
  feed('feeds'),
  like("likes");

  final String name;

  const TableName(this.name);
}

enum BucketName {
  user("user"),
  feed("feed");

  final String name;

  const BucketName(this.name);
}
