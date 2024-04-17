part of 'open_chat_message.bloc.dart';

@immutable
sealed class OpenChatMessageState {}

class InitialChatMessageState extends OpenChatMessageState {}

class ChatMessageLoadingState extends OpenChatMessageState {}

class ChatMessageSuccessState extends OpenChatMessageState {}

class ChatMessageFailureState extends OpenChatMessageState {
  final String message;

  ChatMessageFailureState(this.message);
}
