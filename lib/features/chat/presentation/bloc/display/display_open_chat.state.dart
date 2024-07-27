part of "display_open_chat.cubit.dart";

class DisplayOpenChatState extends ChatState {
  DisplayOpenChatState({super.status = Status.initial, super.message});

  @override
  DisplayOpenChatState copyWith({Status? status, String? message}) {
    return DisplayOpenChatState(
        status: status ?? this.status, message: message ?? this.message);
  }
}
