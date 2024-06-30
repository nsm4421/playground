part of 'display_open_chat_message.bloc.dart';

@immutable
sealed class DisplayOpenChatMessageState {}

final class InitialOpenChatMessageState extends DisplayOpenChatMessageState {}

final class OpenChatMessageLoadingState extends DisplayOpenChatMessageState {}

final class OpenChatMessageSuccessState extends DisplayOpenChatMessageState {}

final class OpenChatMessageFailureState extends DisplayOpenChatMessageState {
  final String message;

  OpenChatMessageFailureState(this.message);
}
