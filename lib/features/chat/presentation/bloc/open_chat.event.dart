part of "open_chat.bloc.dart";

@immutable
sealed class OpenChatEvent {}

final class InitOpenChatEvent extends OpenChatEvent {
  final Status status;
  final String? message;

  InitOpenChatEvent({this.status = Status.initial, this.message});
}

/// 오픈 채팅방 목록
final class InitDisplayOpenChatEvent extends InitOpenChatEvent {}

/// 오픈 채팅방 생성
final class InitCreateOpenChatEvent extends InitOpenChatEvent {}

final class CreateOpenChatEvent extends OpenChatEvent {
  final String title;
  final List<String> hashtags;

  CreateOpenChatEvent({required this.title, required this.hashtags});
}

/// 오픈 채팅방
final class InitOpenChatRoomEvent extends InitOpenChatEvent {}

final class SendOpenChatMessageEvent extends OpenChatEvent {
  final String content;
  final String chatId;

  SendOpenChatMessageEvent({required this.content, required this.chatId});
}
