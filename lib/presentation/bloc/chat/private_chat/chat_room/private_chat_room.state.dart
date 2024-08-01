part of "private_chat_room.bloc.dart";

final class PrivateChatRoomState extends ChatState {
  final String _chatId;
  final List<PrivateChatMessageEntity> chatMessages;
  final bool isEnd;
  final DateTime beforeAt;

  PrivateChatRoomState(this._chatId,
      {super.status,
      super.message,
      required this.beforeAt,
      this.chatMessages = const [],
      this.isEnd = false});

  @override
  PrivateChatRoomState copyWith({
    Status? status,
    String? message,
    bool? isEnd,
    DateTime? beforeAt,
    List<PrivateChatMessageEntity>? lastMessages,
    List<PrivateChatMessageEntity>? chatMessages,
  }) {
    return PrivateChatRoomState(
      _chatId,
      status: status ?? this.status,
      message: message ?? this.message,
      isEnd: isEnd ?? this.isEnd,
      beforeAt: beforeAt ?? this.beforeAt,
      chatMessages: chatMessages ?? this.chatMessages,
    );
  }
}
