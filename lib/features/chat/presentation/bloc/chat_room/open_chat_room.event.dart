part of "open_chat_room.bloc.dart";

final class OpenChatRoomEvent extends ChatEvent {}

final class InitOpenChatRoomEvent extends OpenChatRoomEvent {
  final Status status;
  final String? message;

  InitOpenChatRoomEvent({this.status = Status.initial, this.message});
}

final class SendOpenChatMessageEvent extends OpenChatRoomEvent {
  final String content;

  SendOpenChatMessageEvent({required this.content});
}

final class NewOpenChatMessageEvent extends OpenChatRoomEvent {
  final ChatMessageEntity message;

  NewOpenChatMessageEvent(this.message);
}

final class FetchOpenChatMessageEvent extends OpenChatRoomEvent {
  final int page;

  FetchOpenChatMessageEvent(this.page);
}
