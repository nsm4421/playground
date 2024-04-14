part of 'chat_message.bloc.dart';

@immutable
sealed class ChatMessageState {}

class InitialChatMessageState extends ChatMessageState {}

class ChatMessageLoadingState extends ChatMessageState {}

class ChatMessageSuccessState extends ChatMessageState {}

class ChatMessageFailureState extends ChatMessageState {
  final String message;

  ChatMessageFailureState(this.message);
}
