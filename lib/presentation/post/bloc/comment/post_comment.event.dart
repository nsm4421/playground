class PostCommentEvent {}

class InitPostComment extends PostCommentEvent {
  final String postId;

  InitPostComment(this.postId);
}

class InitChildComment extends PostCommentEvent {
  final String postId;
  final String parentCommentId;

  InitChildComment({required this.postId, required this.parentCommentId});
}

class CreatePostComment extends PostCommentEvent {
  final String postId;
  final String? parentCommentId;
  final String content;

  CreatePostComment(
      {required this.postId, this.parentCommentId, required this.content});
}

class ModifyPostComment extends PostCommentEvent {
  final String postId;
  final String commentId;
  final String content;

  ModifyPostComment(
      {required this.postId, required this.commentId, required this.content});
}

class DeletePostComment extends PostCommentEvent {
  final String postId;
  final String commentId;

  DeletePostComment({required this.postId, required this.commentId});
}
