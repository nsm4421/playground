/// └ user
/// └ feed
///   └ comment
///     └ child-comment
/// └ chat
///   └ message
/// └ Follow
enum CollectionName {
  user('user'),
  feed('feed'),
  parentComment('comment'),
  childComment('child-comment'),
  chat('chat'),
  message('message'),
  follow('follow');

  final String name;

  const CollectionName(this.name);
}
