abstract class ChatRoomEvent {
  const ChatRoomEvent();
}

class ChatRoomInitializedEvent extends ChatRoomEvent {}

class ChatRoomCreateEvent extends ChatRoomEvent {
  final String chatRoomName;
  final List<String> hashtags;

  ChatRoomCreateEvent({required this.chatRoomName, required this.hashtags});
}
