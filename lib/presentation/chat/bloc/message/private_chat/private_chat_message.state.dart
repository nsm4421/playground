part of "private_chat_message.bloc.dart";

@immutable
sealed class PrivateChatMessageState {}

final class InitialPrivateChatMessageState extends PrivateChatMessageState {}

final class PrivateChatMessageLoadingState extends PrivateChatMessageState {}

final class PrivateChatMessageSuccessState extends PrivateChatMessageState {}

final class PrivateChatMessageFailureState extends PrivateChatMessageState {
  final String message;

  PrivateChatMessageFailureState(this.message);
}
