part of 'display_private_chat.bloc.dart';

final class DisplayPrivateChatEvent extends ChatEvent {}

final class AwareNewPrivateChatEvent extends DisplayPrivateChatEvent {
  final PrivateChatMessageEntity message;

  AwareNewPrivateChatEvent(this.message);
}

final class AwarePrivateChatDeletedEvent extends DisplayPrivateChatEvent {
  final PrivateChatMessageEntity message;

  AwarePrivateChatDeletedEvent(this.message);
}

final class FetchPrivateChatEvent extends DisplayPrivateChatEvent {
  FetchPrivateChatEvent({this.isAppend = false});

  final bool isAppend;
}
