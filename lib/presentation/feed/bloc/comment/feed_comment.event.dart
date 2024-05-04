part of 'feed_comment.bloc.dart';

@immutable
sealed class FeedCommentEvent {}

final class InitFeedCommentStateEvent extends FeedCommentEvent {
  final String feedId;

  InitFeedCommentStateEvent(this.feedId);
}

final class CreateFeedCommentEvent extends FeedCommentEvent {
  final FeedEntity _feed;
  final UserEntity _currentUser;
  final String _content;

  CreateFeedCommentEvent({
    required FeedEntity feed,
    required UserEntity currentUser,
    required String content,
  })  : _feed = feed,
        _currentUser = currentUser,
        _content = content;
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
