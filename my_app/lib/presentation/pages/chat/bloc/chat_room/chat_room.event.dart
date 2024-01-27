abstract class ChatRoomEvent {
  const ChatRoomEvent();
}

class ChatRoomInitializedEvent extends ChatRoomEvent {}

class ChatRoomCreateEvent extends ChatRoomEvent {
  final String chatRoomName;
  final List<String> hashtags;

  ChatRoomCreateEvent({required this.chatRoomName, required this.hashtags});
}

class EnterChatRoomEvent extends ChatRoomEvent {
  final String chatRoomId;

  EnterChatRoomEvent(this.chatRoomId);
}

class LeaveChatRoomEvent extends ChatRoomEvent {
  final String chatRoomId;

  LeaveChatRoomEvent(this.chatRoomId);
}
