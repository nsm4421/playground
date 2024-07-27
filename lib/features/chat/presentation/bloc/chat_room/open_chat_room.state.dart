part of "open_chat_room.bloc.dart";

final class OpenChatRoomState extends ChatState {
  final String _chatId;
  final List<ChatMessageEntity> chatMessages;
  final bool isEnd;

  // 최초 fetchAt을 기준으로 이전 채팅메시지를 가져옴
  final DateTime _beforeAt = DateTime.now().toUtc();

  DateTime get beforeAt => _beforeAt;

  OpenChatRoomState(this._chatId,
      {super.status,
      super.message,
      this.chatMessages = const [],
      this.isEnd = false});

  @override
  OpenChatRoomState copyWith(
      {Status? status,
      String? message,
      bool? isEnd,
      List<ChatMessageEntity>? chatMessages}) {
    return OpenChatRoomState(_chatId,
        status: status ?? this.status,
        message: message ?? this.message,
        isEnd: isEnd ?? this.isEnd,
        chatMessages: chatMessages ?? this.chatMessages);
  }
}
