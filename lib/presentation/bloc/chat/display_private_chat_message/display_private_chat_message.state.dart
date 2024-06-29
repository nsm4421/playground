part of 'display_private_chat_message.bloc.dart';

@immutable
sealed class DisplayPrivateChatMessageState {}

final class InitialPrivateChatMessageState extends DisplayPrivateChatMessageState {}

final class PrivateChatMessageLoadingState extends DisplayPrivateChatMessageState {}

final class PrivateChatMessageSuccessState extends DisplayPrivateChatMessageState {}

final class PrivateChatMessageFailureState extends DisplayPrivateChatMessageState {
  final String message;

  PrivateChatMessageFailureState(this.message);
}
