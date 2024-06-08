part of "message.bloc.dart";

@immutable
sealed class MessageEvent {}

final class InitMessageEvent extends MessageEvent {}

final class SendMessageEvent extends MessageEvent {
  final ChatMessageEntity _message;

  SendMessageEvent(this._message);
}

final class DeleteChatEvent extends MessageEvent {
  final ChatEntity _chat;

  DeleteChatEvent(this._chat);
}

final class DeleteMessageEvent extends MessageEvent {
  final ChatMessageEntity _message;

  DeleteMessageEvent(this._message);
}
