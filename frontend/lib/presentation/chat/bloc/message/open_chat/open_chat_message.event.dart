part of "open_chat_message.bloc.dart";

@immutable
sealed class OpenChatMessageEvent {}

final class InitOpenChatMessageEvent extends OpenChatMessageEvent {}

final class NewOpenChatMessageEvent extends OpenChatMessageEvent {
  final List<OpenChatMessageEntity> messages;

  NewOpenChatMessageEvent(this.messages);
}

final class SendOpenChatMessageEvent extends OpenChatMessageEvent {
  final String content;
  final String chatId;
  final UserEntity currentUser;

  SendOpenChatMessageEvent(
      {required this.content, required this.chatId, required this.currentUser});
}

final class DeleteOpenChatMessageEvent extends OpenChatMessageEvent {
  final String chatId;
  final String messageId;

  DeleteOpenChatMessageEvent({
    required this.chatId,
    required this.messageId,
  });
}
