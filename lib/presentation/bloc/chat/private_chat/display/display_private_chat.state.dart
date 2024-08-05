part of "display_private_chat.bloc.dart";

final class DisplayPrivateChatState extends ChatState {
  final List<PrivateChatMessageEntity> lastMessages;

  DisplayPrivateChatState(
      {super.status, super.message, this.lastMessages = const []});

  @override
  DisplayPrivateChatState copyWith({
    Status? status,
    String? message,
    List<PrivateChatMessageEntity>? lastMessages,
  }) {
    return DisplayPrivateChatState(
      status: status ?? this.status,
      message: message ?? this.message,
      lastMessages: lastMessages ?? this.lastMessages,
    );
  }
}
