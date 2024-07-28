part of 'private_chat_room.bloc.dart';

final class PrivateChatRoomEvent extends ChatEvent {}

final class InitPrivateChatRoomEvent extends PrivateChatRoomEvent {
  final Status status;
  final String? message;

  InitPrivateChatRoomEvent({this.status = Status.initial, this.message});
}

final class SendPrivateChatMessageEvent extends PrivateChatRoomEvent {
  final String receiver;
  final String content;

  SendPrivateChatMessageEvent({required this.receiver, required this.content});
}

final class DeletePrivateChatMessageEvent extends PrivateChatRoomEvent {
  final String messageId;

  DeletePrivateChatMessageEvent(this.messageId);
}

final class AwareNewPrivateChatMessageEvent extends PrivateChatRoomEvent {
  final PrivateChatMessageEntity message;

  AwareNewPrivateChatMessageEvent(this.message);
}

final class AwarePrivateChatMessageDeletedEvent extends PrivateChatRoomEvent {
  final String messageId;

  AwarePrivateChatMessageDeletedEvent(this.messageId);
}

final class FetchPrivateChatMessageEvent extends PrivateChatRoomEvent {
  final int page;
  final String receiver;
  final DateTime beforeAt;

  FetchPrivateChatMessageEvent(
      {required this.page, required this.receiver, required this.beforeAt});
}
