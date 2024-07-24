part of "open_chat.bloc.dart";

@immutable
sealed class OpenChatEvent {}

final class CreateOpenChatEvent extends OpenChatEvent {
  final String title;
  final List<String> hashtags;
  final String createdBy;

  CreateOpenChatEvent(
      {required this.title, required this.hashtags, required this.createdBy});
}
