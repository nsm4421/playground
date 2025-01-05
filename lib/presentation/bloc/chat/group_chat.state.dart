part of '../export.bloc.dart';

class GroupChatState {
  final Status status;
  late final List<MessageEntity> data;
  final String errorMessage;

  GroupChatState(
      {this.status = Status.initial,
      List<MessageEntity>? data,
      this.errorMessage = ''}) {
    this.data = data ?? [];
  }

  GroupChatState copyWith({
    Status? status,
    List<MessageEntity>? data,
    String? errorMessage,
  }) {
    return GroupChatState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
