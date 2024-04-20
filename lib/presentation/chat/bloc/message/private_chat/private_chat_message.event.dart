part of "private_chat_message.bloc.dart";

@immutable
sealed class PrivateChatMessageEvent {}

final class InitChatMessageEvent extends PrivateChatMessageEvent {}

final class NewChatMessageEvent extends PrivateChatMessageEvent {
  final List<PrivateChatMessageEntity> messages;

  NewChatMessageEvent(this.messages);
}

final class SendChatMessageEvent extends PrivateChatMessageEvent {
  final String content;
  final String chatId;
  final UserEntity currentUser;
  final UserEntity opponentUser;

  SendChatMessageEvent(
      {required this.content,
      required this.chatId,
      required this.currentUser,
      required this.opponentUser});
}

final class DeleteChatMessageEvent extends PrivateChatMessageEvent {
  final String messageId;

  DeleteChatMessageEvent(this.messageId);
}
