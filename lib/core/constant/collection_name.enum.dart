/// └ user
/// └ feed
///   └ comment
///     └ child-comment
enum CollectionName {
  user('user'),
  feed('feed'),
  parentComment('comment'),
  childComment('child-comment');

  final String name;

  const CollectionName(this.name);
}
