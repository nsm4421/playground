part of 'edit_comment.bloc.dart';

class EditCommentState {
  final Status status;
  final String errorMessage;
  final String content;

  EditCommentState(
      {this.content = '',
      this.status = Status.initial,
      this.errorMessage = ''});

  EditCommentState copyWith({
    String? content,
    Status? status,
    String? errorMessage,
  }) {
    return EditCommentState(
        content: content ?? this.content,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
