part of 'cubit.dart';

class CreateCommentState<RefEntity extends BaseEntity> {
  final RefEntity _ref;
  final Status status;
  final String content;
  final String message;

  CreateCommentState(
    this._ref, {
    this.status = Status.initial,
    this.content = '',
    this.message = '',
  });

  CreateCommentState<RefEntity> copyWith(
      {Status? status, String? content, String? message}) {
    return CreateCommentState(
      this._ref,
      status: status ?? this.status,
      content: content ?? this.content,
      message: message ?? this.message,
    );
  }
}
