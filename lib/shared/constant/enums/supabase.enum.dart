enum Tables {
  accounts,
  feeds,
  likes,
  comments;
}

enum Buckets {
  avatars,
  feeds;
}

// RPC 함수명
enum RpcFunctions {
  fetchFeeds('fetch_feeds'),
  fetchParentComments("fetch_parent_comments");

  final String name;

  const RpcFunctions(this.name);
}
