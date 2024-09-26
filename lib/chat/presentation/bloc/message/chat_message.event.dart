part of 'chat_message.bloc.dart';

@sealed
final class ChatMessageEvent {}

final class FetchChatMessagesEvent extends ChatMessageEvent {
  // last_message_created_at 필드가 beforeAt 이전인 데이터 take개 가져오기
  late final DateTime beforeAt;
  final int take;

  FetchChatMessagesEvent({DateTime? beforeAt, this.take = 20}) {
    this.beforeAt = beforeAt ?? DateTime.now().toUtc();
  }
}

final class DeleteChatMessageEvent extends ChatMessageEvent {
  final String messageId;

  DeleteChatMessageEvent(this.messageId);
}

final class SeeChatMessageEvent extends ChatMessageEvent {
  final String messageId;

  SeeChatMessageEvent(this.messageId);
}

// 새로운 메세지가 도착한 경우
final class OnNewMessageEvent extends ChatMessageEvent {
  final String messageId;
  final String senderUid;
  final String receiverUid;
  final ChatMessageType type;
  final String content;
  final DateTime createdAt;

  OnNewMessageEvent(
      {required this.messageId,
      required this.senderUid,
      required this.receiverUid,
      required this.type,
      required this.content,
      required this.createdAt});
}

// 메세지가 삭제된 경우
final class OnMessageDeletedEvent extends ChatMessageEvent {
  final String messageId;

  OnMessageDeletedEvent(this.messageId);
}

// 상대방이 메세지를 읽었다는 걸 인지한 경우
final class OnListenMessageReadEvent extends ChatMessageEvent {
  final String messageId;

  OnListenMessageReadEvent(this.messageId);
}
