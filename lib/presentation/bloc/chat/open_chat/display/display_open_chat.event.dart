part of 'display_open_chat.bloc.dart';

@immutable
sealed class DisplayOpenChatEvent {}

final class InitDisplayOpenChatEvent extends DisplayOpenChatEvent {}

final class DeleteOpenChatEvent extends DisplayOpenChatEvent {
  final String chatId;

  DeleteOpenChatEvent(this.chatId);
}
