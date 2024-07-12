part of 'open_chat_message.bloc.dart';

@immutable
sealed class OpenChatMessageState {}

class InitialOpenChatMessageState extends OpenChatMessageState {}

class OpenChatMessageLoadingState extends OpenChatMessageState {}

class OpenChatMessageSuccessState extends OpenChatMessageState {}

class OpenChatMessageFailureState extends OpenChatMessageState {
  final String message;

  OpenChatMessageFailureState(this.message);
}
