part of "display_private_chat.cubit.dart";

class DisplayPrivateChatState extends ChatState {
  DisplayPrivateChatState(
      {super.status = Status.initial,
      super.message,
      this.chatMessages = const []});

  final List<PrivateChatMessageEntity> chatMessages;

  @override
  DisplayPrivateChatState copyWith(
      {Status? status,
      String? message,
      List<PrivateChatMessageEntity>? chatMessages}) {
    return DisplayPrivateChatState(
        status: status ?? this.status,
        message: message ?? this.message,
        chatMessages: chatMessages ?? this.chatMessages);
  }
}
