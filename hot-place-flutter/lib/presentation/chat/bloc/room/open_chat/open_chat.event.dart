part of 'open_chat.bloc.dart';

@immutable
sealed class OpenChatEvent {}

class InitOpenChatEvent extends OpenChatEvent {}

class GetOpenChatStreamEvent extends OpenChatEvent {}

class CreateOpenChatEvent extends OpenChatEvent {
  final String title;
  final List<String> hashtags;
  final UserEntity currentUser;

  CreateOpenChatEvent(
      {required this.title, required this.hashtags, required this.currentUser});
}
