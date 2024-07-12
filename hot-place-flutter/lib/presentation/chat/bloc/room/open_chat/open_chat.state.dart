part of 'open_chat.bloc.dart';

@immutable
sealed class OpenChatState {}

class InitialOpenChatState extends OpenChatState {}

class OpenChatLoadingState extends OpenChatState {}

class OpenChatFailureState extends OpenChatState {
  final String message;

  OpenChatFailureState(this.message);
}

class OpenChatSuccessState extends OpenChatState {}
