part of 'chat.bloc.dart';

@sealed
final class ChatEvent {}

final class FetchChatsEvent extends ChatEvent {
  // last_message_created_at 필드가 beforeAt 이전인 데이터 take개 가져오기
  late final DateTime beforeAt;
  final int take;

  FetchChatsEvent({DateTime? beforeAt, this.take = 20}) {
    this.beforeAt = beforeAt ?? DateTime.now().toUtc();
  }
}

// 채팅방 삭제
final class DeleteChatEvent extends ChatEvent {
  final String chatId;

  DeleteChatEvent(this.chatId);
}

// 새로운 메세지가 도착한 경우
final class OnNewMessageEvent extends ChatEvent {
  final String chatId;
  final String messageId;
  final String content;
  final DateTime createdAt;

  OnNewMessageEvent(
      {required this.chatId,
      required this.messageId,
      required this.content,
      required this.createdAt});
}

// 메세지가 삭제된 경우
final class OnMessageDeletedEvent extends ChatEvent {
  final String chatId;
  final String messageId;

  OnMessageDeletedEvent({required this.chatId, required this.messageId});
}
