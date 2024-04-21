part of 'feed_comment.bloc.dart';

@immutable
sealed class FeedCommentEvent {}

final class InitFeedCommentStateEvent extends FeedCommentEvent {
  final String feedId;

  InitFeedCommentStateEvent(this.feedId);
}

final class CreateFeedCommentEvent extends FeedCommentEvent {
  final UserEntity currentUser;
  final String content;

  CreateFeedCommentEvent({
    required this.currentUser,
    required this.content,
  });
}

final class ModifyFeedCommentEvent extends FeedCommentEvent {
  final String commentId;
  final UserEntity currentUser;
  final String content;

  ModifyFeedCommentEvent({
    required this.commentId,
    required this.currentUser,
    required this.content,
  });
}

final class DeleteFeedCommentEvent extends FeedCommentEvent {
  final String commentId;

  DeleteFeedCommentEvent(this.commentId);
}
