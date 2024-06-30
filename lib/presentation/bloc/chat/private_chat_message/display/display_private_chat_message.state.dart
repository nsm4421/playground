part of 'display_private_chat_message.bloc.dart';

@immutable
sealed class DisplayPrivateChatMessageState {}

final class InitialPrivateChatMessageState
    extends DisplayPrivateChatMessageState {}

final class PrivateChatMessageLoadingState
    extends DisplayPrivateChatMessageState {}

final class PrivateChatMessageSuccessState
    extends DisplayPrivateChatMessageState {}

final class LatestPrivateChatMessagesFetchedState
    extends PrivateChatMessageSuccessState {
  final List<PrivateChatMessageEntity> messages;

  LatestPrivateChatMessagesFetchedState(this.messages);
}

final class PrivateChatMessageFetchedState
    extends PrivateChatMessageSuccessState {
  final AccountEntity _opponent;
  final List<PrivateChatMessageEntity> messages;

  PrivateChatMessageFetchedState(
      {required AccountEntity opponent, required this.messages})
      : _opponent = opponent;
}

final class PrivateChatMessageFailureState
    extends DisplayPrivateChatMessageState {
  final String message;

  PrivateChatMessageFailureState(this.message);
}
