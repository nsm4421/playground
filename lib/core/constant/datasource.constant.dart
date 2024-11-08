part of 'constant.dart';

enum Tables {
  feeds;
}

enum RpcFns {
  fetchFeeds('fetch_feeds');

  final String name;

  const RpcFns(this.name);
}

enum Buckets {
  avatars, feeds;
}
