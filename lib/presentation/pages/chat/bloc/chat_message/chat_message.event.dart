abstract class ChatMessageEvent {
  const ChatMessageEvent();
}

class ChatMessageInitializedEvent extends ChatMessageEvent {
  final String chatRoomId;

  ChatMessageInitializedEvent(this.chatRoomId);
}

class ChatMessageSentEvent extends ChatMessageEvent {
  final String chatRoomId;
  final String message;

  ChatMessageSentEvent({required this.chatRoomId, required this.message});
}
