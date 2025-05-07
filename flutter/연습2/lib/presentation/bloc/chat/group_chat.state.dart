part of '../export.bloc.dart';

class GroupChatState {
  final Status status;
  late final List<GroupChatMessageEntity> data;
  final String errorMessage;

  GroupChatState(
      {this.status = Status.initial,
      List<GroupChatMessageEntity>? data,
      this.errorMessage = ''}) {
    this.data = data ?? [];
  }

  GroupChatState copyWith({
    Status? status,
    List<GroupChatMessageEntity>? data,
    String? errorMessage,
  }) {
    return GroupChatState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
