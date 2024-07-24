part of "open_chat.bloc.dart";

class OpenChatState {
  Status status;
  String? message;

  OpenChatState({this.status = Status.initial, this.message});

  OpenChatState copyWith({Status? status, String? message}) {
    return OpenChatState(
        status: status ?? this.status, message: message ?? this.message);
  }
}

/// 오픈 채팅방 생성
class CreateOpenChatState extends OpenChatState {}
