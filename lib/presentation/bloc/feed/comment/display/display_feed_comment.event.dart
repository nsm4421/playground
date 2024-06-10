part of "display_feed_comment.bloc.dart";

@immutable
sealed class DisplayFeedCommentEvent {}

final class InitDisplayFeedCommentEvent extends DisplayFeedCommentEvent {}

final class FetchDisplayFeedCommentEvent extends DisplayFeedCommentEvent {}

final class ModifyDisplayFeedCommentEvent extends DisplayFeedCommentEvent {
  final FeedCommentEntity comment;

  ModifyDisplayFeedCommentEvent(this.comment);
}

final class DeleteDisplayFeedCommentEvent extends DisplayFeedCommentEvent {
  final FeedCommentEntity comment;

  DeleteDisplayFeedCommentEvent(this.comment);
}
