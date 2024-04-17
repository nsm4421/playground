part of "chat_message.bloc.dart";

@immutable
sealed class ChatMessageEvent {}

final class InitChatMessageEvent extends ChatMessageEvent {}

final class NewChatMessageEvent extends ChatMessageEvent {
  final List<ChatMessageEntity> messages;

  NewChatMessageEvent(this.messages);
}

final class SendChatMessageEvent extends ChatMessageEvent {
  final String content;
  final String chatId;
  final UserEntity currentUser;

  SendChatMessageEvent(
      {required this.content, required this.chatId, required this.currentUser});
}

final class DeleteChatMessageEvent extends ChatMessageEvent {
  final String messageId;

  DeleteChatMessageEvent(this.messageId);
}
