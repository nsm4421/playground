part of 'chat.bloc.dart';

class ChatState {
  final Status status;
  final String errorMessage;
  final bool isEnd;
  late final List<ChatEntity> chats;

  ChatState(
      {this.status = Status.initial,
      this.errorMessage = '',
      this.isEnd = false,
      List<ChatEntity>? chats}) {
    this.chats = chats ?? [];
  }

  ChatState copyWith({
    Status? status,
    String? errorMessage,
    bool? isEnd,
    List<ChatEntity>? chats,
  }) =>
      ChatState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        isEnd: isEnd ?? this.isEnd,
        chats: chats ?? this.chats,
      );
}
