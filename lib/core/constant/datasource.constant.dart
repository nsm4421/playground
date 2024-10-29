part of 'constant.dart';

enum Tables {
  accounts('accounts'),
  feeds('feeds'),
  meeting('meetings'),
  comment('comments'),
  like('likes'),
  registration('registrations'),
  reels('reels'),
  openChatRooms('open_chat_rooms'),
  openChatMessages('open_chat_messages'),
  privateChatRooms('private_chat_rooms'),
  privateChatMessages('private_chat_messages'),
  ;

  final String name;

  const Tables(this.name);
}

enum Buckets {
  avatar('avatar'),
  feed('feed'),
  feeds('meeting'),
  reels('reels'),
  openChat('open_chat'),
  privateChat('private_chat'),
  ;

  final String name;

  const Buckets(this.name);
}

enum Boxes {
  credential;
}

enum Channels {
  meeting;
}

enum RpcFns {
  fetchFeeds('fetch_feeds'),
  fetchReels('fetch_reels'),
  fetchOpenChats('fetch_open_chats'),
  fetchOpenChatMessages('fetch_open_messages'),
  fetchMeetings('fetch_meetings'),
  searchMeetings('search_meetings'),
  fetchComments('fetch_comments'),
  fetchRegistrations('fetch_registrations'),
  createRegistration('create_registration'),
  updatePermissionOnRegistration('update_permission_on_registration'),
  ;

  final String name;

  const RpcFns(this.name);
}
