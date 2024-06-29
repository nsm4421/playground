part of 'display_private_chat_message.bloc.dart';

@immutable
sealed class DisplayPrivateChatMessageEvent {}

final class InitPrivateChatMessageEvent extends DisplayPrivateChatMessageEvent {}
