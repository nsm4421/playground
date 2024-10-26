part of 'edit_comment.bloc.dart';

@sealed
class CommentEvent {}

class InitCommentEvent extends CommentEvent {
  final Status? status;
  final String? errorMessage;
  final String? content;

  InitCommentEvent({this.status, this.errorMessage, this.content});
}

class CreateCommentEvent extends CommentEvent {
  final String content;

  CreateCommentEvent(this.content);
}

class ModifyCommentEvent extends CommentEvent {
  final String commentId;
  final String content;

  ModifyCommentEvent({required this.commentId, required this.content});
}

class DeleteCommentEvent extends CommentEvent {
  final String commentId;

  DeleteCommentEvent(this.commentId);
}
