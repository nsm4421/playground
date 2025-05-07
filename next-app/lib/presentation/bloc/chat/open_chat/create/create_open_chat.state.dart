part of "create_open_chat.cubit.dart";

class CreateOpenChatState extends ChatState {
  CreateOpenChatState({super.status = Status.initial, super.message});

  @override
  CreateOpenChatState copyWith({Status? status, String? message}) {
    return CreateOpenChatState(
        status: status ?? this.status, message: message ?? this.message);
  }
}
