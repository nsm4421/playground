part of "open_chat.bloc.dart";

@immutable
sealed class OpenChatEvent {}

final class InitOpenChatEvent extends OpenChatEvent {
  final Status status;
  final String? message;

  InitOpenChatEvent({this.status = Status.initial, this.message});
}

final class CreateOpenChatEvent extends OpenChatEvent {
  final String title;
  final List<String> hashtags;

  CreateOpenChatEvent({required this.title, required this.hashtags});
}
