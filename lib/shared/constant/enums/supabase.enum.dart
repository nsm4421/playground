enum Tables {
  accounts('ACCOUNTS'),
  feeds('FEEDS'),
  likes('LIKES'),
  comments('COMMENTS'),
  chats('CHATS'),
  chatMessages('CHAT_MESSAGES');

  final String name;

  const Tables(this.name);
}

enum Buckets {
  avatars,
  feeds;
}

// RPC 함수명
enum RpcFunctions {
  fetchFeeds('fetch_feeds'),
  fetchParentComments('fetch_parent_comments'),
  fetchChats('fetch_chats'),
  fetchChatMessages('fetch_chat_messages');

  final String name;

  const RpcFunctions(this.name);
}
