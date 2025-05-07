part of '../export.bloc.dart';

class EditFeedCommentState extends SimpleBlocState {
  final String content;

  EditFeedCommentState({
    super.status,
    super.errorMessage,
    this.content = '',
  });

  @override
  EditFeedCommentState copyWith({
    Status? status,
    String? errorMessage,
    String? content,
  }) {
    return EditFeedCommentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      content: content ?? this.content,
    );
  }
}
