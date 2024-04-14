part of "chat_message.bloc.dart";

@immutable
sealed class ChatMessageEvent {}

final class InitChatMessageEvent extends ChatMessageEvent {}

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
