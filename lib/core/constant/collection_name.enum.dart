/// └ user
/// └ feed
///   └ comment
///     └ child-comment
/// └ chat
///   └ message
enum CollectionName {
  user('user'),
  feed('feed'),
  parentComment('comment'),
  childComment('child-comment'),
  chat('chat'),
  message('message');

  final String name;

  const CollectionName(this.name);
}
