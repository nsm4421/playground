/// └ user
/// └ notification
/// └ feed
///   └ comment
///     └ child-comment
/// └ chat
///   └ message
/// └ follow

enum CollectionName {
  user('user'),
  feed('feed'),
  parentComment('comment'),
  childComment('child-comment'),
  chat('chat'),
  message('message'),
  follow('follow'),
  notification('notification');

  final String name;

  const CollectionName(this.name);
}
