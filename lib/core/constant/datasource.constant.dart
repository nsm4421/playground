part of 'constant.dart';

enum Tables {
  feeds,
  reels;
}

enum RpcFns {
  fetchFeeds('fetch_feeds'),
  fetchReels('fetch_reels'),
  ;

  final String name;

  const RpcFns(this.name);
}

enum Buckets {
  avatars,
  feeds,
  reels;
}
