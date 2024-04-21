part of "private_chat_message.bloc.dart";

@immutable
sealed class PrivateChatMessageEvent {}

final class InitPrivateChatMessageEvent extends PrivateChatMessageEvent {}

final class NewPrivateChatMessageEvent extends PrivateChatMessageEvent {
  final List<PrivateChatMessageEntity> messages;

  NewPrivateChatMessageEvent(this.messages);
}

final class SendPrivateChatMessageEvent extends PrivateChatMessageEvent {
  final String content;
  final String chatId;
  final UserEntity currentUser;
  final UserEntity receiver;

  SendPrivateChatMessageEvent(
      {required this.content,
      required this.chatId,
      required this.currentUser,
      required this.receiver});
}

final class DeletePrivateChatMessageEvent extends PrivateChatMessageEvent {
  final String messageId;

  DeletePrivateChatMessageEvent(this.messageId);
}
