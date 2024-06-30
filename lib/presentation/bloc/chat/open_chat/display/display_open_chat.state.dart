part of 'display_open_chat.bloc.dart';

@immutable
sealed class DisplayOpenChatState {}

final class InitialDisplayOpenChatState extends DisplayOpenChatState {}

final class DisplayOpenChatLoadingState extends DisplayOpenChatState {}

final class DisplayOpenChatSuccessState extends DisplayOpenChatState {}

final class DisplayOpenChatFailureState extends DisplayOpenChatState {
  final String message;

  DisplayOpenChatFailureState(this.message);
}
