part of '../export.bloc.dart';

final class GroupChatEvent {}

final class InitGroupChatEvent extends GroupChatEvent {
  final Status? status;
  final String? errorMessage;

  InitGroupChatEvent({this.status, this.errorMessage});
}

final class JoinGroupChatEvent extends GroupChatEvent {}

final class SendMessageEvent extends GroupChatEvent {
  final String content;
  final String currentUid;

  SendMessageEvent({required this.content, required this.currentUid});
}
