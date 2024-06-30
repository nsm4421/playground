part of 'display_private_chat_message.bloc.dart';

@immutable
sealed class DisplayPrivateChatMessageEvent {}

final class InitPrivateChatMessageEvent
    extends DisplayPrivateChatMessageEvent {}

final class FetchLatestPrivateMessagesEvent
    extends DisplayPrivateChatMessageEvent {}

final class FetchPrivateMessagesEvent extends DisplayPrivateChatMessageEvent {
  final AccountEntity _opponent;

  FetchPrivateMessagesEvent(this._opponent);
}
