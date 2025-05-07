part of "chat.bloc_module.dart";

@sealed
abstract class ChatState {
  Status status;
  String? message;

  ChatState({this.status = Status.initial, this.message});

  ChatState copyWith({Status? status, String? message});
}
