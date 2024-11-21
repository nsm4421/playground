part of 'constant.dart';

enum Tables {
  feeds("FEEDS"),
  reels("REELS"),
  emotions("EMOTIONS"),
  comments("COMMENTS");

  final String name;

  const Tables(this.name);
}

enum RpcFns {
  fetchFeeds('fetch_feeds'),
  fetchReels('fetch_reels'),
  fetchParentComments('fetch_parent_comments'),
  fetchChildComments('fetch_child_comments'),
  ;

  final String name;

  const RpcFns(this.name);
}

enum Buckets {
  avatars,
  feeds,
  reels;
}
