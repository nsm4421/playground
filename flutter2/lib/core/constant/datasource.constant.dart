part of 'constant.dart';

enum Tables {
  feeds("FEEDS"),
  reels("REELS"),
  emotions("EMOTIONS"),
  comments("COMMENTS"),
  privateChats("PRIVATE_CHATS"),
  privateMessages("PRIVATE_MESSAGES");

  final String name;

  const Tables(this.name);
}

enum RpcFns {
  fetchFeeds('fetch_feeds'),
  fetchReels('fetch_reels'),
  fetchParentComments('fetch_parent_comments'),
  fetchChildComments('fetch_child_comments'),
  fetchPrivateChats('fetch_private_chats'),
  fetchPrivateMessages('fetch_private_messages'),
  ;

  final String name;

  const RpcFns(this.name);
}

enum Buckets {
  avatars,
  feeds,
  reels;
}
