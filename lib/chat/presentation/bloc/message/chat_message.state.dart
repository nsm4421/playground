part of 'chat_message.bloc.dart';

class ChatMessageState {
  final Status status;
  final String errorMessage;
  final bool isEnd;
  late final List<ChatMessageEntity> messages;

  ChatMessageState(
      {this.status = Status.initial,
      this.errorMessage = '',
      this.isEnd = false,
      List<ChatMessageEntity>? messages}) {
    this.messages = messages ?? [];
  }

  ChatMessageState copyWith({
    Status? status,
    String? errorMessage,
    bool? isEnd,
    List<ChatMessageEntity>? messages,
  }) =>
      ChatMessageState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        isEnd: isEnd ?? this.isEnd,
        messages: messages ?? this.messages,
      );
}
