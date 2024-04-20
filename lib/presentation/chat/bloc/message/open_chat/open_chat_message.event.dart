part of "open_chat_message.bloc.dart";

@immutable
sealed class OpenChatMessageEvent {}

final class InitChatMessageEvent extends OpenChatMessageEvent {}

final class NewChatMessageEvent extends OpenChatMessageEvent {
  final List<OpenChatMessageEntity> messages;

  NewChatMessageEvent(this.messages);
}

final class SendChatMessageEvent extends OpenChatMessageEvent {
  final String content;
  final String chatId;
  final UserEntity currentUser;

  SendChatMessageEvent(
      {required this.content, required this.chatId, required this.currentUser});
}

final class DeleteChatMessageEvent extends OpenChatMessageEvent {
  final String messageId;

  DeleteChatMessageEvent(this.messageId);
}
